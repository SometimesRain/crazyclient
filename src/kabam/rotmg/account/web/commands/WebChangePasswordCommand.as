package kabam.rotmg.account.web.commands {
import kabam.lib.tasks.BranchingTask;
import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.Task;
import kabam.lib.tasks.TaskMonitor;
import kabam.lib.tasks.TaskSequence;
import kabam.rotmg.account.core.services.ChangePasswordTask;
import kabam.rotmg.account.web.view.WebAccountDetailDialog;
import kabam.rotmg.core.signals.TaskErrorSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class WebChangePasswordCommand {

    [Inject]
    public var task:ChangePasswordTask;
    [Inject]
    public var monitor:TaskMonitor;
    [Inject]
    public var close:CloseDialogsSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var loginError:TaskErrorSignal;


    public function execute():void {
        var _local_1:BranchingTask = new BranchingTask(this.task, this.makeSuccess(), this.makeFailure());
        this.monitor.add(_local_1);
        _local_1.start();
    }

    private function makeSuccess():Task {
        var _local_1:TaskSequence = new TaskSequence();
        _local_1.add(new DispatchSignalTask(this.openDialog, new WebAccountDetailDialog()));
        return (_local_1);
    }

    private function makeFailure():Task {
        return (new DispatchSignalTask(this.loginError, this.task));
    }


}
}//package kabam.rotmg.account.web.commands
