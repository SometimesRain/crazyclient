package kabam.rotmg.appengine.api {
import org.osflash.signals.OnceSignal;

public interface RetryLoader {

    function get complete():OnceSignal;

    function setMaxRetries(_arg_1:int):void;

    function setDataFormat(_arg_1:String):void;

    function sendRequest(_arg_1:String, _arg_2:Object):void;

    function isInProgress():Boolean;

}
}//package kabam.rotmg.appengine.api
