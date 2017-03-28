package com.company.assembleegameclient.objects.particles {
public class ExplosionEffect extends ParticleEffect {

    public var colors_:Vector.<uint>;
    public var numParts_:int;

    public function ExplosionEffect(_arg_1:Vector.<uint>, _arg_2:int, _arg_3:int) {
        this.colors_ = _arg_1;
        size_ = _arg_2;
        if (ExplosionParticle.total_ >= 250) {
            this.numParts_ = 2;
        }
        else {
            if (ExplosionParticle.total_ >= 150) {
                this.numParts_ = 4;
            }
            else {
                if (ExplosionParticle.total_ >= 90) {
                    this.numParts_ = 12;
                }
                else {
                    this.numParts_ = _arg_3;
                }
            }
        }
    }

    override public function runNormalRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_4:uint;
        var _local_5:Particle;
        if (this.colors_.length == 0) {
            return (false);
        }
        if (ExplosionParticle.total_ > 400) {
            return (false);
        }
        var _local_3:int;
        while (_local_3 < this.numParts_) {
            _local_4 = this.colors_[int((this.colors_.length * Math.random()))];
            _local_5 = new ExplosionParticle(_local_4, 0.5, size_, (200 + (Math.random() * 100)), (Math.random() - 0.5), (Math.random() - 0.5), 0);
            map_.addObj(_local_5, x_, y_);
            _local_3++;
        }
        return (false);
    }

    override public function runEasyRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_4:uint;
        var _local_5:Particle;
        if (this.colors_.length == 0) {
            return (false);
        }
        if (ExplosionParticle.total_ > 400) {
            return (false);
        }
        this.numParts_ = 2;
        var _local_3:int;
        while (_local_3 < this.numParts_) {
            _local_4 = this.colors_[int((this.colors_.length * Math.random()))];
            _local_5 = new ExplosionParticle(_local_4, 0.5, size_, (50 + (Math.random() * 100)), (Math.random() - 0.5), (Math.random() - 0.5), 0);
            map_.addObj(_local_5, x_, y_);
            _local_3++;
        }
        return (false);
    }


}
}//package com.company.assembleegameclient.objects.particles

import com.company.assembleegameclient.objects.particles.Particle;

import flash.geom.Vector3D;

class ExplosionParticle extends Particle {

    public static var total_:int = 0;

    public var lifetime_:int;
    public var timeLeft_:int;
    protected var moveVec_:Vector3D;
    private var deleted:Boolean = false;

    public function ExplosionParticle(_arg_1:uint, _arg_2:Number, _arg_3:int, _arg_4:int, _arg_5:Number, _arg_6:Number, _arg_7:Number) {
        this.moveVec_ = new Vector3D();
        super(_arg_1, _arg_2, _arg_3);
        this.timeLeft_ = (this.lifetime_ = _arg_4);
        this.moveVec_.x = _arg_5;
        this.moveVec_.y = _arg_6;
        this.moveVec_.z = _arg_7;
        total_++;
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        this.timeLeft_ = (this.timeLeft_ - _arg_2);
        if (this.timeLeft_ <= 0) {
            if (!this.deleted) {
                total_--;
                this.deleted = true;
            }
            return (false);
        }
        x_ = (x_ + ((this.moveVec_.x * _arg_2) * 0.008));
        y_ = (y_ + ((this.moveVec_.y * _arg_2) * 0.008));
        z_ = (z_ + ((this.moveVec_.z * _arg_2) * 0.008));
        return (true);
    }


}
