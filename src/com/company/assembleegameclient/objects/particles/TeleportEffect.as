package com.company.assembleegameclient.objects.particles {
public class TeleportEffect extends ParticleEffect {


    override public function runNormalRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_5:Number;
        var _local_6:Number;
        var _local_7:int;
        var _local_8:TeleportParticle;
        var _local_3:int = 20;
        var _local_4:int;
        while (_local_4 < _local_3) {
            _local_5 = ((2 * Math.PI) * Math.random());
            _local_6 = (0.7 * Math.random());
            _local_7 = (500 + (1000 * Math.random()));
            _local_8 = new TeleportParticle(0xFF, 50, 0.1, _local_7);
            map_.addObj(_local_8, (x_ + (_local_6 * Math.cos(_local_5))), (y_ + (_local_6 * Math.sin(_local_5))));
            _local_4++;
        }
        return (false);
    }

    override public function runEasyRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_5:Number;
        var _local_6:Number;
        var _local_7:int;
        var _local_8:TeleportParticle;
        var _local_3:int = 10;
        var _local_4:int;
        while (_local_4 < _local_3) {
            _local_5 = ((2 * Math.PI) * Math.random());
            _local_6 = (0.7 * Math.random());
            _local_7 = (5 + (500 * Math.random()));
            _local_8 = new TeleportParticle(0xFF, 50, 0.1, _local_7);
            map_.addObj(_local_8, (x_ + (_local_6 * Math.cos(_local_5))), (y_ + (_local_6 * Math.sin(_local_5))));
            _local_4++;
        }
        return (false);
    }


}
}//package com.company.assembleegameclient.objects.particles

import com.company.assembleegameclient.objects.particles.Particle;

import flash.geom.Vector3D;

class TeleportParticle extends Particle {

    public var timeLeft_:int;
    protected var moveVec_:Vector3D;

    public function TeleportParticle(_arg_1:uint, _arg_2:int, _arg_3:Number, _arg_4:int) {
        this.moveVec_ = new Vector3D();
        super(_arg_1, 0, _arg_2);
        this.moveVec_.z = _arg_3;
        this.timeLeft_ = _arg_4;
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        this.timeLeft_ = (this.timeLeft_ - _arg_2);
        if (this.timeLeft_ <= 0) {
            return (false);
        }
        z_ = (z_ + ((this.moveVec_.z * _arg_2) * 0.008));
        return (true);
    }


}
