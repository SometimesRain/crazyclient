package kabam.lib.tasks {
import org.osflash.signals.Signal;

public interface Task {

    function start():void;

    function reset():void;

    function get started():Signal;

    function get finished():TaskResultSignal;

    function get lastly():TaskResultSignal;

    function get isStarted():Boolean;

    function get isFinished():Boolean;

    function get isOK():Boolean;

    function get error():String;

}
}//package kabam.lib.tasks
