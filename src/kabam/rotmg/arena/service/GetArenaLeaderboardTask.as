package kabam.rotmg.arena.service {
import com.company.util.MoreObjectUtil;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.arena.control.ReloadLeaderboard;
import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
import kabam.rotmg.arena.model.ArenaLeaderboardFilter;

public class GetArenaLeaderboardTask extends BaseTask {

    private static const REQUEST:String = "arena/getRecords";

    [Inject]
    public var account:Account;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var factory:ArenaLeaderboardFactory;
    [Inject]
    public var reloadLeaderboard:ReloadLeaderboard;
    public var filter:ArenaLeaderboardFilter;


    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest(REQUEST, this.makeRequestObject());
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        ((_arg_1) && (this.updateLeaderboard(_arg_2)));
        completeTask(_arg_1, _arg_2);
    }

    private function updateLeaderboard(_arg_1:String):void {
        var _local_2:Vector.<ArenaLeaderboardEntry> = this.factory.makeEntries(XML(_arg_1).Record);
        this.filter.setEntries(_local_2);
        this.reloadLeaderboard.dispatch();
    }

    private function makeRequestObject():Object {
        var _local_1:Object = {"type": this.filter.getKey()};
        MoreObjectUtil.addToObject(_local_1, this.account.getCredentials());
        return (_local_1);
    }


}
}//package kabam.rotmg.arena.service
