package com.company.assembleegameclient.objects.animation {
import flash.display.BitmapData;

public class Animations {

    public var animationsData_:AnimationsData;
    public var nextRun_:Vector.<int> = null;
    public var running_:RunningAnimation = null;

    public function Animations(_arg_1:AnimationsData) {
        this.animationsData_ = _arg_1;
    }

    public function getTexture(_arg_1:int):BitmapData {
        var _local_2:AnimationData;
        var _local_4:BitmapData;
        var _local_5:int;
        if (this.nextRun_ == null) {
            this.nextRun_ = new Vector.<int>();
            for each (_local_2 in this.animationsData_.animations) {
                this.nextRun_.push(_local_2.getLastRun(_arg_1));
            }
        }
        if (this.running_ != null) {
            _local_4 = this.running_.getTexture(_arg_1);
            if (_local_4 != null) {
                return (_local_4);
            }
            this.running_ = null;
        }
        var _local_3:int = 0;
        while (_local_3 < this.nextRun_.length) {
            if (_arg_1 > this.nextRun_[_local_3]) {
                _local_5 = this.nextRun_[_local_3];
                _local_2 = this.animationsData_.animations[_local_3];
                this.nextRun_[_local_3] = _local_2.getNextRun(_arg_1);
                if (!((!((_local_2.prob_ == 1))) && ((Math.random() > _local_2.prob_)))) {
                    this.running_ = new RunningAnimation(_local_2, _local_5);
                    return (this.running_.getTexture(_arg_1));
                }
            }
            _local_3++;
        }
        return (null);
    }


}
}//package com.company.assembleegameclient.objects.animation

import com.company.assembleegameclient.objects.animation.AnimationData;
import com.company.assembleegameclient.objects.animation.FrameData;

import flash.display.BitmapData;

class RunningAnimation {

    public var animationData_:AnimationData;
    public var start_:int;
    public var frameId_:int;
    public var frameStart_:int;
    public var texture_:BitmapData;

    public function RunningAnimation(_arg_1:AnimationData, _arg_2:int) {
        this.animationData_ = _arg_1;
        this.start_ = _arg_2;
        this.frameId_ = 0;
        this.frameStart_ = _arg_2;
        this.texture_ = null;
    }

    public function getTexture(_arg_1:int):BitmapData {
        var _local_2:FrameData = this.animationData_.frames[this.frameId_];
        while ((_arg_1 - this.frameStart_) > _local_2.time_) {
            if (this.frameId_ >= (this.animationData_.frames.length - 1)) {
                return (null);
            }
            this.frameStart_ = (this.frameStart_ + _local_2.time_);
            this.frameId_++;
            _local_2 = this.animationData_.frames[this.frameId_];
            this.texture_ = null;
        }
        if (this.texture_ == null) {
            this.texture_ = _local_2.textureData_.getTexture((Math.random() * 100));
        }
        return (this.texture_);
    }


}
