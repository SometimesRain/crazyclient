package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.FreeList;

public class FountainEffect extends ParticleEffect {

    public var go_:GameObject;
    public var color_:uint;
    public var lastUpdate_:int = -1;

    public function FountainEffect(_arg_1:GameObject, _arg_2:EffectProperties) {
        this.go_ = _arg_1;
        this.color_ = _arg_2.color;
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        var _local_4:int;
        var _local_5:FountainParticle;
        if (this.go_.map_ == null) {
            return (false);
        }
        if (this.lastUpdate_ < 0) {
            this.lastUpdate_ = Math.max(0, (_arg_1 - 400));
        }
        x_ = this.go_.x_;
        y_ = this.go_.y_;
        var _local_3:int = (this.lastUpdate_ / 50);
        while (_local_3 < (_arg_1 / 50)) {
            _local_4 = (_local_3 * 50);
            _local_5 = (FreeList.newObject(FountainParticle) as FountainParticle);
            _local_5.setColor(this.color_);
            _local_5.restart(_local_4, _arg_1);
            map_.addObj(_local_5, x_, y_);
            _local_3++;
        }
        this.lastUpdate_ = _arg_1;
        return (true);
    }


}
}//package com.company.assembleegameclient.objects.particles

import com.company.assembleegameclient.objects.particles.Particle;
import com.company.assembleegameclient.util.FreeList;

import flash.geom.Vector3D;

class FountainParticle extends Particle {

    private static const G:Number = -4.9;
    private static const VI:Number = 6.5;
    private static const ZI:Number = 0.75;

    public var startTime_:int;
    protected var moveVec_:Vector3D;

    public function FountainParticle(_arg_1:uint = 0x4165D5) {
        this.moveVec_ = new Vector3D();
        super(_arg_1, ZI, 100);
    }

    public function restart(_arg_1:int, _arg_2:int):void {
        var _local_3:Number = ((2 * Math.PI) * Math.random());
        this.moveVec_.x = Math.cos(_local_3);
        this.moveVec_.y = Math.sin(_local_3);
        this.startTime_ = _arg_1;
        var _local_4:int = (_arg_2 - this.startTime_);
        x_ = (x_ + ((this.moveVec_.x * _local_4) * 0.0008));
        y_ = (y_ + ((this.moveVec_.y * _local_4) * 0.0008));
        var _local_5:Number = ((_arg_2 - this.startTime_) / 1000);
        z_ = ((0.75 + (VI * _local_5)) + (G * (_local_5 * _local_5)));
    }

    override public function removeFromMap():void {
        super.removeFromMap();
        FreeList.deleteObject(this);
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        var _local_3:Number = ((_arg_1 - this.startTime_) / 1000);
        moveTo((x_ + ((this.moveVec_.x * _arg_2) * 0.0008)), (y_ + ((this.moveVec_.y * _arg_2) * 0.0008)));
        z_ = ((0.75 + (VI * _local_3)) + (G * (_local_3 * _local_3)));
        return ((z_ > 0));
    }


}
