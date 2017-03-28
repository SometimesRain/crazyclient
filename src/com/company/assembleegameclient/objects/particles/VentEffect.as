package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.FreeList;

public class VentEffect extends ParticleEffect {

    private static const BUBBLE_PERIOD:int = 50;

    public var go_:GameObject;
    public var lastUpdate_:int = -1;

    public function VentEffect(_arg_1:GameObject) {
        this.go_ = _arg_1;
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        var starttime:int;
        var particle:VentParticle;
        var wave:Number;
        var amp:Number;
        var xmove:Number;
        var ymove:Number;
        if (this.go_.map_ == null) {
            return (false);
        }
        if (this.lastUpdate_ < 0) {
            this.lastUpdate_ = Math.max(0, (_arg_1 - 400));
        }
        x_ = this.go_.x_;
        y_ = this.go_.y_;
        var _local_3:int = int((this.lastUpdate_ / BUBBLE_PERIOD));
        while (_local_3 < int((_arg_1 / BUBBLE_PERIOD))) {
            starttime = (_local_3 * BUBBLE_PERIOD);
            particle = (FreeList.newObject(VentParticle) as VentParticle);
            particle.restart(starttime, _arg_1);
            wave = (Math.random() * Math.PI);
            amp = (Math.random() * 0.4);
            xmove = (this.go_.x_ + (amp * Math.cos(wave)));
            ymove = (this.go_.y_ + (amp * Math.sin(wave)));
            map_.addObj(particle, xmove, ymove);
            _local_3++;
        }
        this.lastUpdate_ = _arg_1;
        return (true);
    }


}
}//package com.company.assembleegameclient.objects.particles

import com.company.assembleegameclient.objects.particles.Particle;
import com.company.assembleegameclient.util.FreeList;

class VentParticle extends Particle {

    public var startTime_:int;
    public var speed_:int;

    public function VentParticle() {
        var _local_1:Number = Math.random();
        super(2542335, 0, (75 + (_local_1 * 50)));
        this.speed_ = (2.5 - (_local_1 * 1.5));
    }

    public function restart(_arg_1:int, _arg_2:int):void {
        this.startTime_ = _arg_1;
        var _local_3:Number = ((_arg_2 - this.startTime_) / 1000);
        z_ = (0 + (this.speed_ * _local_3));
    }

    override public function removeFromMap():void {
        super.removeFromMap();
        FreeList.deleteObject(this);
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        var _local_3:Number = ((_arg_1 - this.startTime_) / 1000);
        z_ = (0 + (this.speed_ * _local_3));
        return ((z_ < 1));
    }


}
