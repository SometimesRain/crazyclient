package kabam.rotmg.promotions.service {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.promotions.model.BeginnersPackageModel;

public class GetDaysRemainingTask extends BaseTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var model:BeginnersPackageModel;
    [Inject]
    public var client:AppEngineClient;


    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/account/getBeginnerPackageTimeLeft", this.account.getCredentials());
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        this.onDaysRemainingResponse(_arg_2);
    }

    private function onDaysRemainingResponse(_arg_1:String):void {
        var _local_2:int = new XML(_arg_1)[0];
        this.model.setBeginnersOfferSecondsLeft(_local_2);
        completeTask((_local_2 > 0));
    }


}
}//package kabam.rotmg.promotions.service
