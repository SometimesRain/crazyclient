package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;

import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class FlowEffect extends ParticleEffect {

    public var start_:Point;
    public var go_:GameObject;
    public var color_:int;

    public function FlowEffect(_arg_1:WorldPosData, _arg_2:GameObject, _arg_3:int) {
        this.start_ = new Point(_arg_1.x_, _arg_1.y_);
        this.go_ = _arg_2;
        this.color_ = _arg_3;
    }

    override public function runNormalRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_5:int;
        var _local_6:Particle;
        if (FlowParticle.total_ > 200) {
            return (false);
        }
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local_3:int = 5;
        var _local_4:int;
        while (_local_4 < _local_3) {
            _local_5 = ((3 + int((Math.random() * 5))) * 20);
            _local_6 = new FlowParticle(0.5, _local_5, this.color_, this.start_, this.go_);
            map_.addObj(_local_6, x_, y_);
            _local_4++;
        }
        return (false);
    }

    override public function runEasyRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_5:int;
        var _local_6:Particle;
        if (FlowParticle.total_ > 200) {
            return (false);
        }
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local_3:int = 3;
        var _local_4:int;
        while (_local_4 < _local_3) {
            _local_5 = ((3 + int((Math.random() * 5))) * 10);
            _local_6 = new FlowParticle(0.5, _local_5, this.color_, this.start_, this.go_);
            map_.addObj(_local_6, x_, y_);
            _local_4++;
        }
        return (false);
    }


}
}//package com.company.assembleegameclient.objects.particles

import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.particles.Particle;

import flash.geom.Point;

class FlowParticle extends Particle {

    public static var total_:int = 0;

    public var start_:Point;
    public var go_:GameObject;
    public var maxDist_:Number;
    public var flowSpeed_:Number;

    public function FlowParticle(_arg_1:Number, _arg_2:int, _arg_3:int, _arg_4:Point, _arg_5:GameObject) {
        super(_arg_3, _arg_1, _arg_2);
        this.start_ = _arg_4;
        this.go_ = _arg_5;
        var _local_6:Point = new Point(x_, y_);
        var _local_7:Point = new Point(this.go_.x_, this.go_.y_);
        this.maxDist_ = Point.distance(_local_6, _local_7);
        this.flowSpeed_ = (Math.random() * 5);
        total_++;
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        var _local_3:Number = 8;
        var _local_4:Point = new Point(x_, y_);
        var _local_5:Point = new Point(this.go_.x_, this.go_.y_);
        var _local_6:Number = Point.distance(_local_4, _local_5);
        if (_local_6 < 0.5) {
            total_--;
            return (false);
        }
        this.flowSpeed_ = (this.flowSpeed_ + ((_local_3 * _arg_2) / 1000));
        this.maxDist_ = (this.maxDist_ - ((this.flowSpeed_ * _arg_2) / 1000));
        var _local_7:Number = (_local_6 - ((this.flowSpeed_ * _arg_2) / 1000));
        if (_local_7 > this.maxDist_) {
            _local_7 = this.maxDist_;
        }
        var _local_8:Number = (this.go_.x_ - x_);
        var _local_9:Number = (this.go_.y_ - y_);
        _local_8 = (_local_8 * (_local_7 / _local_6));
        _local_9 = (_local_9 * (_local_7 / _local_6));
        moveTo((this.go_.x_ - _local_8), (this.go_.y_ - _local_9));
        return (true);
    }


}
class FlowParticle2 extends Particle {

    public var start_:Point;
    public var go_:GameObject;
    public var accel_:Number;
    public var dx_:Number;
    public var dy_:Number;

    public function FlowParticle2(_arg_1:Number, _arg_2:int, _arg_3:int, _arg_4:Number, _arg_5:Point, _arg_6:GameObject) {
        super(_arg_3, _arg_1, _arg_2);
        this.start_ = _arg_5;
        this.go_ = _arg_6;
        this.accel_ = _arg_4;
        this.dx_ = (Math.random() - 0.5);
        this.dy_ = (Math.random() - 0.5);
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        var _local_3:Point = new Point(x_, y_);
        var _local_4:Point = new Point(this.go_.x_, this.go_.y_);
        var _local_5:Number = Point.distance(_local_3, _local_4);
        if (_local_5 < 0.5) {
            return (false);
        }
        var _local_6:Number = Math.atan2((this.go_.y_ - y_), (this.go_.x_ - x_));
        this.dx_ = (this.dx_ + (((this.accel_ * Math.cos(_local_6)) * _arg_2) / 1000));
        this.dy_ = (this.dy_ + (((this.accel_ * Math.sin(_local_6)) * _arg_2) / 1000));
        var _local_7:Number = (x_ + ((this.dx_ * _arg_2) / 1000));
        var _local_8:Number = (y_ + ((this.dy_ * _arg_2) / 1000));
        moveTo(_local_7, _local_8);
        return (true);
    }


}
