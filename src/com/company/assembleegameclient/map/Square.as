package com.company.assembleegameclient.map {
import com.company.assembleegameclient.engine3d.TextureMatrix;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.TileRedrawer;

import flash.display.BitmapData;
import flash.display.IGraphicsData;
import flash.geom.Vector3D;
import com.company.assembleegameclient.game.MapUserInput;

public class Square {

    public static const UVT:Vector.<Number> = new <Number>[0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0];
    private static const LOOKUP:Vector.<int> = new <int>[26171, 44789, 20333, 70429, 98257, 59393, 33961];

    public var map_:Map;
    public var x_:int;
    public var y_:int;
    public var tileType_:uint = 0xFF;
    public var center_:Vector3D;
    public var vin_:Vector.<Number>;
    public var obj_:GameObject = null;
    public var props_:GroundProperties;
    public var texture_:BitmapData = null;
    public var sink_:int = 0;
    public var lastDamage_:int = 0;
    public var faces_:Vector.<SquareFace>;
    public var topFace_:SquareFace = null;
    public var baseTexMatrix_:TextureMatrix = null;
    public var lastVisible_:int;

    public function Square(_arg_1:Map, _arg_2:int, _arg_3:int) {
        this.props_ = GroundLibrary.defaultProps_;
        this.faces_ = new Vector.<SquareFace>();
        super();
        this.map_ = _arg_1;
        this.x_ = _arg_2;
        this.y_ = _arg_3;
        this.center_ = new Vector3D((this.x_ + 0.5), (this.y_ + 0.5), 0);
        this.vin_ = new <Number>[this.x_, this.y_, 0, (this.x_ + 1), this.y_, 0, (this.x_ + 1), (this.y_ + 1), 0, this.x_, (this.y_ + 1), 0];
    }

    private static function hash(_arg_1:int, _arg_2:int):int {
        var _local_3:int = LOOKUP[((_arg_1 + _arg_2) % 7)];
        var _local_4:int = (((_arg_1 << 16) | _arg_2) ^ 81397550);
        _local_4 = ((_local_4 * _local_3) % 0xFFFF);
        return (_local_4);
    }


    public function dispose():void {
        var _local_1:SquareFace;
        this.map_ = null;
        this.center_ = null;
        this.vin_ = null;
        this.obj_ = null;
        this.texture_ = null;
        for each (_local_1 in this.faces_) {
            _local_1.dispose();
        }
        this.faces_.length = 0;
        if (this.topFace_ != null) {
            this.topFace_.dispose();
            this.topFace_ = null;
        }
        this.faces_ = null;
        this.baseTexMatrix_ = null;
    }

    public function setTileType(_arg_1:uint):void {
        this.tileType_ = _arg_1;
        this.props_ = GroundLibrary.propsLibrary_[this.tileType_];
        this.texture_ = GroundLibrary.getBitmapData(this.tileType_, hash(this.x_, this.y_));
        this.baseTexMatrix_ = new TextureMatrix(this.texture_, UVT);
        this.faces_.length = 0;
    }

    public function isWalkable():Boolean {
        return (((!(this.props_.noWalk_)) && ((((this.obj_ == null)) || (!(this.obj_.props_.occupySquare_))))));
    }

    public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
        if(MapUserInput.skipRender == true)
        {
            return;
        }
        var _local_4:SquareFace;
        if (this.texture_ == null) {
            return;
        }
        if (this.faces_.length == 0) {
            this.rebuild3D();
        }
        for each (_local_4 in this.faces_) {
            if (!_local_4.draw(_arg_1, _arg_2, _arg_3)) {
                if (_local_4.face_.vout_[1] < _arg_2.clipRect_.bottom) {
                    this.lastVisible_ = 0;
                }
                return;
            }
        }
    }

    public function drawTop(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void {
        this.topFace_.draw(_arg_1, _arg_2, _arg_3);
    }

    private function rebuild3D():void {
        var _local_2:Number;
        var _local_3:Number;
        var _local_4:BitmapData;
        var _local_5:Vector.<Number>;
        var _local_6:uint;
        this.faces_.length = 0;
        this.topFace_ = null;
        var _local_1:BitmapData;
        if (this.props_.animate_.type_ != AnimateProperties.NO_ANIMATE) {
            this.faces_.push(new SquareFace(this.texture_, this.vin_, this.props_.xOffset_, this.props_.xOffset_, this.props_.animate_.type_, this.props_.animate_.dx_, this.props_.animate_.dy_));
            _local_1 = TileRedrawer.redraw(this, false);
            if (_local_1 != null) {
                this.faces_.push(new SquareFace(_local_1, this.vin_, 0, 0, AnimateProperties.NO_ANIMATE, 0, 0));
            }
        }
        else {
            _local_1 = TileRedrawer.redraw(this, true);
            _local_2 = 0;
            _local_3 = 0;
            if (_local_1 == null) {
                if (this.props_.randomOffset_) {
                    _local_2 = (int((this.texture_.width * Math.random())) / this.texture_.width);
                    _local_3 = (int((this.texture_.height * Math.random())) / this.texture_.height);
                }
                else {
                    _local_2 = this.props_.xOffset_;
                    _local_3 = this.props_.yOffset_;
                }
            }
            this.faces_.push(new SquareFace((((_local_1) != null) ? _local_1 : this.texture_), this.vin_, _local_2, _local_3, AnimateProperties.NO_ANIMATE, 0, 0));
        }
        if (this.props_.sink_) {
            this.sink_ = (((_local_1) == null) ? 12 : 6);
        }
        else {
            this.sink_ = 0;
        }
        if (this.props_.topTD_) {
            _local_4 = this.props_.topTD_.getTexture();
            _local_5 = this.vin_.concat();
            _local_6 = 2;
            while (_local_6 < _local_5.length) {
                _local_5[_local_6] = 1;
                _local_6 = (_local_6 + 3);
            }
            this.topFace_ = new SquareFace(_local_4, _local_5, 0, 0, this.props_.topAnimate_.type_, this.props_.topAnimate_.dx_, this.props_.topAnimate_.dy_);
        }
    }


}
}//package com.company.assembleegameclient.map
