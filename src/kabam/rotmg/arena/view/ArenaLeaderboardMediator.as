package kabam.rotmg.arena.view {
import kabam.rotmg.arena.control.ReloadLeaderboard;
import kabam.rotmg.arena.model.ArenaLeaderboardFilter;
import kabam.rotmg.arena.model.ArenaLeaderboardModel;
import kabam.rotmg.arena.service.GetArenaLeaderboardTask;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;

import org.swiftsuspenders.Injector;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ArenaLeaderboardMediator extends Mediator {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var view:ArenaLeaderboard;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;
    [Inject]
    public var reloadLeaderboard:ReloadLeaderboard;
    [Inject]
    public var arenaLeaderboardModel:ArenaLeaderboardModel;


    override public function initialize():void {
        this.reloadLeaderboard.add(this.requestComplete);
        this.view.requestData.add(this.onRequestData);
        this.view.close.add(this.onClose);
        this.view.init();
    }

    override public function destroy():void {
        this.arenaLeaderboardModel.clearFilters();
        this.reloadLeaderboard.remove(this.requestComplete);
        this.view.destroy();
    }

    private function onClose():void {
        this.closeDialogs.dispatch();
    }

    private function onRequestData(_arg_1:ArenaLeaderboardFilter):void {
        var _local_2:GetArenaLeaderboardTask;
        if (_arg_1.hasEntries()) {
            this.view.setList(_arg_1.getEntries());
        }
        else {
            _local_2 = this.injector.getInstance(GetArenaLeaderboardTask);
            _local_2.filter = _arg_1;
            _local_2.start();
        }
    }

    private function requestComplete():void {
        this.view.reloadList();
    }


}
}//package kabam.rotmg.arena.view
