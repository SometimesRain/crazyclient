package kabam.rotmg.minimap.view {
import com.company.assembleegameclient.map.AbstractMap;
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.objects.Character;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.GuildHallPortal;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.Portal;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.menu.PlayerGroupMenu;
import com.company.assembleegameclient.ui.tooltip.PlayerGroupToolTip;
import com.company.util.AssetLibrary;
import com.company.util.PointUtil;
import com.company.util.RectangleUtil;

import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Shape;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

public class MiniMapImp extends MiniMap {

    public static const MOUSE_DIST_SQ:int = 25; //5*5
    private static var objectTypeColorDict_:Dictionary = new Dictionary();

    public var _width:int;
    public var _height:int;
    public var zoomIndex:int = 0;
    public var windowRect_:Rectangle;
    public var active:Boolean = true;
    public var maxWH_:Point;
    public var miniMapData_:BitmapData;
    public var zoomLevels:Vector.<Number>;
    public var blueArrow_:BitmapData;
    public var groundLayer_:Shape;
    public var characterLayer_:Shape;
    private var focus:GameObject;
    private var zoomButtons:MiniMapZoomButtons;
    private var isMouseOver:Boolean = false;
    private var tooltip:PlayerGroupToolTip = null;
    private var menu:PlayerGroupMenu = null;
    private var mapMatrix_:Matrix;
    private var arrowMatrix_:Matrix;
    private var players_:Vector.<Player>;
    private var tempPoint:Point;
    private var _rotateEnableFlag:Boolean;

    public function MiniMapImp(_arg_1:int, _arg_2:int) {
        this.zoomLevels = new Vector.<Number>();
        this.mapMatrix_ = new Matrix();
        this.arrowMatrix_ = new Matrix();
        this.players_ = new Vector.<Player>();
        this.tempPoint = new Point();
        super();
        this._width = _arg_1;
        this._height = _arg_2;
        this._rotateEnableFlag = Parameters.data_.allowMiniMapRotation;
        this.makeVisualLayers();
        this.addMouseListeners();
    }

    public static function gameObjectToColor(_arg_1:GameObject):uint {
        var _local_2:* = _arg_1.objectType_;
        if (!objectTypeColorDict_.hasOwnProperty(_local_2)) {
            objectTypeColorDict_[_local_2] = _arg_1.getColor();
        }
        return (objectTypeColorDict_[_local_2]);
    }


    override public function setMap(_arg_1:AbstractMap):void {
        this.map = _arg_1;
        this.makeViewModel();
    }

    override public function setFocus(_arg_1:GameObject):void {
        this.focus = _arg_1;
    }

    private function makeViewModel():void {
        this.windowRect_ = new Rectangle((-(this._width) / 2), (-(this._height) / 2), this._width, this._height);
        this.maxWH_ = new Point(map.width_, map.height_);
        this.miniMapData_ = new BitmapDataSpy(this.maxWH_.x, this.maxWH_.y, false, 0);
        var _local_1:Number = Math.max((this._width / this.maxWH_.x), (this._height / this.maxWH_.y));
        var _local_2:Number = 4;
        while (_local_2 > _local_1) {
            this.zoomLevels.push(_local_2);
            _local_2 = (_local_2 / 2);
        }
        this.zoomLevels.push(_local_1);
        ((this.zoomButtons) && (this.zoomButtons.setZoomLevels(this.zoomLevels.length)));
    }

    private function makeVisualLayers():void {
        this.blueArrow_ = AssetLibrary.getImageFromSet("lofiInterface", 54).clone();
        this.blueArrow_.colorTransform(this.blueArrow_.rect, new ColorTransform(0, 0, 1));
        graphics.clear();
        graphics.beginFill(0x1B1B1B);
        graphics.drawRect(0, 0, this._width, this._height);
        graphics.endFill();
        this.groundLayer_ = new Shape();
        this.groundLayer_.x = (this._width / 2);
        this.groundLayer_.y = (this._height / 2);
        addChild(this.groundLayer_);
        this.characterLayer_ = new Shape();
        this.characterLayer_.x = (this._width / 2);
        this.characterLayer_.y = (this._height / 2);
        addChild(this.characterLayer_);
        this.zoomButtons = new MiniMapZoomButtons();
        this.zoomButtons.x = (this._width - 20);
        this.zoomButtons.zoom.add(this.onZoomChanged);
        this.zoomButtons.setZoomLevels(this.zoomLevels.length);
        addChild(this.zoomButtons);
    }

    private function addMouseListeners():void {
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        addEventListener(MouseEvent.RIGHT_CLICK, this.onMapRightClick);
        addEventListener(MouseEvent.CLICK, this.onMapClick);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        this.active = false;
        this.removeDecorations();
    }

    public function dispose():void {
        this.miniMapData_.dispose();
        this.miniMapData_ = null;
        this.removeDecorations();
    }

    private function onZoomChanged(_arg_1:int):void {
        this.zoomIndex = _arg_1;
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        this.isMouseOver = true;
    }

    private function onMouseOut(_arg_1:MouseEvent):void {
        this.isMouseOver = false;
    }

    private function onMapRightClick(_arg_1:MouseEvent):void {
		if (players_.length != 0) {
			players_[0].map_.gs_.gsc_.playerText("/teleport "+players_[0].name_);
		}
        //this._rotateEnableFlag = ((!(this._rotateEnableFlag)) && (Parameters.data_.allowMiniMapRotation));
    }

    private function onMapClick(_arg_1:MouseEvent):void {
        if ((((((((this.tooltip == null)) || ((this.tooltip.parent == null)))) || ((this.tooltip.players_ == null)))) || ((this.tooltip.players_.length == 0)))) {
            return;
        }
        this.removeMenu();
        this.addMenu();
        this.removeTooltip();
    }

    private function addMenu():void {
        this.menu = new PlayerGroupMenu(map, this.tooltip.players_);
        this.menu.x = (this.tooltip.x + 12);
        this.menu.y = this.tooltip.y;
        menuLayer.addChild(this.menu);
    }

    override public function setGroundTile(_arg_1:int, _arg_2:int, _arg_3:uint):void {
        var _local_4:uint = GroundLibrary.getColor(_arg_3);
        this.miniMapData_.setPixel(_arg_1, _arg_2, _local_4);
    }

    override public function setGameObjectTile(_arg_1:int, _arg_2:int, _arg_3:GameObject):void {
        var _local_4:uint = gameObjectToColor(_arg_3);
        this.miniMapData_.setPixel(_arg_1, _arg_2, _local_4);
    }

    private function removeDecorations():void {
        this.removeTooltip();
        this.removeMenu();
    }

    private function removeTooltip():void {
        if (this.tooltip != null) {
            if (this.tooltip.parent != null) {
                this.tooltip.parent.removeChild(this.tooltip);
            }
            this.tooltip = null;
        }
    }

    private function removeMenu():void {
        if (this.menu != null) {
            if (this.menu.parent != null) {
                this.menu.parent.removeChild(this.menu);
            }
            this.menu = null;
        }
    }

    override public function draw():void {
        var _local_7:Graphics;
        var _local_10:GameObject;
        var _local_15:uint;
        var _local_16:Player;
        var _local_17:Number;
        var _local_18:Number;
        var _local_19:Number;
        var _local_20:Number;
        var _local_21:Number;
        this._rotateEnableFlag = ((this._rotateEnableFlag) && (Parameters.data_.allowMiniMapRotation));
        this.groundLayer_.graphics.clear();
        this.characterLayer_.graphics.clear();
        if (!this.focus) {
            return;
        }
        if (!this.active) {
            return;
        }
        var _local_1:Number = this.zoomLevels[this.zoomIndex];
        this.mapMatrix_.identity();
        this.mapMatrix_.translate(-(this.focus.x_), -(this.focus.y_));
        this.mapMatrix_.scale(_local_1, _local_1);
        var _local_2:Point = this.mapMatrix_.transformPoint(PointUtil.ORIGIN);
        var _local_3:Point = this.mapMatrix_.transformPoint(this.maxWH_);
        var _local_4:Number = 0;
        if (_local_2.x > this.windowRect_.left) {
            _local_4 = (this.windowRect_.left - _local_2.x);
        }
        else {
            if (_local_3.x < this.windowRect_.right) {
                _local_4 = (this.windowRect_.right - _local_3.x);
            }
        }
        var _local_5:Number = 0;
        if (_local_2.y > this.windowRect_.top) {
            _local_5 = (this.windowRect_.top - _local_2.y);
        }
        else {
            if (_local_3.y < this.windowRect_.bottom) {
                _local_5 = (this.windowRect_.bottom - _local_3.y);
            }
        }
        this.mapMatrix_.translate(_local_4, _local_5);
        _local_2 = this.mapMatrix_.transformPoint(PointUtil.ORIGIN);
        if ((((_local_1 >= 1)) && (this._rotateEnableFlag))) {
            this.mapMatrix_.rotate(-(Parameters.data_.cameraAngle));
        }
        var _local_6:Rectangle = new Rectangle();
        _local_6.x = Math.max(this.windowRect_.x, _local_2.x);
        _local_6.y = Math.max(this.windowRect_.y, _local_2.y);
        _local_6.right = Math.min(this.windowRect_.right, (_local_2.x + (this.maxWH_.x * _local_1)));
        _local_6.bottom = Math.min(this.windowRect_.bottom, (_local_2.y + (this.maxWH_.y * _local_1)));
        _local_7 = this.groundLayer_.graphics;
        _local_7.beginBitmapFill(this.miniMapData_, this.mapMatrix_, false);
        _local_7.drawRect(_local_6.x, _local_6.y, _local_6.width, _local_6.height);
        _local_7.endFill();
        _local_7 = this.characterLayer_.graphics;
        var _local_8:Number = (mouseX - (this._width / 2));
        var _local_9:Number = (mouseY - (this._height / 2));
        this.players_.length = 0;
        for each (_local_10 in map.goDict_) {
            if (!(_local_10.props_.noMiniMap_ || _local_10 == this.focus)) {
                _local_16 = (_local_10 as Player);
                if (_local_16 != null) {
					if (map.name_ == "Nexus" && _local_16.numStars_ <= Parameters.data_.chatStarRequirement && Parameters.data_.HidePlayerFilter) {
						continue;
					}
                    if (_local_16.isPaused()) {
                        _local_15 = 0x7F7F7F;
                    }
                    else { //minimap color
						if (Parameters.data_.lockHighlight && _local_16.starred_)
						{
							_local_15 = 4240365;
						}
                        else if (_local_16.isFellowGuild_) {
                            _local_15 = 0xFF00;
                        }
                        else {
                            _local_15 = 0xFFFF00;
                        }
                    }
                }
                else {
                    if (_local_10 is Character) {
                        if (_local_10.props_.isEnemy_) {
                            _local_15 = 0xFF0000;
                        }
                        else {
                            _local_15 = gameObjectToColor(_local_10);
                        }
                    }
                    else {
                        if ((((_local_10 is Portal)) || ((_local_10 is GuildHallPortal)))) {
                            _local_15 = 0xFF;
                        }
                        else {
                            continue;
                        }
                    }
                }
                _local_17 = (((this.mapMatrix_.a * _local_10.x_) + (this.mapMatrix_.c * _local_10.y_)) + this.mapMatrix_.tx);
                _local_18 = (((this.mapMatrix_.b * _local_10.x_) + (this.mapMatrix_.d * _local_10.y_)) + this.mapMatrix_.ty);
                if ((((((((_local_17 <= (-(this._width) / 2))) || ((_local_17 >= (this._width / 2))))) || ((_local_18 <= (-(this._height) / 2))))) || ((_local_18 >= (this._height / 2))))) {
                    RectangleUtil.lineSegmentIntersectXY(this.windowRect_, 0, 0, _local_17, _local_18, this.tempPoint);
                    _local_17 = this.tempPoint.x;
                    _local_18 = this.tempPoint.y;
                }
                if (((((!((_local_16 == null))) && (this.isMouseOver))) && ((((this.menu == null)) || ((this.menu.parent == null)))))) {
                    _local_19 = (_local_8 - _local_17);
                    _local_20 = (_local_9 - _local_18);
                    _local_21 = ((_local_19 * _local_19) + (_local_20 * _local_20));
                    if (_local_21 < MOUSE_DIST_SQ) {
                        this.players_.push(_local_16);
                    }
                }
                _local_7.beginFill(_local_15);
                _local_7.drawRect((_local_17 - 2), (_local_18 - 2), 4, 4);
                _local_7.endFill();
            }
        }
        if (this.players_.length != 0) {
            if (this.tooltip == null) {
                this.tooltip = new PlayerGroupToolTip(this.players_);
                menuLayer.addChild(this.tooltip);
            }
            else {
                if (!this.areSamePlayers(this.tooltip.players_, this.players_)) {
                    this.tooltip.setPlayers(this.players_);
                }
            }
        }
        else {
            if (this.tooltip != null) {
                if (this.tooltip.parent != null) {
                    this.tooltip.parent.removeChild(this.tooltip);
                }
                this.tooltip = null;
            }
        }
        var _local_11:Number = this.focus.x_;
        var _local_12:Number = this.focus.y_;
        var _local_13:Number = (((this.mapMatrix_.a * _local_11) + (this.mapMatrix_.c * _local_12)) + this.mapMatrix_.tx);
        var _local_14:Number = (((this.mapMatrix_.b * _local_11) + (this.mapMatrix_.d * _local_12)) + this.mapMatrix_.ty);
        this.arrowMatrix_.identity();
        this.arrowMatrix_.translate(-4, -5);
        this.arrowMatrix_.scale((8 / this.blueArrow_.width), (32 / this.blueArrow_.height));
        if (!(((_local_1 >= 1)) && (this._rotateEnableFlag))) {
            this.arrowMatrix_.rotate(Parameters.data_.cameraAngle);
        }
        this.arrowMatrix_.translate(_local_13, _local_14);
        _local_7.beginBitmapFill(this.blueArrow_, this.arrowMatrix_, false);
        _local_7.drawRect((_local_13 - 16), (_local_14 - 16), 32, 32);
        _local_7.endFill();
    }

    private function areSamePlayers(_arg_1:Vector.<Player>, _arg_2:Vector.<Player>):Boolean {
        var _local_3:int = _arg_1.length;
        if (_local_3 != _arg_2.length) {
            return (false);
        }
        var _local_4:int;
        while (_local_4 < _local_3) {
            if (_arg_1[_local_4] != _arg_2[_local_4]) {
                return (false);
            }
            _local_4++;
        }
        return (true);
    }

    override public function zoomIn():void {
        this.zoomIndex = this.zoomButtons.setZoomLevel((this.zoomIndex - 1));
    }

    override public function zoomOut():void {
        this.zoomIndex = this.zoomButtons.setZoomLevel((this.zoomIndex + 1));
    }

    override public function deactivate():void {
    }


}
}//package kabam.rotmg.minimap.view
