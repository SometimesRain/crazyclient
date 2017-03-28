package kabam.lib.net.api {
import kabam.lib.net.impl.MessagePool;

public interface MessageMapping {

    function setID(_arg_1:int):MessageMapping;

    function toMessage(_arg_1:Class):MessageMapping;

    function toHandler(_arg_1:Class):MessageMapping;

    function toMethod(_arg_1:Function):MessageMapping;

    function setPopulation(_arg_1:int):MessageMapping;

    function makePool():MessagePool;

}
}//package kabam.lib.net.api
