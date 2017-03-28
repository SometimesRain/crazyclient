package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;

import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

public class ShockeeEffect extends ParticleEffect {

    public var start_:Point;
    public var go:GameObject;
    private var isShocked:Boolean;

    public function ShockeeEffect(_arg_1:GameObject) {
        this.go = _arg_1;
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        var _local_3:Timer = new Timer(50, 12);
        _local_3.addEventListener(TimerEvent.TIMER, this.onTimer);
        _local_3.start();
        return (false);
    }

    private function onTimer(_arg_1:TimerEvent):void {
        this.isShocked = !(this.isShocked);
        this.go.toggleShockEffect(this.isShocked);
    }


}
}//package com.company.assembleegameclient.objects.particles
