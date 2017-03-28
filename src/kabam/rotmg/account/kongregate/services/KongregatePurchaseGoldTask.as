package kabam.rotmg.account.kongregate.services {
import com.company.assembleegameclient.util.offer.Offer;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.services.PurchaseGoldTask;
import kabam.rotmg.account.kongregate.view.KongregateApi;
import kabam.rotmg.external.command.RequestPlayerCreditsSignal;

public class KongregatePurchaseGoldTask extends BaseTask implements PurchaseGoldTask {

    [Inject]
    public var offer:Offer;
    [Inject]
    public var api:KongregateApi;
    [Inject]
    public var requestPlayerCredits:RequestPlayerCreditsSignal;


    override protected function startTask():void {
        var _local_1:Object = {
            "identifier": this.offer.id_,
            "data": this.offer.data_
        };
        this.api.purchaseResponse.addOnce(this.onPurchaseResult);
        this.api.purchaseItems(_local_1);
    }

    private function onPurchaseResult(_arg_1:Object):void {
        this.requestPlayerCredits.dispatch();
        completeTask(true);
    }


}
}//package kabam.rotmg.account.kongregate.services
