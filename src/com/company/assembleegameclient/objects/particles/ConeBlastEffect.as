package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;

import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class ConeBlastEffect extends ParticleEffect {

    public var start_:Point;
    public var target_:WorldPosData;
    public var blastRadius_:Number;
    public var color_:int;

    public function ConeBlastEffect(_arg_1:GameObject, _arg_2:WorldPosData, _arg_3:Number, _arg_4:int) {
        this.start_ = new Point(_arg_1.x_, _arg_1.y_);
        this.target_ = _arg_2;
        this.blastRadius_ = _arg_3;
        this.color_ = _arg_4;
    }

    override public function runNormalRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_9:Number;
        var _local_10:Point;
        var _local_11:Particle;
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local_3:int = 200;
        var _local_4:int = 100;
        var _local_5:Number = (Math.PI / 3);
        var _local_6:int = 7;
        var _local_7:Number = Math.atan2((this.target_.y_ - this.start_.y), (this.target_.x_ - this.start_.x));
        var _local_8:int;
        while (_local_8 < _local_6) {
            _local_9 = ((_local_7 - (_local_5 / 2)) + ((_local_8 * _local_5) / _local_6));
            _local_10 = new Point((this.start_.x + (this.blastRadius_ * Math.cos(_local_9))), (this.start_.y + (this.blastRadius_ * Math.sin(_local_9))));
            _local_11 = new SparkerParticle(_local_3, this.color_, _local_4, this.start_, _local_10);
            map_.addObj(_local_11, x_, y_);
            _local_8++;
        }
        return (false);
    }

    override public function runEasyRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_9:Number;
        var _local_10:Point;
        var _local_11:Particle;
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local_3:int = 50;
        var _local_4:int = 10;
        var _local_5:Number = (Math.PI / 3);
        var _local_6:int = 5;
        var _local_7:Number = Math.atan2((this.target_.y_ - this.start_.y), (this.target_.x_ - this.start_.x));
        var _local_8:int;
        while (_local_8 < _local_6) {
            _local_9 = ((_local_7 - (_local_5 / 2)) + ((_local_8 * _local_5) / _local_6));
            _local_10 = new Point((this.start_.x + (this.blastRadius_ * Math.cos(_local_9))), (this.start_.y + (this.blastRadius_ * Math.sin(_local_9))));
            _local_11 = new SparkerParticle(_local_3, this.color_, _local_4, this.start_, _local_10);
            map_.addObj(_local_11, x_, y_);
            _local_8++;
        }
        return (false);
    }


}
}//package com.company.assembleegameclient.objects.particles
