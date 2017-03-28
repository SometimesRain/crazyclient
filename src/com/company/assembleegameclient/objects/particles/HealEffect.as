package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;

public class HealEffect extends ParticleEffect {

    public var go_:GameObject;
    public var color_:uint;

    public function HealEffect(_arg_1:GameObject, _arg_2:uint) {
        this.go_ = _arg_1;
        this.color_ = _arg_2;
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        var _local_5:Number;
        var _local_6:int;
        var _local_7:Number;
        var _local_8:HealParticle;
        if (this.go_.map_ == null) {
            return (false);
        }
        x_ = this.go_.x_;
        y_ = this.go_.y_;
        var _local_3:int = 10;
        var _local_4:int;
        while (_local_4 < _local_3) {
            _local_5 = ((2 * Math.PI) * (_local_4 / _local_3));
            _local_6 = ((3 + int((Math.random() * 5))) * 20);
            _local_7 = (0.3 + (0.4 * Math.random()));
            _local_8 = new HealParticle(this.color_, (Math.random() * 0.3), _local_6, 1000, (0.1 + (Math.random() * 0.1)), this.go_, _local_5, _local_7);
            map_.addObj(_local_8, (x_ + (_local_7 * Math.cos(_local_5))), (y_ + (_local_7 * Math.sin(_local_5))));
            _local_4++;
        }
        return (false);
    }


}
}//package com.company.assembleegameclient.objects.particles
