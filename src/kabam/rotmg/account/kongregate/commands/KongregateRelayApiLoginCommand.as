package kabam.rotmg.account.kongregate.commands {
import kabam.lib.tasks.BranchingTask;
import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.TaskMonitor;
import kabam.rotmg.account.core.services.RelayLoginTask;
import kabam.rotmg.ui.signals.RefreshScreenAfterLoginSignal;

public class KongregateRelayApiLoginCommand {

    [Inject]
    public var relay:RelayLoginTask;
    [Inject]
    public var monitor:TaskMonitor;
    [Inject]
    public var refresh:RefreshScreenAfterLoginSignal;


    public function execute():void {
        var _local_1:BranchingTask = new BranchingTask(this.relay);
        _local_1.addSuccessTask(new DispatchSignalTask(this.refresh));
        this.monitor.add(_local_1);
        _local_1.start();
    }


}
}//package kabam.rotmg.account.kongregate.commands
