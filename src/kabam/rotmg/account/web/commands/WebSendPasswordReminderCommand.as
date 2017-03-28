package kabam.rotmg.account.web.commands {
import kabam.lib.tasks.BranchingTask;
import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.TaskGroup;
import kabam.lib.tasks.TaskMonitor;
import kabam.rotmg.account.core.services.SendPasswordReminderTask;
import kabam.rotmg.account.web.view.WebLoginDialog;
import kabam.rotmg.core.signals.TaskErrorSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class WebSendPasswordReminderCommand {

    [Inject]
    public var email:String;
    [Inject]
    public var task:SendPasswordReminderTask;
    [Inject]
    public var monitor:TaskMonitor;
    [Inject]
    public var taskError:TaskErrorSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;


    public function execute():void {
        var _local_1:TaskGroup = new TaskGroup();
        _local_1.add(new DispatchSignalTask(this.openDialog, new WebLoginDialog()));
        var _local_2:TaskGroup = new TaskGroup();
        _local_2.add(new DispatchSignalTask(this.taskError, this.task));
        var _local_3:BranchingTask = new BranchingTask(this.task, _local_1, _local_2);
        this.monitor.add(_local_3);
        _local_3.start();
    }


}
}//package kabam.rotmg.account.web.commands
