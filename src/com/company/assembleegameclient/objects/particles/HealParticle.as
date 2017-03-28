package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;

import flash.geom.Vector3D;

public class HealParticle extends Particle {

    public var timeLeft_:int;
    public var go_:GameObject;
    public var angle_:Number;
    public var dist_:Number;
    protected var moveVec_:Vector3D;

    public function HealParticle(_arg_1:uint, _arg_2:Number, _arg_3:int, _arg_4:int, _arg_5:Number, _arg_6:GameObject, _arg_7:Number, _arg_8:Number) {
        this.moveVec_ = new Vector3D();
        super(_arg_1, _arg_2, _arg_3);
        this.moveVec_.z = _arg_5;
        this.timeLeft_ = _arg_4;
        this.go_ = _arg_6;
        this.angle_ = _arg_7;
        this.dist_ = _arg_8;
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        this.timeLeft_ = (this.timeLeft_ - _arg_2);
        if (this.timeLeft_ <= 0) {
            return (false);
        }
        x_ = (this.go_.x_ + (this.dist_ * Math.cos(this.angle_)));
        y_ = (this.go_.y_ + (this.dist_ * Math.sin(this.angle_)));
        z_ = (z_ + ((this.moveVec_.z * _arg_2) * 0.008));
        return (true);
    }


}
}//package com.company.assembleegameclient.objects.particles
