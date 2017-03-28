package kabam.rotmg.appengine.impl {
import flash.events.EventDispatcher;
import flash.utils.getTimer;

import kabam.rotmg.appengine.api.AppEngineClient;

import org.osflash.signals.OnceSignal;

public class StatsRecorderAppEngineClient extends EventDispatcher implements AppEngineClient {

    [Inject]
    public var stats:AppEngineRequestStats;
    [Inject]
    public var wrapped:SimpleAppEngineClient;
    private var timeAtRequest:int;
    private var target:String;


    public function get complete():OnceSignal {
        return (this.wrapped.complete);
    }

    public function setDataFormat(_arg_1:String):void {
        this.wrapped.setDataFormat(_arg_1);
    }

    public function setSendEncrypted(_arg_1:Boolean):void {
        this.wrapped.setSendEncrypted(_arg_1);
    }

    public function setMaxRetries(_arg_1:int):void {
        this.wrapped.setMaxRetries(_arg_1);
    }

    public function sendRequest(_arg_1:String, _arg_2:Object):void {
        this.timeAtRequest = getTimer();
        this.target = _arg_1;
        this.wrapped.complete.addOnce(this.onComplete);
        this.wrapped.sendRequest(_arg_1, _arg_2);
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        this.stats.recordStats(this.target, _arg_1, (getTimer() - this.timeAtRequest));
    }

    public function requestInProgress():Boolean {
        return (false);
    }


}
}//package kabam.rotmg.appengine.impl
