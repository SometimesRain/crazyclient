package com.company.assembleegameclient.objects.particles {
public class GasParticle extends SparkParticle {

    private var noise:Number;

    public function GasParticle(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number) {
        this.noise = _arg_4;
        super(_arg_1, _arg_2, _arg_3, _arg_5, _arg_6, _arg_7);
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        var _local_4:Number;
        timeLeft_ = (timeLeft_ - _arg_2);
        if (timeLeft_ <= 0) {
            return (false);
        }
        if (((square_.obj_) && (square_.obj_.props_.static_))) {
            return (false);
        }
        var _local_3:Number = (Math.random() * this.noise);
        _local_4 = (Math.random() * this.noise);
        x_ = (x_ + (((dx_ * _local_3) * _arg_2) / 1000));
        y_ = (y_ + (((dy_ * _local_4) * _arg_2) / 1000));
        setSize(((timeLeft_ / lifetime_) * initialSize_));
        return (true);
    }


}
}//package com.company.assembleegameclient.objects.particles
