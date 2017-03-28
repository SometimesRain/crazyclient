package kabam.rotmg.characters.deletion.control {
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;

import kabam.lib.tasks.BranchingTask;
import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.Task;
import kabam.lib.tasks.TaskMonitor;
import kabam.lib.tasks.TaskSequence;
import kabam.rotmg.characters.deletion.service.DeleteCharacterTask;
import kabam.rotmg.characters.deletion.view.DeletingCharacterView;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class DeleteCharacterCommand {

    [Inject]
    public var task:DeleteCharacterTask;
    [Inject]
    public var monitor:TaskMonitor;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;
    [Inject]
    public var setScreen:SetScreenSignal;


    public function execute():void {
        var _local_1:TaskSequence = new TaskSequence();
        _local_1.add(new DispatchSignalTask(this.openDialog, new DeletingCharacterView()));
        _local_1.add(new BranchingTask(this.task, this.onSuccess(), this.onFailure()));
        this.monitor.add(_local_1);
        _local_1.start();
    }

    private function onSuccess():Task {
        var _local_1:TaskSequence = new TaskSequence();
        _local_1.add(new DispatchSignalTask(this.setScreen, new CharacterSelectionAndNewsScreen()));
        _local_1.add(new DispatchSignalTask(this.closeDialogs));
        return (_local_1);
    }

    private function onFailure():Task {
        return (new DispatchSignalTask(this.openDialog, "Unable to delete character"));
    }


}
}//package kabam.rotmg.characters.deletion.control
