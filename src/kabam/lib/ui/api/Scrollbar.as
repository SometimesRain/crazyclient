package kabam.lib.ui.api {
import org.osflash.signals.Signal;

public interface Scrollbar {

    function get positionChanged():Signal;

    function setSize(_arg_1:int, _arg_2:int):void;

    function getBarSize():int;

    function getGrooveSize():int;

    function getPosition():Number;

    function setPosition(_arg_1:Number):void;

}
}//package kabam.lib.ui.api
