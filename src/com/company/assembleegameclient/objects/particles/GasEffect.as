package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.RandomUtil;

public class GasEffect extends ParticleEffect {

    public var go_:GameObject;
    public var props:EffectProperties;
    public var color_:int;
    public var rate:Number;
    public var type:String;

    public function GasEffect(_arg_1:GameObject, _arg_2:EffectProperties) {
        this.go_ = _arg_1;
        this.color_ = _arg_2.color;
        this.rate = _arg_2.rate;
        this.props = _arg_2;
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        var _local_5:Number;
        var _local_6:Number;
        var _local_7:Number;
        var _local_8:Number;
        var _local_9:Number;
        var _local_10:GasParticle;
        if (this.go_.map_ == null) {
            return (false);
        }
        x_ = this.go_.x_;
        y_ = this.go_.y_;
        var _local_3:int = 20;
        var _local_4:int;
        while (_local_4 < this.rate) {
            _local_5 = ((Math.random() + 0.3) * 200);
            _local_6 = Math.random();
            _local_7 = RandomUtil.plusMinus((this.props.speed - (this.props.speed * (_local_6 * (1 - this.props.speedVariance)))));
            _local_8 = RandomUtil.plusMinus((this.props.speed - (this.props.speed * (_local_6 * (1 - this.props.speedVariance)))));
            _local_9 = ((this.props.life * 1000) - ((this.props.life * 1000) * (_local_6 * this.props.lifeVariance)));
            _local_10 = new GasParticle(_local_5, this.color_, _local_9, this.props.spread, 0.75, _local_7, _local_8);
            map_.addObj(_local_10, x_, y_);
            _local_4++;
        }
        return (true);
    }


}
}//package com.company.assembleegameclient.objects.particles
