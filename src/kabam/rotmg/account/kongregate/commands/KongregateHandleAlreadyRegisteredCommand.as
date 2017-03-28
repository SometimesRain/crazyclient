package kabam.rotmg.account.kongregate.commands {
import kabam.lib.tasks.BranchingTask;
import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.TaskMonitor;
import kabam.rotmg.account.core.services.LoginTask;
import kabam.rotmg.ui.signals.RefreshScreenAfterLoginSignal;

public class KongregateHandleAlreadyRegisteredCommand {

    [Inject]
    public var login:LoginTask;
    [Inject]
    public var monitor:TaskMonitor;
    [Inject]
    public var refresh:RefreshScreenAfterLoginSignal;


    public function execute():void {
        var _local_1:BranchingTask = new BranchingTask(this.login);
        _local_1.addSuccessTask(new DispatchSignalTask(this.refresh));
        this.monitor.add(_local_1);
        _local_1.start();
    }


}
}//package kabam.rotmg.account.kongregate.commands
