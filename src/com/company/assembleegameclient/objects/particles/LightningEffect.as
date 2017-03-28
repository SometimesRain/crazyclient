package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.RandomUtil;

import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class LightningEffect extends ParticleEffect {

    public var start_:Point;
    public var end_:Point;
    public var color_:int;
    public var particleSize_:int;
    public var lifetimeMultiplier_:Number;

    public function LightningEffect(_arg_1:GameObject, _arg_2:WorldPosData, _arg_3:int, _arg_4:int, _arg_5:* = 1) {
        this.start_ = new Point(_arg_1.x_, _arg_1.y_);
        this.end_ = new Point(_arg_2.x_, _arg_2.y_);
        this.color_ = _arg_3;
        this.particleSize_ = _arg_4;
        this.lifetimeMultiplier_ = _arg_5;
    }

    override public function runNormalRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_6:Point;
        var _local_7:Particle;
        var _local_8:Number;
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local_3:Number = Point.distance(this.start_, this.end_);
        var _local_4:int = (_local_3 * 3);
        var _local_5:int;
        while (_local_5 < _local_4) {
            _local_6 = Point.interpolate(this.start_, this.end_, (_local_5 / _local_4));
            _local_7 = new SparkParticle(this.particleSize_, this.color_, ((1000 * this.lifetimeMultiplier_) - (((_local_5 / _local_4) * 900) * this.lifetimeMultiplier_)), 0.5, 0, 0);
            _local_8 = Math.min(_local_5, (_local_4 - _local_5));
            map_.addObj(_local_7, (_local_6.x + RandomUtil.plusMinus(((_local_3 / 200) * _local_8))), (_local_6.y + RandomUtil.plusMinus(((_local_3 / 200) * _local_8))));
            _local_5++;
        }
        return (false);
    }

    override public function runEasyRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_6:Point;
        var _local_7:Particle;
        var _local_8:Number;
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local_3:Number = Point.distance(this.start_, this.end_);
        var _local_4:int = (_local_3 * 2);
        this.particleSize_ = 80;
        var _local_5:int;
        while (_local_5 < _local_4) {
            _local_6 = Point.interpolate(this.start_, this.end_, (_local_5 / _local_4));
            _local_7 = new SparkParticle(this.particleSize_, this.color_, ((750 * this.lifetimeMultiplier_) - (((_local_5 / _local_4) * 675) * this.lifetimeMultiplier_)), 0.5, 0, 0);
            _local_8 = Math.min(_local_5, (_local_4 - _local_5));
            map_.addObj(_local_7, (_local_6.x + RandomUtil.plusMinus(((_local_3 / 200) * _local_8))), (_local_6.y + RandomUtil.plusMinus(((_local_3 / 200) * _local_8))));
            _local_5++;
        }
        return (false);
    }


}
}//package com.company.assembleegameclient.objects.particles
