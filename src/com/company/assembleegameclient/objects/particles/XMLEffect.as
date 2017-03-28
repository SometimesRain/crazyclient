package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;

public class XMLEffect extends ParticleEffect {

    private var go_:GameObject;
    private var partProps_:ParticleProperties;
    private var cooldown_:Number;
    private var cooldownLeft_:Number;

    public function XMLEffect(_arg_1:GameObject, _arg_2:EffectProperties) {
        this.go_ = _arg_1;
        this.partProps_ = ParticleLibrary.propsLibrary_[_arg_2.particle];
        this.cooldown_ = _arg_2.cooldown;
        this.cooldownLeft_ = 0;
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        if (this.go_.map_ == null) {
            return (false);
        }
        var _local_3:Number = (_arg_2 / 1000);
        this.cooldownLeft_ = (this.cooldownLeft_ - _local_3);
        if (this.cooldownLeft_ >= 0) {
            return (true);
        }
        this.cooldownLeft_ = this.cooldown_;
        map_.addObj(new XMLParticle(this.partProps_), this.go_.x_, this.go_.y_);
        return (true);
    }


}
}//package com.company.assembleegameclient.objects.particles
