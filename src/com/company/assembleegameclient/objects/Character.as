package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.sound.SoundEffectLibrary;

public class Character extends GameObject {

    public var hurtSound_:String;
    public var deathSound_:String;

    public function Character(_arg_1:XML) {
        super(_arg_1);
        this.hurtSound_ = ((_arg_1.hasOwnProperty("HitSound")) ? String(_arg_1.HitSound) : "monster/default_hit");
        SoundEffectLibrary.load(this.hurtSound_);
        this.deathSound_ = ((_arg_1.hasOwnProperty("DeathSound")) ? String(_arg_1.DeathSound) : "monster/default_death");
        SoundEffectLibrary.load(this.deathSound_);
    }

    override public function damage(_arg_1:int, _arg_2:int, _arg_3:Vector.<uint>, _arg_4:Boolean, _arg_5:Projectile):void {
        super.damage(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        if (dead_) {
            SoundEffectLibrary.play(this.deathSound_);
        }
        else {
            if (((_arg_5) || ((_arg_2 > 0)))) {
                SoundEffectLibrary.play(this.hurtSound_);
            }
        }
    }


}
}//package com.company.assembleegameclient.objects
