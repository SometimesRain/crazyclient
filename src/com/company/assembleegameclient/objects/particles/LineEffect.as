package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.RandomUtil;

import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class LineEffect extends ParticleEffect {

    public var start_:Point;
    public var end_:Point;
    public var color_:int;

    public function LineEffect(_arg_1:GameObject, _arg_2:WorldPosData, _arg_3:int) {
        this.start_ = new Point(_arg_1.x_, _arg_1.y_);
        this.end_ = new Point(_arg_2.x_, _arg_2.y_);
        this.color_ = _arg_3;
    }

    override public function runNormalRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_5:Point;
        var _local_6:Particle;
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local_3:int = 30;
        var _local_4:int;
        while (_local_4 < _local_3) {
            _local_5 = Point.interpolate(this.start_, this.end_, (_local_4 / _local_3));
            _local_6 = new SparkParticle(100, this.color_, 700, 0.5, RandomUtil.plusMinus(1), RandomUtil.plusMinus(1));
            map_.addObj(_local_6, _local_5.x, _local_5.y);
            _local_4++;
        }
        return (false);
    }

    override public function runEasyRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_5:Point;
        var _local_6:Particle;
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local_3:int = 5;
        var _local_4:int;
        while (_local_4 < _local_3) {
            _local_5 = Point.interpolate(this.start_, this.end_, (_local_4 / _local_3));
            _local_6 = new SparkParticle(100, this.color_, 200, 0.5, RandomUtil.plusMinus(1), RandomUtil.plusMinus(1));
            map_.addObj(_local_6, _local_5.x, _local_5.y);
            _local_4++;
        }
        return (false);
    }


}
}//package com.company.assembleegameclient.objects.particles
