package com.company.assembleegameclient.engine3d {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.GraphicsUtil;
import com.company.util.MoreColorUtil;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsPath;
import flash.display.GraphicsPathCommand;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Vector3D;
import com.company.assembleegameclient.game.MapUserInput;

import kabam.rotmg.stage3D.GraphicsFillExtra;

public class ObjectFace3D {

    public static const blackBitmap:BitmapData = new BitmapData(1, 1, true, 0xFF000000);

    public const bitmapFill_:GraphicsBitmapFill = new GraphicsBitmapFill();

    public var obj_:Object3D;
    public var indices_:Vector.<int>;
    public var useTexture_:Boolean;
    public var softwareException_:Boolean = false;
    public var texture_:BitmapData = null;
    public var normalL_:Vector3D = null;
    public var normalW_:Vector3D;
    public var shade_:Number = 1;
    private var path_:GraphicsPath;
    private var solidFill_:GraphicsSolidFill;
    private var tToS_:Matrix;
    private var tempMatrix_:Matrix;

    public function ObjectFace3D(_arg_1:Object3D, _arg_2:Vector.<int>, _arg_3:Boolean = true) {
        this.solidFill_ = new GraphicsSolidFill(0xFFFFFF, 1);
        this.tToS_ = new Matrix();
        this.tempMatrix_ = new Matrix();
        super();
        this.obj_ = _arg_1;
        this.indices_ = _arg_2;
        this.useTexture_ = _arg_3;
        var _local_4:Vector.<int> = new Vector.<int>();
        var _local_5:int;
        while (_local_5 < this.indices_.length) {
            _local_4.push((((_local_5 == 0)) ? GraphicsPathCommand.MOVE_TO : GraphicsPathCommand.LINE_TO));
            _local_5++;
        }
        var _local_6:Vector.<Number> = new Vector.<Number>();
        _local_6.length = (this.indices_.length * 2);
        this.path_ = new GraphicsPath(_local_4, _local_6);
    }

    public function dispose():void {
        this.indices_ = null;
        this.path_.commands = null;
        this.path_.data = null;
        this.path_ = null;
    }

    public function computeLighting():void {
        this.normalW_ = new Vector3D();
        Plane3D.computeNormal(this.obj_.getVecW(this.indices_[0]), this.obj_.getVecW(this.indices_[1]), this.obj_.getVecW(this.indices_[(this.indices_.length - 1)]), this.normalW_);
        this.shade_ = Lighting3D.shadeValue(this.normalW_, 0.75);
        if (this.normalL_ != null) {
            this.normalW_ = this.obj_.lToW_.deltaTransformVector(this.normalL_);
        }
    }

    public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:uint, _arg_3:BitmapData):void {
        if(MapUserInput.skipRender == true)
        {
            return;
        }
        var _local_13:int;
        var _local_4:int = (this.indices_[0] * 2);
        var _local_5:int = (this.indices_[1] * 2);
        var _local_6:int = (this.indices_[(this.indices_.length - 1)] * 2);
        var _local_7:Vector.<Number> = this.obj_.vS_;
        var _local_8:Number = (_local_7[_local_5] - _local_7[_local_4]);
        var _local_9:Number = (_local_7[(_local_5 + 1)] - _local_7[(_local_4 + 1)]);
        var _local_10:Number = (_local_7[_local_6] - _local_7[_local_4]);
        var _local_11:Number = (_local_7[(_local_6 + 1)] - _local_7[(_local_4 + 1)]);
        if (((_local_8 * _local_11) - (_local_9 * _local_10)) < 0) {
            return;
        }
        if ((((_arg_3 == null)) && (Parameters.data_.GPURender))) {
            _arg_3 = blackBitmap;
        }
        else {
            _arg_3 = TextureRedrawer.redrawFace(_arg_3, this.shade_);
        }
        this.bitmapFill_.bitmapData = _arg_3;
        this.bitmapFill_.matrix = this.tToS(_arg_3);
        _arg_1.push(this.bitmapFill_);
        var _local_12:int;
        while (_local_12 < this.indices_.length) {
            _local_13 = this.indices_[_local_12];
            this.path_.data[(_local_12 * 2)] = _local_7[(_local_13 * 2)];
            this.path_.data[((_local_12 * 2) + 1)] = _local_7[((_local_13 * 2) + 1)];
            _local_12++;
        }
        _arg_1.push(this.path_);
        _arg_1.push(GraphicsUtil.END_FILL);
        if (((((this.softwareException_) && (Parameters.isGpuRender()))) && (!((this.bitmapFill_ == null))))) {
            GraphicsFillExtra.setSoftwareDraw(this.bitmapFill_, true);
        }
    }

    private function tToS(_arg_1:BitmapData):Matrix {
        var _local_2:Vector.<Number> = this.obj_.uvts_;
        var _local_3:int = (this.indices_[0] * 3);
        var _local_4:int = (this.indices_[1] * 3);
        var _local_5:int = (this.indices_[(this.indices_.length - 1)] * 3);
        var _local_6:Number = (_local_2[_local_3] * _arg_1.width);
        var _local_7:Number = (_local_2[(_local_3 + 1)] * _arg_1.height);
        this.tToS_.a = ((_local_2[_local_4] * _arg_1.width) - _local_6);
        this.tToS_.b = ((_local_2[(_local_4 + 1)] * _arg_1.height) - _local_7);
        this.tToS_.c = ((_local_2[_local_5] * _arg_1.width) - _local_6);
        this.tToS_.d = ((_local_2[(_local_5 + 1)] * _arg_1.height) - _local_7);
        this.tToS_.tx = _local_6;
        this.tToS_.ty = _local_7;
        this.tToS_.invert();
        _local_3 = (this.indices_[0] * 2);
        _local_4 = (this.indices_[1] * 2);
        _local_5 = (this.indices_[(this.indices_.length - 1)] * 2);
        var _local_8:Vector.<Number> = this.obj_.vS_;
        this.tempMatrix_.a = (_local_8[_local_4] - _local_8[_local_3]);
        this.tempMatrix_.b = (_local_8[(_local_4 + 1)] - _local_8[(_local_3 + 1)]);
        this.tempMatrix_.c = (_local_8[_local_5] - _local_8[_local_3]);
        this.tempMatrix_.d = (_local_8[(_local_5 + 1)] - _local_8[(_local_3 + 1)]);
        this.tempMatrix_.tx = _local_8[_local_3];
        this.tempMatrix_.ty = _local_8[(_local_3 + 1)];
        this.tToS_.concat(this.tempMatrix_);
        return (this.tToS_);
    }


}
}//package com.company.assembleegameclient.engine3d
