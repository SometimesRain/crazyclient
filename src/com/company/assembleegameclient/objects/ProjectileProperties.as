package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.util.ConditionEffect;

import flash.utils.Dictionary;

public class ProjectileProperties {

    public var bulletType_:int;
    public var objectId_:String;
    public var lifetime_:int;
    public var speed_:int;
    public var size_:int;
    public var minDamage_:int;
    public var maxDamage_:int;
    public var effects_:Vector.<uint> = null;
    public var multiHit_:Boolean;
    public var passesCover_:Boolean;
    public var armorPiercing_:Boolean;
    public var particleTrail_:Boolean;
    public var particleTrailIntensity_:int = -1;
    public var particleTrailLifetimeMS:int = -1;
    public var particleTrailColor_:int = 0xFF00FF;
    public var wavy_:Boolean;
    public var parametric_:Boolean;
    public var boomerang_:Boolean;
    public var amplitude_:Number;
    public var frequency_:Number;
    public var magnitude_:Number;
    public var isPetEffect_:Dictionary;

    public function ProjectileProperties(_arg_1:XML) {
        var _local_2:XML;
        super();
        this.bulletType_ = int(_arg_1.@id);
        this.objectId_ = _arg_1.ObjectId;
        this.lifetime_ = int(_arg_1.LifetimeMS);
        this.speed_ = int(_arg_1.Speed);
        this.size_ = ((_arg_1.hasOwnProperty("Size")) ? Number(_arg_1.Size) : -1);
        if (_arg_1.hasOwnProperty("Damage")) {
            this.minDamage_ = (this.maxDamage_ = int(_arg_1.Damage));
        }
        else {
            this.minDamage_ = int(_arg_1.MinDamage);
            this.maxDamage_ = int(_arg_1.MaxDamage);
        }
        for each (_local_2 in _arg_1.ConditionEffect) {
            if (this.effects_ == null) {
                this.effects_ = new Vector.<uint>();
            }
            this.effects_.push(ConditionEffect.getConditionEffectFromName(String(_local_2)));
            if (_local_2.attribute("target") == "1") {
                if (this.isPetEffect_ == null) {
                    this.isPetEffect_ = new Dictionary();
                }
                this.isPetEffect_[ConditionEffect.getConditionEffectFromName(String(_local_2))] = true;
            }
        }
        this.multiHit_ = _arg_1.hasOwnProperty("MultiHit");
        this.passesCover_ = _arg_1.hasOwnProperty("PassesCover");
        this.armorPiercing_ = _arg_1.hasOwnProperty("ArmorPiercing");
        this.particleTrail_ = _arg_1.hasOwnProperty("ParticleTrail");
        if (_arg_1.ParticleTrail.hasOwnProperty("@intensity")) {
            this.particleTrailIntensity_ = (Number(_arg_1.ParticleTrail.@intensity) * 100);
        }
        if (_arg_1.ParticleTrail.hasOwnProperty("@lifetimeMS")) {
            this.particleTrailLifetimeMS = Number(_arg_1.ParticleTrail.@lifetimeMS);
        }
        this.particleTrailColor_ = ((this.particleTrail_) ? Number(_arg_1.ParticleTrail) : Number(0xFF00FF));
        if (this.particleTrailColor_ == 0) {
            this.particleTrailColor_ = 0xFF00FF;
        }
        this.wavy_ = _arg_1.hasOwnProperty("Wavy");
        this.parametric_ = _arg_1.hasOwnProperty("Parametric");
        this.boomerang_ = _arg_1.hasOwnProperty("Boomerang");
        this.amplitude_ = ((_arg_1.hasOwnProperty("Amplitude")) ? Number(_arg_1.Amplitude) : 0);
        this.frequency_ = ((_arg_1.hasOwnProperty("Frequency")) ? Number(_arg_1.Frequency) : 1);
        this.magnitude_ = ((_arg_1.hasOwnProperty("Magnitude")) ? Number(_arg_1.Magnitude) : 3);
    }

}
}//package com.company.assembleegameclient.objects
