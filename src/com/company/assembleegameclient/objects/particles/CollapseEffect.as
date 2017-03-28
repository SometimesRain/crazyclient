package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;

import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class CollapseEffect extends ParticleEffect {

    public var center_:Point;
    public var edgePoint_:Point;
    public var color_:int;

    public function CollapseEffect(_arg_1:GameObject, _arg_2:WorldPosData, _arg_3:WorldPosData, _arg_4:int) {
        this.center_ = new Point(_arg_2.x_, _arg_2.y_);
        this.edgePoint_ = new Point(_arg_3.x_, _arg_3.y_);
        this.color_ = _arg_4;
    }

    override public function runNormalRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_8:Number;
        var _local_9:Point;
        var _local_10:Particle;
        x_ = this.center_.x;
        y_ = this.center_.y;
        var _local_3:Number = Point.distance(this.center_, this.edgePoint_);
        var _local_4:int = 300;
        var _local_5:int = 200;
        var _local_6:int = 24;
        var _local_7:int;
        while (_local_7 < _local_6) {
            _local_8 = (((_local_7 * 2) * Math.PI) / _local_6);
            _local_9 = new Point((this.center_.x + (_local_3 * Math.cos(_local_8))), (this.center_.y + (_local_3 * Math.sin(_local_8))));
            _local_10 = new SparkerParticle(_local_4, this.color_, _local_5, _local_9, this.center_);
            map_.addObj(_local_10, x_, y_);
            _local_7++;
        }
        return (false);
    }

    override public function runEasyRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_8:Number;
        var _local_9:Point;
        var _local_10:Particle;
        x_ = this.center_.x;
        y_ = this.center_.y;
        var _local_3:Number = Point.distance(this.center_, this.edgePoint_);
        var _local_4:int = 50;
        var _local_5:int = 150;
        var _local_6:int = 8;
        var _local_7:int;
        while (_local_7 < _local_6) {
            _local_8 = (((_local_7 * 2) * Math.PI) / _local_6);
            _local_9 = new Point((this.center_.x + (_local_3 * Math.cos(_local_8))), (this.center_.y + (_local_3 * Math.sin(_local_8))));
            _local_10 = new SparkerParticle(_local_4, this.color_, _local_5, _local_9, this.center_);
            map_.addObj(_local_10, x_, y_);
            _local_7++;
        }
        return (false);
    }


}
}//package com.company.assembleegameclient.objects.particles
