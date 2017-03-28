package kabam.rotmg.account.kongregate.services {
import kabam.lib.tasks.BaseTask;
import kabam.lib.tasks.Task;
import kabam.lib.tasks.TaskMonitor;
import kabam.lib.tasks.TaskSequence;
import kabam.rotmg.account.core.services.LoadAccountTask;

public class KongregateLoadAccountTask extends BaseTask implements LoadAccountTask {

    [Inject]
    public var loadApi:KongregateLoadApiTask;
    [Inject]
    public var getCredentials:KongregateGetCredentialsTask;
    [Inject]
    public var monitor:TaskMonitor;


    override protected function startTask():void {
        var _local_1:TaskSequence = new TaskSequence();
        _local_1.add(this.loadApi);
        _local_1.add(this.getCredentials);
        _local_1.lastly.add(this.onTasksComplete);
        this.monitor.add(_local_1);
        _local_1.start();
    }

    private function onTasksComplete(_arg_1:Task, _arg_2:Boolean, _arg_3:String):void {
        completeTask(true);
    }


}
}//package kabam.rotmg.account.kongregate.services
