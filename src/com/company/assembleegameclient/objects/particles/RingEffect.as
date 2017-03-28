package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;

import flash.geom.Point;

public class RingEffect extends ParticleEffect {

    public var start_:Point;
    public var novaRadius_:Number;
    public var color_:int;

    public function RingEffect(_arg_1:GameObject, _arg_2:Number, _arg_3:int) {
        this.start_ = new Point(_arg_1.x_, _arg_1.y_);
        this.novaRadius_ = _arg_2;
        this.color_ = _arg_3;
    }

    override public function runNormalRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_7:Number;
        var _local_8:Point;
        var _local_9:Point;
        var _local_10:Particle;
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local_3:int;
        var _local_4:int = 12;
        var _local_5:int = 200;
        var _local_6:int;
        while (_local_6 < _local_4) {
            _local_7 = (((_local_6 * 2) * Math.PI) / _local_4);
            _local_8 = new Point((this.start_.x + (this.novaRadius_ * Math.cos(_local_7))), (this.start_.y + (this.novaRadius_ * Math.sin(_local_7))));
            _local_9 = new Point((this.start_.x + ((this.novaRadius_ * 0.9) * Math.cos(_local_7))), (this.start_.y + ((this.novaRadius_ * 0.9) * Math.sin(_local_7))));
            _local_10 = new SparkerParticle(_local_3, this.color_, _local_5, _local_9, _local_8);
            map_.addObj(_local_10, x_, y_);
            _local_6++;
        }
        return (false);
    }

    override public function runEasyRendering(_arg_1:int, _arg_2:int):Boolean {
        var _local_7:Number;
        var _local_8:Point;
        var _local_9:Point;
        var _local_10:Particle;
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local_3:int;
        var _local_4:int = 10;
        var _local_5:int = 50;
        var _local_6:int;
        while (_local_6 < _local_4) {
            _local_7 = (((_local_6 * 2) * Math.PI) / _local_4);
            _local_8 = new Point((this.start_.x + (this.novaRadius_ * Math.cos(_local_7))), (this.start_.y + (this.novaRadius_ * Math.sin(_local_7))));
            _local_9 = new Point((this.start_.x + ((this.novaRadius_ * 0.9) * Math.cos(_local_7))), (this.start_.y + ((this.novaRadius_ * 0.9) * Math.sin(_local_7))));
            _local_10 = new SparkerParticle(_local_3, this.color_, _local_5, _local_9, _local_8);
            map_.addObj(_local_10, x_, y_);
            _local_6++;
        }
        return (false);
    }


}
}//package com.company.assembleegameclient.objects.particles
