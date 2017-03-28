package com.company.assembleegameclient.mapeditor {
import com.adobe.images.PNGEncoder;
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.map.RegionLibrary;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.AssetLibrary;
import com.company.util.IntPoint;
import com.company.util.KeyCodes;
import com.company.util.PointUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.ui.Keyboard;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

public class MEMap extends Sprite {

    private static var transbackgroundEmbed_:Class = MEMap_transbackgroundEmbed_;
    private static var transbackgroundBD_:BitmapData = new transbackgroundEmbed_().bitmapData;
    public static var NUM_SQUARES:int = 128;
    public static const MAX_ALLOWED_SQUARES:int = 512;
    public static const SQUARE_SIZE:int = 16;
    public static const SIZE:int = 512;

    public var tileDict_:Dictionary;
    public var fullMap_:BigBitmapData;
    public var regionMap_:BitmapData;
    public var map_:BitmapData;
    public var overlay_:Shape;
    public var anchorLock:Boolean = false;
    public var posT_:IntPoint;
    public var zoom_:Number = 1;
    private var mouseRectAnchorT_:IntPoint = null;
    private var mouseMoveAnchorT_:IntPoint = null;
    private var rectWidthOverride:int = 0;
    private var rectHeightOverride:int = 0;
    private var invisibleTexture_:BitmapData;
    private var replaceTexture_:BitmapData;
    private var objectLayer_:BigBitmapData;
    private var groundLayer_:BigBitmapData;
    private var ifShowObjectLayer_:Boolean = true;
    private var ifShowGroundLayer_:Boolean = true;
    private var ifShowRegionLayer_:Boolean = true;

    public function MEMap() {
        this.tileDict_ = new Dictionary();
        this.fullMap_ = new BigBitmapData((NUM_SQUARES * SQUARE_SIZE), (NUM_SQUARES * SQUARE_SIZE), true, 0);
        this.regionMap_ = new BitmapDataSpy(NUM_SQUARES, NUM_SQUARES, true, 0);
        this.map_ = new BitmapDataSpy(SIZE, SIZE, true, 0);
        this.overlay_ = new Shape();
        this.objectLayer_ = new BigBitmapData(NUM_SQUARES * SQUARE_SIZE, NUM_SQUARES * SQUARE_SIZE, true, 0);
        this.groundLayer_ = new BigBitmapData(NUM_SQUARES * SQUARE_SIZE, NUM_SQUARES * SQUARE_SIZE, true, 0);
        super();
        graphics.beginBitmapFill(transbackgroundBD_, null, true);
        graphics.drawRect(0, 0, SIZE, SIZE);
        addChild(new Bitmap(this.map_));
        addChild(this.overlay_);
        this.posT_ = new IntPoint(((NUM_SQUARES / 2) - (this.sizeInTiles() / 2)), ((NUM_SQUARES / 2) - (this.sizeInTiles() / 2)));
        this.invisibleTexture_ = AssetLibrary.getImageFromSet("invisible", 0);
        this.replaceTexture_ = AssetLibrary.getImageFromSet("lofiObj3", 0xFF);
        this.draw();
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private static function minZoom():Number
    {
        return SQUARE_SIZE / NUM_SQUARES * 2;
    }

    private static function maxZoom():Number
    {
        return SQUARE_SIZE;
    }

    public function set ifShowObjectLayer(_arg_1:Boolean):void
    {
        this.ifShowObjectLayer_ = _arg_1;
    }

    public function set ifShowGroundLayer(_arg_1:Boolean):void
    {
        this.ifShowGroundLayer_ = _arg_1;
    }

    public function set ifShowRegionLayer(_arg_1:Boolean):void
    {
        this.ifShowRegionLayer_ = _arg_1;
    }

    public function resize(_arg_1:Number):void
    {
        var _local_4:METile;
        var _local_5:int;
        var _local_6:int;
        var _local_7:int;
        var _local_8:*;
        var _local_2:Dictionary = this.tileDict_;
        var _local_3:int = NUM_SQUARES;
        NUM_SQUARES = _arg_1;
        this.setZoom(minZoom());
        this.tileDict_ = new Dictionary();
        this.fullMap_ = new BigBitmapData(NUM_SQUARES * SQUARE_SIZE, NUM_SQUARES * SQUARE_SIZE, true, 0);
        this.objectLayer_ = new BigBitmapData(NUM_SQUARES * SQUARE_SIZE, NUM_SQUARES * SQUARE_SIZE, true, 0);
        this.groundLayer_ = new BigBitmapData(NUM_SQUARES * SQUARE_SIZE, NUM_SQUARES * SQUARE_SIZE, true, 0);
        this.regionMap_ = new BitmapDataSpy(NUM_SQUARES, NUM_SQUARES, true, 0);
        for(_local_8 in _local_2)
        {
            _local_4 = _local_2[_local_8];
            if(_local_4.isEmpty())
            {
                _local_4 = null;
            }
            else
            {
                _local_5 = int(_local_8);
                _local_6 = _local_5 % _local_3;
                _local_7 = _local_5 / _local_3;
                if(_local_6 < NUM_SQUARES && _local_7 < NUM_SQUARES)
                {
                    this.setTile(_local_6, _local_7, _local_4);
                }
            }
        }
        _local_2 = null;
    }

    public function getType(_arg_1:int, _arg_2:int, _arg_3:int):int {
        var _local_4:METile = this.getTile(_arg_1, _arg_2);
        if (_local_4 == null) {
            return (-1);
        }
        return (_local_4.types_[_arg_3]);
    }

    public function getTile(_arg_1:int, _arg_2:int):METile {
        return (this.tileDict_[(_arg_1 + (_arg_2 * NUM_SQUARES))]);
    }

    public function modifyTile(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void {
        var x:int = _arg_1;
        var y:int = _arg_2;
        var layer:int = _arg_3;
        var type:int = _arg_4;
        var tile:METile = this.getOrCreateTile(x, y);
        if(tile.types_[layer] == type)
        {
            return;
        }
        tile.types_[layer] = type;
        try
        {
            this.drawTile(x, y, tile);
            return;
        }
        catch(error:Error)
        {
            throw new Error("Invalid type: 0x" + type.toString(16) + " at location: " + x + " x, " + y + " y");
        }
    }

    public function getObjectName(_arg_1:int, _arg_2:int):String {
        var _local_3:METile = this.getTile(_arg_1, _arg_2);
        if (_local_3 == null) {
            return (null);
        }
        return (_local_3.objName_);
    }

    public function modifyObjectName(_arg_1:int, _arg_2:int, _arg_3:String):void {
        var _local_4:METile = this.getOrCreateTile(_arg_1, _arg_2);
        _local_4.objName_ = _arg_3;
    }

    public function getAllTiles():Vector.<IntPoint> {
        var _local_2:String;
        var _local_3:int;
        var _local_1:Vector.<IntPoint> = new Vector.<IntPoint>();
        for (_local_2 in this.tileDict_) {
            _local_3 = int(_local_2);
            _local_1.push(new IntPoint((_local_3 % NUM_SQUARES), (_local_3 / NUM_SQUARES)));
        }
        return (_local_1);
    }

    public function setTile(_arg_1:int, _arg_2:int, _arg_3:METile):void {
        _arg_3 = _arg_3.clone();
        this.tileDict_[(_arg_1 + (_arg_2 * NUM_SQUARES))] = _arg_3;
        this.drawTile(_arg_1, _arg_2, _arg_3);
        _arg_3 = null;
    }

    public function eraseTile(_arg_1:int, _arg_2:int):void {
        this.clearTile(_arg_1, _arg_2);
        this.drawTile(_arg_1, _arg_2, null);
    }

    public function toggleLayers(_arg_1:Array):void
    {
    }

    public function clear():void {
        var _local_1:String;
        var _local_2:int;
        for (_local_1 in this.tileDict_) {
            _local_2 = int(_local_1);
            this.eraseTile((_local_2 % NUM_SQUARES), (_local_2 / NUM_SQUARES));
        }
    }

    public function getTileBounds():Rectangle {
        var _local_5:String;
        var _local_6:METile;
        var _local_7:int;
        var _local_8:int;
        var _local_9:int;
        var _local_1:int = NUM_SQUARES;
        var _local_2:int = NUM_SQUARES;
        var _local_3:int = 0;
        var _local_4:int = 0;
        for (_local_5 in this.tileDict_) {
            _local_6 = this.tileDict_[_local_5];
            if (!_local_6.isEmpty()) {
                _local_7 = int(_local_5);
                _local_8 = (_local_7 % NUM_SQUARES);
                _local_9 = (_local_7 / NUM_SQUARES);
                if (_local_8 < _local_1) {
                    _local_1 = _local_8;
                }
                if (_local_9 < _local_2) {
                    _local_2 = _local_9;
                }
                if ((_local_8 + 1) > _local_3) {
                    _local_3 = (_local_8 + 1);
                }
                if ((_local_9 + 1) > _local_4) {
                    _local_4 = (_local_9 + 1);
                }
            }
        }
        if (_local_1 > _local_3) {
            return (null);
        }
        return (new Rectangle(_local_1, _local_2, (_local_3 - _local_1), (_local_4 - _local_2)));
    }

    private function sizeInTiles():int {
        return ((SIZE / (SQUARE_SIZE * this.zoom_)));
    }

    private function modifyZoom(_arg_1:Number):void {
        if(_arg_1 > 1 && this.zoom_ >= maxZoom() || _arg_1 < 1 && this.zoom_ <= minZoom()) {
            return;
        }
        var _local_2:IntPoint = this.mousePosT();
        this.zoom_ = (this.zoom_ * _arg_1);
        var _local_3:IntPoint = this.mousePosT();
        this.movePosT((_local_2.x_ - _local_3.x_), (_local_2.y_ - _local_3.y_));
    }

    private function setZoom(_arg_1:Number):void
    {
        if(_arg_1 > maxZoom() || _arg_1 < minZoom())
        {
            return;
        }
        var _local_2:IntPoint = this.mousePosT();
        this.zoom_ = _arg_1;
        var _local_3:IntPoint = this.mousePosT();
        this.movePosT(_local_2.x_ - _local_3.x_, _local_2.y_ - _local_3.y_);
    }

    public function setMinZoom(_arg_1:Number = 0):void
    {
        if(_arg_1 != 0)
        {
            this.setZoom(_arg_1);
        }
        else
        {
            this.setZoom(minZoom());
        }
    }

    private function canMove():Boolean {
        return ((((this.mouseRectAnchorT_ == null)) && ((this.mouseMoveAnchorT_ == null))));
    }

    private function increaseZoom():void {
        if (!this.canMove()) {
            return;
        }
        this.modifyZoom(2);
        this.draw();
    }

    private function decreaseZoom():void {
        if (!this.canMove()) {
            return;
        }
        this.modifyZoom(0.5);
        this.draw();
    }

    private function moveLeft():void {
        if (!this.canMove()) {
            return;
        }
        this.movePosT(-1, 0);
        this.draw();
    }

    private function moveRight():void {
        if (!this.canMove()) {
            return;
        }
        this.movePosT(1, 0);
        this.draw();
    }

    private function moveUp():void {
        if (!this.canMove()) {
            return;
        }
        this.movePosT(0, -1);
        this.draw();
    }

    private function moveDown():void {
        if (!this.canMove()) {
            return;
        }
        this.movePosT(0, 1);
        this.draw();
    }

    private function movePosT(_arg_1:int, _arg_2:int):void {
        var _local_3:int = 0;
        var _local_4:int = (NUM_SQUARES - this.sizeInTiles());
        this.posT_.x_ = Math.max(_local_3, Math.min(_local_4, (this.posT_.x_ + _arg_1)));
        this.posT_.y_ = Math.max(_local_3, Math.min(_local_4, (this.posT_.y_ + _arg_2)));
    }

    private function mousePosT():IntPoint {
        var _local_1:int = Math.max(0, Math.min((SIZE - 1), mouseX));
        var _local_2:int = Math.max(0, Math.min((SIZE - 1), mouseY));
        return (new IntPoint((this.posT_.x_ + (_local_1 / (SQUARE_SIZE * this.zoom_))), (this.posT_.y_ + (_local_2 / (SQUARE_SIZE * this.zoom_)))));
    }

    public function mouseRectT():Rectangle {
        var _local_1:IntPoint = this.mousePosT();
        if (this.mouseRectAnchorT_ == null) {
            return (new Rectangle(_local_1.x_, _local_1.y_, 1, 1));
        }
        return (new Rectangle(Math.min(_local_1.x_, this.mouseRectAnchorT_.x_), Math.min(_local_1.y_, this.mouseRectAnchorT_.y_), (Math.abs((_local_1.x_ - this.mouseRectAnchorT_.x_)) + 1), (Math.abs((_local_1.y_ - this.mouseRectAnchorT_.y_)) + 1)));
    }

    private function posTToPosP(_arg_1:IntPoint):IntPoint {
        return (new IntPoint((((_arg_1.x_ - this.posT_.x_) * SQUARE_SIZE) * this.zoom_), (((_arg_1.y_ - this.posT_.y_) * SQUARE_SIZE) * this.zoom_)));
    }

    private function sizeTToSizeP(_arg_1:int):Number {
        return (((_arg_1 * this.zoom_) * SQUARE_SIZE));
    }

    private function mouseRectP():Rectangle {
        var _local_1:Rectangle = this.mouseRectT();
        var _local_2:IntPoint = this.posTToPosP(new IntPoint(_local_1.x, _local_1.y));
        _local_1.x = _local_2.x_;
        _local_1.y = _local_2.y_;
        _local_1.width = (this.sizeTToSizeP(_local_1.width) - 1);
        _local_1.height = (this.sizeTToSizeP(_local_1.height) - 1);
        return (_local_1);
    }

    private function onAddedToStage(_arg_1:Event):void {
        addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
        addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
        addEventListener(MouseEvent.RIGHT_CLICK, this.onMouseRightClick);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
        removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
    }

    private function onKeyDown(_arg_1:KeyboardEvent):void {
        switch (_arg_1.keyCode) {
            case Keyboard.SHIFT:
                if (this.mouseRectAnchorT_ != null) break;
                this.mouseRectAnchorT_ = this.mousePosT();
                this.draw();
                break;
            case Keyboard.CONTROL:
                if (this.mouseMoveAnchorT_ != null) break;
                this.mouseMoveAnchorT_ = this.mousePosT();
                this.draw();
                break;
            case Keyboard.LEFT:
                this.moveLeft();
                break;
            case Keyboard.RIGHT:
                this.moveRight();
                break;
            case Keyboard.UP:
                this.moveUp();
                break;
            case Keyboard.DOWN:
                this.moveDown();
                break;
            case KeyCodes.MINUS:
                this.decreaseZoom();
                break;
            case KeyCodes.EQUAL:
                this.increaseZoom();
                break;
        }
    }

    private function onKeyUp(_arg_1:KeyboardEvent):void {
        switch (_arg_1.keyCode) {
            case Keyboard.SHIFT:
                this.mouseRectAnchorT_ = null;
                this.draw();
                break;
            case Keyboard.CONTROL:
                this.mouseMoveAnchorT_ = null;
                this.draw();
                break;
        }
    }

    public function clearSelectRect():void
    {
        this.mouseRectAnchorT_ = null;
        this.anchorLock = false;
    }

    private function onMouseRightClick(_arg_1:MouseEvent):void
    {
    }

    private function onMouseWheel(_arg_1:MouseEvent):void {
        if (_arg_1.delta > 0) {
            this.increaseZoom();
        }
        else {
            if (_arg_1.delta < 0) {
                this.decreaseZoom();
            }
        }
    }

    private function onMouseDown(_arg_1:MouseEvent):void {
        var _local_7:int;
        var _local_2:Rectangle = this.mouseRectT();
        var _local_3:Vector.<IntPoint> = new Vector.<IntPoint>();
        var _local_4:int = Math.max((_local_2.x + this.rectWidthOverride), _local_2.right);
        var _local_5:int = Math.max((_local_2.y + this.rectHeightOverride), _local_2.bottom);
        var _local_6:int = _local_2.x;
        while (_local_6 < _local_4) {
            _local_7 = _local_2.y;
            while (_local_7 < _local_5) {
                _local_3.push(new IntPoint(_local_6, _local_7));
                _local_7++;
            }
            _local_6++;
        }
        dispatchEvent(new TilesEvent(_local_3));
    }

    public function freezeSelect():void {
        var _local_1:Rectangle = this.mouseRectT();
        this.rectWidthOverride = _local_1.width;
        this.rectHeightOverride = _local_1.height;
    }

    public function clearSelect():void {
        this.rectHeightOverride = 0;
        this.rectWidthOverride = 0;
    }

    private function onMouseMove(_arg_1:MouseEvent):void {
        var _local_2:IntPoint;
        if (!_arg_1.shiftKey) {
            this.mouseRectAnchorT_ = null;
        }
        else {
            if (this.mouseRectAnchorT_ == null) {
                this.mouseRectAnchorT_ = this.mousePosT();
            }
        }
        if (!_arg_1.ctrlKey) {
            this.mouseMoveAnchorT_ = null;
        }
        else {
            if (this.mouseMoveAnchorT_ == null) {
                this.mouseMoveAnchorT_ = this.mousePosT();
            }
        }
        if (_arg_1.buttonDown) {
            dispatchEvent(new TilesEvent(new <IntPoint>[this.mousePosT()]));
        }
        if (this.mouseMoveAnchorT_ != null) {
            _local_2 = this.mousePosT();
            this.movePosT((this.mouseMoveAnchorT_.x_ - _local_2.x_), (this.mouseMoveAnchorT_.y_ - _local_2.y_));
            this.draw();
        }
        else {
            this.drawOverlay();
        }
    }

    private function getOrCreateTile(_arg_1:int, _arg_2:int):METile {
        var _local_3:int = (_arg_1 + (_arg_2 * NUM_SQUARES));
        var _local_4:METile = this.tileDict_[_local_3];
        if (_local_4 != null) {
            return (_local_4);
        }
        _local_4 = new METile();
        this.tileDict_[_local_3] = _local_4;
        return (_local_4);
    }

    private function clearTile(_arg_1:int, _arg_2:int):void {
        delete this.tileDict_[(_arg_1 + (_arg_2 * NUM_SQUARES))];
    }

    private function drawTile(_arg_1:int, _arg_2:int, _arg_3:METile):void {
        var _local_5:BitmapData;
        var _local_6:BitmapData;
        var _local_7:uint;
        var _local_4:Rectangle = new Rectangle((_arg_1 * SQUARE_SIZE), (_arg_2 * SQUARE_SIZE), SQUARE_SIZE, SQUARE_SIZE);
        this.fullMap_.erase(_local_4);
        this.groundLayer_.erase(_local_4);
        this.objectLayer_.erase(_local_4);
        this.regionMap_.setPixel32(_arg_1, _arg_2, 0);
        if (_arg_3 == null) {
            this.groundLayer_.erase(_local_4);
            this.objectLayer_.erase(_local_4);
            return;
        }
        if (_arg_3.types_[Layer.GROUND] != -1) {
            _local_5 = GroundLibrary.getBitmapData(_arg_3.types_[Layer.GROUND]);
            this.groundLayer_.copyTo(_local_5, _local_5.rect, _local_4);
        }
        if (_arg_3.types_[Layer.OBJECT] != -1) {
            _local_6 = ObjectLibrary.getTextureFromType(_arg_3.types_[Layer.OBJECT]);
            if ((((_local_6 == null)) || ((_local_6 == this.invisibleTexture_)))) {
                this.objectLayer_.copyTo(_local_5, _local_5.rect, _local_4);
            }
            else {
                this.fullMap_.copyTo(_local_6, _local_6.rect, _local_4);
            }
        }
        if (_arg_3.types_[Layer.REGION] != -1) {
            _local_7 = RegionLibrary.getColor(_arg_3.types_[Layer.REGION]);
            this.regionMap_.setPixel32(_arg_1, _arg_2, (0x5F000000 | _local_7));
        }
    }

    private function drawOverlay():void {
        var _local_1:Rectangle = this.mouseRectP();
        var _local_2:Graphics = this.overlay_.graphics;
        _local_2.clear();
        _local_2.lineStyle(1, 0xFFFFFF);
        _local_2.beginFill(0xFFFFFF, 0.1);
        _local_2.drawRect(_local_1.x, _local_1.y, _local_1.width, _local_1.height);
        _local_2.endFill();
        _local_2.lineStyle();
    }

    public function draw():void {
        var _local_2:Matrix;
        var _local_3:int;
        var _local_4:BitmapData;
        var _local_1:int = (SIZE / this.zoom_);
        this.map_.fillRect(this.map_.rect, 0);
        if(this.ifShowGroundLayer_)  {
            this.groundLayer_.copyFrom(new Rectangle(this.posT_.x_ * SQUARE_SIZE, this.posT_.y_ * SQUARE_SIZE, _local_1, _local_1), this.map_, this.map_.rect);
        }
        if(this.ifShowObjectLayer_)  {
            this.objectLayer_.copyFrom(new Rectangle(this.posT_.x_ * SQUARE_SIZE, this.posT_.y_ * SQUARE_SIZE, _local_1, _local_1), this.map_, this.map_.rect);
        }
        if(this.ifShowRegionLayer_)
        {
            _local_2 = new Matrix();
            _local_2.identity();
            _local_3 = SQUARE_SIZE * this.zoom_;
            if(this.zoom_ > 2)
            {
                _local_4 = new BitmapDataSpy(SIZE / _local_3, SIZE / _local_3);
                _local_4.copyPixels(this.regionMap_, new Rectangle(this.posT_.x_, this.posT_.y_, _local_1, _local_1), PointUtil.ORIGIN);
                _local_2.scale(_local_3, _local_3);
                this.map_.draw(_local_4, _local_2);
            }
            else
            {
                _local_2.translate(-this.posT_.x_, -this.posT_.y_);
                _local_2.scale(_local_3, _local_3);
                this.map_.draw(this.regionMap_, _local_2, null, null, this.map_.rect);
            }
        }
        this.drawOverlay();
    }

    private function generateThumbnail():ByteArray
    {
        var _local_1:Rectangle = this.getTileBounds();
        var _local_2:int = 8;
        var _local_3:BitmapData = new BitmapData(_local_1.width * _local_2,_local_1.height * _local_2);
        this.groundLayer_.copyFrom(new Rectangle(_local_1.x * SQUARE_SIZE,_local_1.y * SQUARE_SIZE,_local_1.width * SQUARE_SIZE,_local_1.height * SQUARE_SIZE),_local_3,_local_3.rect);
        this.objectLayer_.copyFrom(new Rectangle(_local_1.x * SQUARE_SIZE,_local_1.y * SQUARE_SIZE,_local_1.width * SQUARE_SIZE,_local_1.height * SQUARE_SIZE),_local_3,_local_3.rect);
        var _local_4:Matrix = new Matrix();
        _local_4.identity();
        _local_4.translate(-_local_1.x,-_local_1.y);
        _local_4.scale(_local_2,_local_2);
        _local_3.draw(this.regionMap_,_local_4);
        return PNGEncoder.encode(_local_3);
    }

    public function getMapStatistics():Object
    {
        var _local_6:METile;
        var _local_1:int = 0;
        var _local_2:int = 0;
        var _local_3:int = 0;
        var _local_4:int = 0;
        var _local_5:int = 0;
        for each(_local_6 in this.tileDict_)
        {
            _local_5++;
            if(_local_6.types_[Layer.GROUND] != -1)
            {
                _local_1++;
            }
            if(_local_6.types_[Layer.OBJECT] != -1)
            {
                _local_2++;
            }
            if(_local_6.types_[Layer.REGION] != -1)
            {
                if(_local_6.types_[Layer.REGION] == RegionLibrary.EXIT_REGION_TYPE)
                {
                    _local_3++;
                }
                if(_local_6.types_[Layer.REGION] == RegionLibrary.ENTRY_REGION_TYPE)
                {
                    _local_4++;
                }
            }
        }
        return {
            "numObjects": _local_2,
            "numGrounds": _local_1,
            "numExits": _local_3,
            "numEntries": _local_4,
            "numTiles": _local_5,
            "thumbnail":this.generateThumbnail()
        };
    }


}
}//package com.company.assembleegameclient.mapeditor
