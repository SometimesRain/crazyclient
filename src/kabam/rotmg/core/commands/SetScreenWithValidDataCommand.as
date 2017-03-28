package kabam.rotmg.core.commands {
import com.company.assembleegameclient.screens.LoadingScreen;

import flash.display.Sprite;

import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.TaskMonitor;
import kabam.lib.tasks.TaskSequence;
import kabam.rotmg.account.core.services.GetCharListTask;
import kabam.rotmg.dailyLogin.tasks.FetchPlayerCalendarTask;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.SetScreenSignal;

public class SetScreenWithValidDataCommand {

    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var setScreen:SetScreenSignal;
    [Inject]
    public var view:Sprite;
    [Inject]
    public var monitor:TaskMonitor;
    [Inject]
    public var task:GetCharListTask;
    [Inject]
    public var calendarTask:FetchPlayerCalendarTask;


    public function execute():void {
        if (this.model.isInvalidated) {
            this.reloadDataThenSetScreen();
        }
        else {
            this.setScreen.dispatch(this.view);
        }
    }

    private function reloadDataThenSetScreen():void {
        this.setScreen.dispatch(new LoadingScreen());
        var _local_1:TaskSequence = new TaskSequence();
        _local_1.add(this.task);
		_local_1.add(this.calendarTask);
        _local_1.add(new DispatchSignalTask(this.setScreen, this.view));
        this.monitor.add(_local_1);
        _local_1.start();
    }


}
}//package kabam.rotmg.core.commands
