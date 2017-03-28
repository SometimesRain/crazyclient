package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;

import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

public class RisingFuryEffect extends ParticleEffect {

    public var start_:Point;
    public var go:GameObject;
    private var startX:Number;
    private var startY:Number;
    private var particleField:ParticleField;
    private var time:uint;
    private var timer:Timer;
    private var isCharged:Boolean;

    public function RisingFuryEffect(_arg_1:GameObject, _arg_2:uint) {
        this.go = _arg_1;
        this.startX = (Math.floor((_arg_1.x_ * 10)) / 10);
        this.startY = (Math.floor((_arg_1.y_ * 10)) / 10);
        this.time = _arg_2;
        this.createTimer();
        this.createParticleField();
    }

    private function createTimer():void {
        var _local_1:uint = (((this.go.texture_.height == 8)) ? 50 : 30);
        this.timer = new Timer(_local_1, Math.round((this.time / _local_1)));
        this.timer.addEventListener(TimerEvent.TIMER, this.onTimer);
        this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onChargingComplete);
        this.timer.start();
    }

    private function onTimer(_arg_1:TimerEvent):void {
        var _local_2:Number = (Math.floor((this.go.x_ * 10)) / 10);
        var _local_3:Number = (Math.floor((this.go.y_ * 10)) / 10);
        if (((!((this.startX == _local_2))) || (!((this.startY == _local_3))))) {
            this.timer.stop();
            this.particleField.destroy();
        }
    }

    private function onChargingComplete(_arg_1:TimerEvent):void {
        this.particleField.destroy();
        var _local_2:Timer = new Timer(33, 12);
        _local_2.addEventListener(TimerEvent.TIMER, this.onShockTimer);
        _local_2.start();
    }

    private function onShockTimer(_arg_1:TimerEvent):void {
        this.isCharged = !(this.isCharged);
        this.go.toggleChargingEffect(this.isCharged);
    }

    private function createParticleField():void {
        this.particleField = new ParticleField(this.go.texture_.width, this.go.texture_.height);
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        map_.addObj(this.particleField, this.go.x_, this.go.y_);
        return (false);
    }


}
}//package com.company.assembleegameclient.objects.particles
