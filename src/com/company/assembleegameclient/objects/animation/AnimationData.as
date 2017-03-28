package com.company.assembleegameclient.objects.animation {
public class AnimationData {

    public var prob_:Number = 1;
    public var period_:int;
    public var periodJitter_:int;
    public var sync_:Boolean = false;
    public var frames:Vector.<FrameData>;

    public function AnimationData(_arg_1:XML) {
        var _local_2:XML;
        this.frames = new Vector.<FrameData>();
        super();
        if (("@prob" in _arg_1)) {
            this.prob_ = Number(_arg_1.@prob);
        }
        this.period_ = int((Number(_arg_1.@period) * 1000));
        this.periodJitter_ = int((Number(_arg_1.@periodJitter) * 1000));
        this.sync_ = (String(_arg_1.@sync) == "true");
        for each (_local_2 in _arg_1.Frame) {
            this.frames.push(new FrameData(_local_2));
        }
    }

    private function getPeriod():int {
        if (this.periodJitter_ == 0) {
            return (this.period_);
        }
        return (((this.period_ - this.periodJitter_) + ((2 * Math.random()) * this.periodJitter_)));
    }

    public function getLastRun(_arg_1:int):int {
        if (this.sync_) {
            return ((int((_arg_1 / this.period_)) * this.period_));
        }
        return (((_arg_1 + this.getPeriod()) + (200 * Math.random())));
    }

    public function getNextRun(_arg_1:int):int {
        if (this.sync_) {
            return (((int((_arg_1 / this.period_)) * this.period_) + this.period_));
        }
        return ((_arg_1 + this.getPeriod()));
    }


}
}//package com.company.assembleegameclient.objects.animation
