package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.util.RandomUtil;

import flash.geom.Point;

public class SparkerParticle extends Particle {

    public var lifetime_:int;
    public var timeLeft_:int;
    public var initialSize_:int;
    public var start_:Point;
    public var end_:Point;
    public var dx_:Number;
    public var dy_:Number;
    public var pathX_:Number;
    public var pathY_:Number;

    public function SparkerParticle(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Point, _arg_5:Point) {
        super(_arg_2, 0, _arg_1);
        this.lifetime_ = (this.timeLeft_ = _arg_3);
        this.initialSize_ = _arg_1;
        this.start_ = _arg_4;
        this.end_ = _arg_5;
        this.dx_ = ((this.end_.x - this.start_.x) / this.timeLeft_);
        this.dy_ = ((this.end_.y - this.start_.y) / this.timeLeft_);
        var _local_6:Number = (Point.distance(_arg_4, _arg_5) / this.timeLeft_);
        this.pathX_ = (x_ = this.start_.x);
        this.pathY_ = (y_ = this.start_.y);
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        this.timeLeft_ = (this.timeLeft_ - _arg_2);
        if (this.timeLeft_ <= 0) {
            return (false);
        }
        this.pathX_ = (this.pathX_ + (this.dx_ * _arg_2));
        this.pathY_ = (this.pathY_ + (this.dy_ * _arg_2));
        moveTo(this.pathX_, this.pathY_);
        map_.addObj(new SparkParticle((100 * (z_ + 1)), color_, 600, z_, RandomUtil.plusMinus(1), RandomUtil.plusMinus(1)), this.pathX_, this.pathY_);
        return (true);
    }


}
}//package com.company.assembleegameclient.objects.particles
