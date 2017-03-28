package kabam.rotmg.death.control {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.TaskMonitor;
import kabam.lib.tasks.TaskSequence;
import kabam.rotmg.account.core.services.GetCharListTask;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.fame.control.ShowFameViewSignal;
import kabam.rotmg.fame.model.FameVO;
import kabam.rotmg.fame.model.SimpleFameVO;
import kabam.rotmg.messaging.impl.incoming.Death;

public class HandleNormalDeathCommand {

    [Inject]
    public var death:Death;
    [Inject]
    public var player:PlayerModel;
    [Inject]
    public var task:GetCharListTask;
    [Inject]
    public var showFame:ShowFameViewSignal;
    [Inject]
    public var monitor:TaskMonitor;
    private var fameVO:FameVO;


    public function execute():void {
        this.fameVO = new SimpleFameVO(this.death.accountId_, this.death.charId_);
        this.updateParameters();
        this.gotoFameView();
    }

    private function updateParameters():void {
        Parameters.data_.needsRandomRealm = false;
        Parameters.save();
    }

    private function gotoFameView():void {
        if (this.player.getAccountId() == "") {
            this.gotoFameViewOnceDataIsLoaded();
        }
        else {
            this.showFame.dispatch(this.fameVO);
        }
    }

    private function gotoFameViewOnceDataIsLoaded():void {
        var _local_1:TaskSequence = new TaskSequence();
        _local_1.add(this.task);
        _local_1.add(new DispatchSignalTask(this.showFame, this.fameVO));
        this.monitor.add(_local_1);
        _local_1.start();
    }


}
}//package kabam.rotmg.death.control
