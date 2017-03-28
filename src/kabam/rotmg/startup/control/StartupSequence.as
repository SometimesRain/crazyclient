package kabam.rotmg.startup.control {
import kabam.lib.tasks.BaseTask;
import kabam.lib.tasks.Task;
import kabam.rotmg.startup.model.api.StartupDelegate;
import kabam.rotmg.startup.model.impl.SignalTaskDelegate;
import kabam.rotmg.startup.model.impl.TaskDelegate;

import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.api.ILogger;

public class StartupSequence extends BaseTask {

    public static const LAST:int = int.MAX_VALUE;//2147483647

    private const list:Vector.<StartupDelegate> = new Vector.<StartupDelegate>(0);

    [Inject]
    public var injector:Injector;
    [Inject]
    public var logger:ILogger;
    private var index:int = 0;


    public function addSignal(_arg_1:Class, _arg_2:int = 0):void {
        var _local_3:SignalTaskDelegate = new SignalTaskDelegate();
        _local_3.injector = this.injector;
        _local_3.signalClass = _arg_1;
        _local_3.priority = _arg_2;
        this.list.push(_local_3);
    }

    public function addTask(_arg_1:Class, _arg_2:int = 0):void {
        var _local_3:TaskDelegate = new TaskDelegate();
        _local_3.injector = this.injector;
        _local_3.taskClass = _arg_1;
        _local_3.priority = _arg_2;
		/*trace("STARTUP TRACE");
		trace("arg1 "+_arg_1);
		trace("arg2 "+_arg_2);*/
        this.list.push(_local_3);
    }

    override protected function startTask():void {
        this.list.sort(this.priorityComparison);
        this.index = 0;
        this.doNextTaskOrComplete();
    }

    private function priorityComparison(_arg_1:StartupDelegate, _arg_2:StartupDelegate):int {
        return ((_arg_1.getPriority() - _arg_2.getPriority()));
    }

    private function doNextTaskOrComplete():void {
        if (this.isAnotherTask()) {
            this.doNextTask();
        }
        else {
            completeTask(true);
        }
    }

    private function isAnotherTask():Boolean {
        return ((this.index < this.list.length));
    }

    private function doNextTask():void {
        var _local_1:Task = this.list[this.index++].make();
        _local_1.lastly.addOnce(this.onTaskFinished);
        this.logger.info("StartupSequence start:{0}", [_local_1]);
        _local_1.start();
    }

    private function onTaskFinished(_arg_1:Task, _arg_2:Boolean, _arg_3:String):void {
        this.logger.info("StartupSequence finish:{0} (isOK: {1})", [_arg_1, _arg_2]);
        if (_arg_2) {
            this.doNextTaskOrComplete();
        }
        else {
            completeTask(false, _arg_3);
        }
    }


}
}//package kabam.rotmg.startup.control
