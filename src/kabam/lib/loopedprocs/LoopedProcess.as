package kabam.lib.loopedprocs {
import flash.utils.Dictionary;
import flash.utils.getTimer;

public class LoopedProcess {

    private static var maxId:uint;
    private static var loopProcs:Dictionary = new Dictionary();

    public var id:uint;
    public var paused:Boolean;
    public var interval:uint;
    public var lastRun:int;

    public function LoopedProcess(_arg_1:uint) {
        this.interval = _arg_1;
    }

    public static function addProcess(_arg_1:LoopedProcess):uint {
        if (loopProcs[_arg_1.id] == _arg_1) {
            return (_arg_1.id);
        }
        var _local_2:int = ++maxId;
        loopProcs[_local_2] = _arg_1;
        _arg_1.lastRun = getTimer();
        return (maxId);
    }

    public static function runProcesses(_arg_1:int):void {
        var _local_2:LoopedProcess;
        var _local_3:int;
        for each (_local_2 in loopProcs) {
            if (!_local_2.paused) {
                _local_3 = (_arg_1 - _local_2.lastRun);
                if (_local_3 >= _local_2.interval) {
                    _local_2.lastRun = _arg_1;
                    _local_2.run();
                }
            }
        }
    }

    public static function destroyProcess(_arg_1:LoopedProcess):void {
        delete loopProcs[_arg_1.id];
        _arg_1.onDestroyed();
    }

    public static function destroyAll():void {
        var _local_1:LoopedProcess;
        for each (_local_1 in loopProcs) {
            _local_1.destroy();
        }
        loopProcs = new Dictionary();
    }


    final public function add():void {
        addProcess(this);
    }

    final public function destroy():void {
        destroyProcess(this);
    }

    protected function run():void {
    }

    protected function onDestroyed():void {
    }


}
}//package kabam.lib.loopedprocs
