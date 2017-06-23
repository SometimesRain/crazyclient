package com.company.assembleegameclient.objects.particles {
import flash.geom.Point;

public class ThrowEffect extends ParticleEffect {

    public var start_:Point;
    public var end_:Point;
    public var color_:int;
	public var duration_:int;

	public function ThrowEffect(_arg_1:Point, _arg_2:Point, _arg_3:int, _arg_4:int = 1500) {
        this.start_ = _arg_1;
        this.end_ = _arg_2;
        this.color_ = _arg_3;
        this.duration_ = _arg_4;
    }

    override public function runNormalRendering(_arg_1:int, _arg_2:int):Boolean {
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local_3:int = 200;
        var _local_4:ThrowParticle = new ThrowParticle(_local_3, this.color_, this.duration_, this.start_, this.end_);
        map_.addObj(_local_4, x_, y_);
        return (false);
    }

    override public function runEasyRendering(_arg_1:int, _arg_2:int):Boolean {
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local_3:int = 10;
        var _local_4:ThrowParticle = new ThrowParticle(_local_3, this.color_, this.duration_, this.start_, this.end_);
        map_.addObj(_local_4, x_, y_);
        return (false);
    }


}
}//package com.company.assembleegameclient.objects.particles

import com.company.assembleegameclient.objects.particles.Particle;
import com.company.assembleegameclient.objects.particles.SparkParticle;
import com.company.assembleegameclient.util.RandomUtil;

import flash.geom.Point;

class ThrowParticle extends Particle {

    public var lifetime_:int;
    public var timeLeft_:int;
    public var initialSize_:int;
    public var start_:Point;
    public var end_:Point;
    public var dx_:Number;
    public var dy_:Number;
    public var pathX_:Number;
    public var pathY_:Number;

    public function ThrowParticle(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Point, _arg_5:Point) {
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
        z_ = (Math.sin(((this.timeLeft_ / this.lifetime_) * Math.PI)) * 2);
        setSize(0);
        this.pathX_ = (this.pathX_ + (this.dx_ * _arg_2));
        this.pathY_ = (this.pathY_ + (this.dy_ * _arg_2));
        moveTo(this.pathX_, this.pathY_);
        map_.addObj(new SparkParticle((100 * (z_ + 1)), color_, 400, z_, RandomUtil.plusMinus(1), RandomUtil.plusMinus(1)), this.pathX_, this.pathY_);
        return (true);
    }

}
