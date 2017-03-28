package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.thrown.BitmapParticle;
import com.company.assembleegameclient.parameters.Parameters;

import flash.display.BitmapData;
import flash.geom.Point;

public class ShockParticle extends BitmapParticle {

    private var numFramesRemaining:int;
    private var dx_:Number;
    private var dy_:Number;
    private var originX:Number;
    private var originY:Number;
    private var radians:Number;
    private var frameUpdateModulator:uint = 0;
    private var currentFrame:uint = 0;
    private var numFrames:uint;
    private var go:GameObject;
    private var plusX:Number = 0;
    private var plusY:Number = 0;
    private var cameraAngle:Number;
    private var images:Vector.<BitmapData>;

    public function ShockParticle(_arg_1:uint, _arg_2:int, _arg_3:uint, _arg_4:Point, _arg_5:Point, _arg_6:Number, _arg_7:GameObject, _arg_8:Vector.<BitmapData>) {
        this.cameraAngle = Parameters.data_.cameraAngle;
        this.go = _arg_7;
        this.radians = _arg_6;
        this.images = _arg_8;
        super(_arg_8[0], 0);
        this.numFrames = _arg_8.length;
        this.numFramesRemaining = _arg_2;
        this.dx_ = ((_arg_5.x - _arg_4.x) / this.numFramesRemaining);
        this.dy_ = ((_arg_5.y - _arg_4.y) / this.numFramesRemaining);
        this.originX = (_arg_4.x - _arg_7.x_);
        this.originY = (_arg_4.y - _arg_7.y_);
        _rotation = (-(_arg_6) - this.cameraAngle);
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        this.numFramesRemaining--;
        if (this.numFramesRemaining <= 0) {
            return (false);
        }
        this.frameUpdateModulator++;
        if ((this.frameUpdateModulator % 2)) {
            this.currentFrame++;
        }
        _bitmapData = this.images[(this.currentFrame % this.numFrames)];
        this.plusX = (this.plusX + this.dx_);
        this.plusY = (this.plusY + this.dy_);
        if (Parameters.data_.cameraAngle != this.cameraAngle) {
            this.cameraAngle = Parameters.data_.cameraAngle;
            _rotation = (-(this.radians) - this.cameraAngle);
        }
        moveTo(((this.go.x_ + this.originX) + this.plusX), ((this.go.y_ + this.originY) + this.plusY));
        return (true);
    }


}
}//package com.company.assembleegameclient.objects.particles
