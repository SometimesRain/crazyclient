package kabam.rotmg.arena.view {
import flash.events.TimerEvent;
import flash.utils.Timer;

import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
import kabam.rotmg.arena.model.BestArenaRunModel;
import kabam.rotmg.arena.model.CurrentArenaRunModel;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.maploading.signals.HideMapLoadingSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class BattleSummaryDialogMediator extends Mediator {

    [Inject]
    public var view:BattleSummaryDialog;
    [Inject]
    public var closeMapLoading:HideMapLoadingSignal;
    [Inject]
    public var currentRunModel:CurrentArenaRunModel;
    [Inject]
    public var bestRunModel:BestArenaRunModel;
    [Inject]
    public var openDialog:OpenDialogSignal;
    private var fadeOutTimer:Timer;

    public function BattleSummaryDialogMediator() {
        this.fadeOutTimer = new Timer(800, 1);
        super();
    }

    override public function initialize():void {
        this.view.visible = false;
        this.view.positionThis();
        this.view.setCurrentRun(this.currentRunModel.entry.currentWave, this.currentRunModel.entry.runtime);
        var _local_1:Boolean = (((this.bestRunModel.entry.currentWave > this.currentRunModel.entry.currentWave)) || ((((this.bestRunModel.entry.currentWave == this.currentRunModel.entry.currentWave)) && ((this.bestRunModel.entry.runtime < this.currentRunModel.entry.runtime)))));
        var _local_2:ArenaLeaderboardEntry = ((_local_1) ? this.bestRunModel.entry : this.currentRunModel.entry);
        this.view.setBestRun(_local_2.currentWave, _local_2.runtime);
        this.view.close.add(this.onClose);
        this.closeMapLoading.addOnce(this.startTimer);
    }

    private function onClose():void {
        this.openDialog.dispatch(new ArenaLeaderboard());
    }

    private function startTimer():void {
        this.fadeOutTimer.addEventListener(TimerEvent.TIMER, this.showBattleSummaryDialog);
        this.fadeOutTimer.start();
    }

    private function showBattleSummaryDialog(_arg_1:TimerEvent):void {
        this.fadeOutTimer.removeEventListener(TimerEvent.TIMER, this.showBattleSummaryDialog);
        this.view.visible = true;
    }

    override public function destroy():void {
        this.view.close.remove(this.onClose);
    }


}
}//package kabam.rotmg.arena.view
