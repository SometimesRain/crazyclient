package kabam.rotmg.arena.service {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.arena.model.BestArenaRunModel;

public class GetBestArenaRunTask extends BaseTask {

    private static const REQUEST:String = "arena/getPersonalBest";

    [Inject]
    public var account:Account;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var bestRunModel:BestArenaRunModel;


    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest(REQUEST, this.makeRequestObject());
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        ((_arg_1) && (this.updateBestRun(_arg_2)));
        completeTask(_arg_1, _arg_2);
    }

    private function updateBestRun(_arg_1:String):void {
        var _local_2:XML = XML(_arg_1);
        this.bestRunModel.entry.runtime = _local_2.Record.Time;
        this.bestRunModel.entry.currentWave = _local_2.Record.WaveNumber;
    }

    private function makeRequestObject():Object {
        return (this.account.getCredentials());
    }


}
}//package kabam.rotmg.arena.service
