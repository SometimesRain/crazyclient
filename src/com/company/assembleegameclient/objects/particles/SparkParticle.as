package com.company.assembleegameclient.objects.particles {
public class SparkParticle extends Particle {

    public var lifetime_:int;
    public var timeLeft_:int;
    public var initialSize_:int;
    public var dx_:Number;
    public var dy_:Number;

    public function SparkParticle(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Number, _arg_5:Number, _arg_6:Number) {
        super(_arg_2, _arg_4, _arg_1);
        this.initialSize_ = _arg_1;
        this.lifetime_ = (this.timeLeft_ = _arg_3);
        this.dx_ = _arg_5;
        this.dy_ = _arg_6;
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        this.timeLeft_ = (this.timeLeft_ - _arg_2);
        if (this.timeLeft_ <= 0) {
            return (false);
        }
        x_ = (x_ + ((this.dx_ * _arg_2) / 1000));
        y_ = (y_ + ((this.dy_ * _arg_2) / 1000));
        setSize(((this.timeLeft_ / this.lifetime_) * this.initialSize_));
        return (true);
    }


}
}//package com.company.assembleegameclient.objects.particles
