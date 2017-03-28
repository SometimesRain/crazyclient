package com.company.assembleegameclient.map {
import com.company.assembleegameclient.engine3d.Face3D;
import com.company.assembleegameclient.parameters.Parameters;

import flash.display.BitmapData;
import flash.display.IGraphicsData;

import kabam.rotmg.stage3D.GraphicsFillExtra;

public class SquareFace {

    public var animate_:int;
    public var face_:Face3D;
    public var xOffset_:Number = 0;
    public var yOffset_:Number = 0;
    public var animateDx_:Number = 0;
    public var animateDy_:Number = 0;

    public function SquareFace(_arg_1:BitmapData, _arg_2:Vector.<Number>, _arg_3:Number, _arg_4:Number, _arg_5:int, _arg_6:Number, _arg_7:Number) {
        this.face_ = new Face3D(_arg_1, _arg_2, Square.UVT.concat());
        this.xOffset_ = _arg_3;
        this.yOffset_ = _arg_4;
        if (((!((this.xOffset_ == 0))) || (!((this.yOffset_ == 0))))) {
            this.face_.bitmapFill_.repeat = true;
        }
        this.animate_ = _arg_5;
        if (this.animate_ != AnimateProperties.NO_ANIMATE) {
            this.face_.bitmapFill_.repeat = true;
        }
        this.animateDx_ = _arg_6;
        this.animateDy_ = _arg_7;
    }

    public function dispose():void {
        this.face_.dispose();
        this.face_ = null;
    }

    public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):Boolean {
        var _local_4:Number;
        var _local_5:Number;
        if (this.animate_ != AnimateProperties.NO_ANIMATE) {
            switch (this.animate_) {
                case AnimateProperties.WAVE_ANIMATE:
                    _local_4 = (this.xOffset_ + Math.sin(((this.animateDx_ * _arg_3) / 1000)));
                    _local_5 = (this.yOffset_ + Math.sin(((this.animateDy_ * _arg_3) / 1000)));
                    break;
                case AnimateProperties.FLOW_ANIMATE:
                    _local_4 = (this.xOffset_ + ((this.animateDx_ * _arg_3) / 1000));
                    _local_5 = (this.yOffset_ + ((this.animateDy_ * _arg_3) / 1000));
                    break;
            }
        }
        else {
            _local_4 = this.xOffset_;
            _local_5 = this.yOffset_;
        }
        if (Parameters.isGpuRender()) {
            GraphicsFillExtra.setOffsetUV(this.face_.bitmapFill_, _local_4, _local_5);
            _local_5 = 0;
            _local_4 = _local_5;
        }
        this.face_.uvt_.length = 0;
        this.face_.uvt_.push((0 + _local_4), (0 + _local_5), 0, (1 + _local_4), (0 + _local_5), 0, (1 + _local_4), (1 + _local_5), 0, (0 + _local_4), (1 + _local_5), 0);
        this.face_.setUVT(this.face_.uvt_);
        return (this.face_.draw(_arg_1, _arg_2));
    }


}
}//package com.company.assembleegameclient.map
