package com.company.assembleegameclient.objects {
import flash.display.BitmapData;
import flash.geom.ColorTransform;

import kabam.rotmg.stage3D.GraphicsFillExtra;

public class FlashDescription {

    public var startTime_:int;
    public var color_:uint;
    public var periodMS_:int;
    public var repeats_:int;
    public var targetR:int;
    public var targetG:int;
    public var targetB:int;

    public function FlashDescription(_arg_1:int, _arg_2:uint, _arg_3:Number, _arg_4:int) {
        this.startTime_ = _arg_1;
        this.color_ = _arg_2;
        this.periodMS_ = (_arg_3 * 1000);
        this.repeats_ = _arg_4;
        this.targetR = ((_arg_2 >> 16) & 0xFF);
        this.targetG = ((_arg_2 >> 8) & 0xFF);
        this.targetB = (_arg_2 & 0xFF);
    }

    public function apply(_arg_1:BitmapData, _arg_2:int):BitmapData {
        var _local_3:int = ((_arg_2 - this.startTime_) % this.periodMS_);
        var _local_4:Number = Math.sin(((_local_3 / this.periodMS_) * Math.PI));
        var _local_5:Number = (_local_4 * 0.5);
        var _local_6:ColorTransform = new ColorTransform((1 - _local_5), (1 - _local_5), (1 - _local_5), 1, (_local_5 * this.targetR), (_local_5 * this.targetG), (_local_5 * this.targetB), 0);
        var _local_7:BitmapData = _arg_1.clone();
        _local_7.colorTransform(_local_7.rect, _local_6);
        return (_local_7);
    }

    public function applyGPUTextureColorTransform(_arg_1:BitmapData, _arg_2:int):void {
        var _local_3:int = ((_arg_2 - this.startTime_) % this.periodMS_);
        var _local_4:Number = Math.sin(((_local_3 / this.periodMS_) * Math.PI));
        var _local_5:Number = (_local_4 * 0.5);
        var _local_6:ColorTransform = new ColorTransform((1 - _local_5), (1 - _local_5), (1 - _local_5), 1, (_local_5 * this.targetR), (_local_5 * this.targetG), (_local_5 * this.targetB), 0);
        GraphicsFillExtra.setColorTransform(_arg_1, _local_6);
    }

    public function doneAt(_arg_1:int):Boolean {
        return ((_arg_1 > (this.startTime_ + (this.periodMS_ * this.repeats_))));
    }


}
}//package com.company.assembleegameclient.objects
