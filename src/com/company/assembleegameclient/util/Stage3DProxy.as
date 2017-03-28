package com.company.assembleegameclient.util {
import flash.display.Stage3D;
import flash.events.Event;
import flash.events.IEventDispatcher;

import kabam.rotmg.stage3D.proxies.Context3DProxy;

public class Stage3DProxy implements IEventDispatcher {

    private static var context3D:Context3DProxy;

    private var stage3D:Stage3D;

    public function Stage3DProxy(_arg_1:Stage3D) {
        this.stage3D = _arg_1;
    }

    public function requestContext3D():void {
        this.stage3D.requestContext3D();
    }

    public function getContext3D():Context3DProxy {
        if (context3D == null) {
            context3D = new Context3DProxy(this.stage3D.context3D);
        }
        return (context3D);
    }

    public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean = false, _arg_4:int = 0, _arg_5:Boolean = false):void {
        this.stage3D.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
    }

    public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean = false):void {
        this.stage3D.removeEventListener(_arg_1, _arg_2, _arg_3);
    }

    public function dispatchEvent(_arg_1:Event):Boolean {
        return (this.stage3D.dispatchEvent(_arg_1));
    }

    public function hasEventListener(_arg_1:String):Boolean {
        return (this.stage3D.hasEventListener(_arg_1));
    }

    public function willTrigger(_arg_1:String):Boolean {
        return (this.stage3D.willTrigger(_arg_1));
    }


}
}//package com.company.assembleegameclient.util
