package com.company.assembleegameclient.objects.thrown {
import com.company.assembleegameclient.objects.particles.ParticleEffect;

import flash.geom.Point;

public class ThrowProjectileEffect extends ParticleEffect {

    public var start_:Point;
    public var end_:Point;
    public var id_:uint;

    public function ThrowProjectileEffect(_arg_1:int, _arg_2:Point, _arg_3:Point) {
        this.start_ = _arg_2;
        this.end_ = _arg_3;
        this.id_ = _arg_1;
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local_3:int = 10000;
        var _local_4:ThrownProjectile = new ThrownProjectile(this.id_, 1500, this.start_, this.end_);
        map_.addObj(_local_4, x_, y_);
        return (false);
    }


}
}//package com.company.assembleegameclient.objects.thrown
