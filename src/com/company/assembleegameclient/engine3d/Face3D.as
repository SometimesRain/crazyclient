package com.company.assembleegameclient.engine3d {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.GraphicsUtil;
import com.company.util.Triangle;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsPath;
import flash.display.GraphicsPathCommand;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.geom.Utils3D;
import flash.geom.Vector3D;
import com.company.assembleegameclient.game.MapUserInput;

public class Face3D {

    private static const blackOutFill_:GraphicsSolidFill = new GraphicsSolidFill(0, 1);

    public var origTexture_:BitmapData;
    public var vin_:Vector.<Number>;
    public var uvt_:Vector.<Number>;
    public var vout_:Vector.<Number>;
    public var backfaceCull_:Boolean;
    public var shade_:Number = 1;
    public var blackOut_:Boolean = false;
    private var needGen_:Boolean = true;
    private var textureMatrix_:TextureMatrix = null;
    public var bitmapFill_:GraphicsBitmapFill;
    private var path_:GraphicsPath;

    public function Face3D(_arg_1:BitmapData, _arg_2:Vector.<Number>, _arg_3:Vector.<Number>, _arg_4:Boolean = false, _arg_5:Boolean = false) {
        var _local_7:Vector3D;
        this.vout_ = new Vector.<Number>();
        this.bitmapFill_ = new GraphicsBitmapFill(null, null, false, false);
        this.path_ = new GraphicsPath(new Vector.<int>(), null);
        super();
        this.origTexture_ = _arg_1;
        this.vin_ = _arg_2;
        this.uvt_ = _arg_3;
        this.backfaceCull_ = _arg_4;
        if (_arg_5) {
            _local_7 = new Vector3D();
            Plane3D.computeNormalVec(_arg_2, _local_7);
            this.shade_ = Lighting3D.shadeValue(_local_7, 0.75);
        }
        this.path_.commands.push(GraphicsPathCommand.MOVE_TO);
        var _local_6:int = 3;
        while (_local_6 < this.vin_.length) {
            this.path_.commands.push(GraphicsPathCommand.LINE_TO);
            _local_6 = (_local_6 + 3);
        }
        this.path_.data = this.vout_;
    }

    public function dispose():void {
        this.origTexture_ = null;
        this.vin_ = null;
        this.uvt_ = null;
        this.vout_ = null;
        this.textureMatrix_ = null;
        this.bitmapFill_ = null;
        this.path_.commands = null;
        this.path_.data = null;
        this.path_ = null;
    }

    public function setTexture(_arg_1:BitmapData):void {
        if (this.origTexture_ == _arg_1) {
            return;
        }
        this.origTexture_ = _arg_1;
        this.needGen_ = true;
    }

    public function setUVT(_arg_1:Vector.<Number>):void {
        this.uvt_ = _arg_1;
        this.needGen_ = true;
    }

    public function maxY():Number {
        var _local_1:Number = -(Number.MAX_VALUE);
        var _local_2:int = this.vout_.length;
        var _local_3:int;
        while (_local_3 < _local_2) {
            if (this.vout_[(_local_3 + 1)] > _local_1) {
                _local_1 = this.vout_[(_local_3 + 1)];
            }
            _local_3 = (_local_3 + 2);
        }
        return (_local_1);
    }

    public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera):Boolean {
        if(MapUserInput.skipRender == true)
        {
            return false;
        }
        var _local_10:Vector.<Number>;
        var _local_11:Number;
        var _local_12:Number;
        var _local_13:Number;
        var _local_14:Number;
        var _local_15:int;
        Utils3D.projectVectors(_arg_2.wToS_, this.vin_, this.vout_, this.uvt_);
        if (this.backfaceCull_) {
            _local_10 = this.vout_;
            _local_11 = (_local_10[2] - _local_10[0]);
            _local_12 = (_local_10[3] - _local_10[1]);
            _local_13 = (_local_10[4] - _local_10[0]);
            _local_14 = (_local_10[5] - _local_10[1]);
            if (((_local_11 * _local_14) - (_local_12 * _local_13)) > 0) {
                return (false);
            }
        }
        var _local_3:Number = (_arg_2.clipRect_.x - 10);
        var _local_4:Number = (_arg_2.clipRect_.y - 10);
        var _local_5:Number = (_arg_2.clipRect_.right + 10);
        var _local_6:Number = (_arg_2.clipRect_.bottom + 10);
        var _local_7:Boolean = true;
        var _local_8:int = this.vout_.length;
        var _local_9:int;
        while (_local_9 < _local_8) {
            _local_15 = (_local_9 + 1);
            if ((((((((this.vout_[_local_9] >= _local_3)) && ((this.vout_[_local_9] <= _local_5)))) && ((this.vout_[_local_15] >= _local_4)))) && ((this.vout_[_local_15] <= _local_6)))) {
                _local_7 = false;
                break;
            }
            _local_9 = (_local_9 + 2);
        }
        if (_local_7) {
            return (false);
        }
        if (this.blackOut_) {
            _arg_1.push(blackOutFill_);
            _arg_1.push(this.path_);
            _arg_1.push(GraphicsUtil.END_FILL);
            return (true);
        }
        if (this.needGen_) {
            this.generateTextureMatrix();
        }
        this.textureMatrix_.calculateTextureMatrix(this.vout_);
        this.bitmapFill_.bitmapData = this.textureMatrix_.texture_;
        this.bitmapFill_.matrix = this.textureMatrix_.tToS_;
        _arg_1.push(this.bitmapFill_);
        _arg_1.push(this.path_);
        _arg_1.push(GraphicsUtil.END_FILL);
        return (true);
    }

    public function contains(_arg_1:Number, _arg_2:Number):Boolean {
        if (Triangle.containsXY(this.vout_[0], this.vout_[1], this.vout_[2], this.vout_[3], this.vout_[4], this.vout_[5], _arg_1, _arg_2)) {
            return (true);
        }
        if ((((this.vout_.length == 8)) && (Triangle.containsXY(this.vout_[0], this.vout_[1], this.vout_[4], this.vout_[5], this.vout_[6], this.vout_[7], _arg_1, _arg_2)))) {
            return (true);
        }
        return (false);
    }

    private function generateTextureMatrix():void {
        var _local_1:BitmapData = TextureRedrawer.redrawFace(this.origTexture_, this.shade_);
        if (this.textureMatrix_ == null) {
            this.textureMatrix_ = new TextureMatrix(_local_1, this.uvt_);
        }
        else {
            this.textureMatrix_.texture_ = _local_1;
            this.textureMatrix_.calculateUVMatrix(this.uvt_);
        }
        this.needGen_ = false;
    }


}
}//package com.company.assembleegameclient.engine3d
