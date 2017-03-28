package kabam.rotmg.legends.service {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.legends.model.Legend;
import kabam.rotmg.legends.model.LegendFactory;
import kabam.rotmg.legends.model.LegendsModel;
import kabam.rotmg.legends.model.Timespan;

public class GetLegendsListTask extends BaseTask {

    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var player:PlayerModel;
    [Inject]
    public var model:LegendsModel;
    [Inject]
    public var factory:LegendFactory;
    [Inject]
    public var timespan:Timespan;
    public var charId:int;


    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/fame/list", this.makeRequestObject());
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        ((_arg_1) && (this.updateFameListData(_arg_2)));
        completeTask(_arg_1, _arg_2);
    }

    private function updateFameListData(_arg_1:String):void {
        var _local_2:Vector.<Legend> = this.factory.makeLegends(XML(_arg_1));
        this.model.setLegendList(_local_2);
    }

    private function makeRequestObject():Object {
        var _local_1:Object = {};
        _local_1.timespan = this.timespan.getId();
        _local_1.accountId = this.player.getAccountId();
        _local_1.charId = this.charId;
        return (_local_1);
    }


}
}//package kabam.rotmg.legends.service
