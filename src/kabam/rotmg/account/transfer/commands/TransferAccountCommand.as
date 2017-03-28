package kabam.rotmg.account.transfer.commands {
import com.company.assembleegameclient.ui.dialogs.DebugDialog;
import com.company.util.HTMLUtil;

import kabam.lib.tasks.BranchingTask;
import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.Task;
import kabam.lib.tasks.TaskMonitor;
import kabam.lib.tasks.TaskSequence;
import kabam.rotmg.account.core.services.MigrateAccountTask;
import kabam.rotmg.account.core.signals.UpdateAccountInfoSignal;
import kabam.rotmg.account.transfer.model.TransferAccountData;
import kabam.rotmg.application.model.PlatformModel;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.signals.TaskErrorSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class TransferAccountCommand {

    [Inject]
    public var task:MigrateAccountTask;
    [Inject]
    public var updateAccount:UpdateAccountInfoSignal;
    [Inject]
    public var taskError:TaskErrorSignal;
    [Inject]
    public var monitor:TaskMonitor;
    [Inject]
    public var close:CloseDialogsSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var loginError:TaskErrorSignal;
    [Inject]
    public var data:TransferAccountData;


    public function execute():void {
        var _local_1:BranchingTask = new BranchingTask(this.task, this.makeSuccess(), this.makeFailure());
        this.monitor.add(_local_1);
        _local_1.start();
    }

    private function makeSuccess():Task {
        var _local_1:TaskSequence = new TaskSequence();
        var _local_2:PlatformModel = StaticInjectorContext.getInjector().getInstance(PlatformModel);
        _local_1.add(new DispatchSignalTask(this.updateAccount));
        _local_1.add(new DispatchSignalTask(this.openDialog, new DebugDialog((this.data.newEmail + " please check your inbox."), "Email Verification Sent!", HTMLUtil.refreshPageNoParams)));
        return (_local_1);
    }

    private function makeFailure():Task {
        return (new DispatchSignalTask(this.loginError, this.task));
    }


}
}//package kabam.rotmg.account.transfer.commands
