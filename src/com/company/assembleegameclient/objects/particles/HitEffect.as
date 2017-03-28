package com.company.assembleegameclient.objects.particles {
public class HitEffect extends ParticleEffect {

    public var colors_:Vector.<uint>;
    public var numParts_:int;
    public var angle_:Number;
    public var speed_:Number;

    public function HitEffect(_arg_1:Vector.<uint>, _arg_2:int, _arg_3:int, _arg_4:Number, _arg_5:Number) {
        this.colors_ = _arg_1;
        size_ = _arg_2;
        this.numParts_ = _arg_3;
        this.angle_ = _arg_4;
        this.speed_ = _arg_5;
    }

    override public function runNormalRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_6:uint;
        var _local_7:Particle;
        if (this.colors_.length == 0) {
            return (false);
        }
        var _local_3:Number = ((this.speed_ / 600) * Math.cos((this.angle_ + Math.PI)));
        var _local_4:Number = ((this.speed_ / 600) * Math.sin((this.angle_ + Math.PI)));
        var _local_5:int;
        while (_local_5 < this.numParts_) {
            _local_6 = this.colors_[int((this.colors_.length * Math.random()))];
            _local_7 = new HitParticle(_local_6, 0.5, size_, (200 + (Math.random() * 100)), (_local_3 + ((Math.random() - 0.5) * 0.4)), (_local_4 + ((Math.random() - 0.5) * 0.4)), 0);
            map_.addObj(_local_7, x_, y_);
            _local_5++;
        }
        return (false);
    }

    override public function runEasyRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_6:uint;
        var _local_7:Particle;
        if (this.colors_.length == 0) {
            return (false);
        }
        var _local_3:Number = ((this.speed_ / 600) * Math.cos((this.angle_ + Math.PI)));
        var _local_4:Number = ((this.speed_ / 600) * Math.sin((this.angle_ + Math.PI)));
        this.numParts_ = (this.numParts_ * 0.2);
        var _local_5:int;
        while (_local_5 < this.numParts_) {
            _local_6 = this.colors_[int((this.colors_.length * Math.random()))];
            _local_7 = new HitParticle(_local_6, 0.5, 10, (5 + (Math.random() * 100)), (_local_3 + ((Math.random() - 0.5) * 0.4)), (_local_4 + ((Math.random() - 0.5) * 0.4)), 0);
            map_.addObj(_local_7, x_, y_);
            _local_5++;
        }
        return (false);
    }


}
}//package com.company.assembleegameclient.objects.particles

import com.company.assembleegameclient.objects.particles.Particle;

import flash.geom.Vector3D;

class HitParticle extends Particle {

    public var lifetime_:int;
    public var timeLeft_:int;
    protected var moveVec_:Vector3D;

    public function HitParticle(_arg_1:uint, _arg_2:Number, _arg_3:int, _arg_4:int, _arg_5:Number, _arg_6:Number, _arg_7:Number) {
        this.moveVec_ = new Vector3D();
        super(_arg_1, _arg_2, _arg_3);
        this.timeLeft_ = (this.lifetime_ = _arg_4);
        this.moveVec_.x = _arg_5;
        this.moveVec_.y = _arg_6;
        this.moveVec_.z = _arg_7;
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        this.timeLeft_ = (this.timeLeft_ - _arg_2);
        if (this.timeLeft_ <= 0) {
            return (false);
        }
        x_ = (x_ + ((this.moveVec_.x * _arg_2) * 0.008));
        y_ = (y_ + ((this.moveVec_.y * _arg_2) * 0.008));
        z_ = (z_ + ((this.moveVec_.z * _arg_2) * 0.008));
        return (true);
    }


}
