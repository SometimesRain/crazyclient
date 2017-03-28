package kabam.rotmg.legends.control {
import kabam.lib.tasks.BranchingTask;
import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.Task;
import kabam.lib.tasks.TaskMonitor;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.TaskErrorSignal;
import kabam.rotmg.death.model.DeathModel;
import kabam.rotmg.fame.model.FameModel;
import kabam.rotmg.legends.service.GetLegendsListTask;

public class RequestFameListCommand {

    [Inject]
    public var task:GetLegendsListTask;
    [Inject]
    public var update:FameListUpdateSignal;
    [Inject]
    public var error:TaskErrorSignal;
    [Inject]
    public var monitor:TaskMonitor;
    [Inject]
    public var player:PlayerModel;
    [Inject]
    public var death:DeathModel;
    [Inject]
    public var model:FameModel;


    public function execute():void {
        this.task.charId = this.getCharId();
        var _local_1:BranchingTask = new BranchingTask(this.task, this.makeSuccess(), this.makeFailure());
        this.monitor.add(_local_1);
        _local_1.start();
    }

    private function getCharId():int {
        if (((this.player.hasAccount()) && (this.death.getIsDeathViewPending()))) {
            return (this.death.getLastDeath().charId_);
        }
        return (-1);
    }

    private function makeSuccess():Task {
        return (new DispatchSignalTask(this.update));
    }

    private function makeFailure():Task {
        return (new DispatchSignalTask(this.error, this.task));
    }


}
}//package kabam.rotmg.legends.control
