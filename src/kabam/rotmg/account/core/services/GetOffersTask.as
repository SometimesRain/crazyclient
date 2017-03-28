package kabam.rotmg.account.core.services {
import com.company.assembleegameclient.util.offer.Offers;

import flash.utils.getTimer;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.model.OfferModel;
import kabam.rotmg.appengine.api.AppEngineClient;

import robotlegs.bender.framework.api.ILogger;

public class GetOffersTask extends BaseTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var model:OfferModel;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var client:AppEngineClient;
    private var target:String;
    private var guid:String;


    override protected function startTask():void {
        this.target = (this.account.getRequestPrefix() + "/getoffers");
        this.guid = this.account.getUserId();
        this.updateModelRequestTimeAndGUID();
        this.sendGetOffersRequest();
    }

    private function updateModelRequestTimeAndGUID():void {
        var _local_1:int = getTimer();
        if (((!((this.guid == this.model.lastOfferRequestGUID))) || (((_local_1 - this.model.lastOfferRequestTime) > OfferModel.TIME_BETWEEN_REQS)))) {
            this.model.lastOfferRequestGUID = this.guid;
            this.model.lastOfferRequestTime = _local_1;
        }
    }

    private function sendGetOffersRequest():void {
        this.client.setMaxRetries(2);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest(this.target, this.makeRequestDataPacket());
    }

    private function makeRequestDataPacket():Object {
        var _local_1:Object = this.account.getCredentials();
        _local_1.time = this.model.lastOfferRequestTime;
        _local_1.game_net_user_id = this.account.gameNetworkUserId();
        _local_1.game_net = this.account.gameNetwork();
        _local_1.play_platform = this.account.playPlatform();
        return (_local_1);
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        if (_arg_1) {
            this.onDataResponse(_arg_2);
        }
        else {
            this.onTextError(_arg_2);
        }
        completeTask(_arg_1);
    }

    private function onDataResponse(_arg_1:String):void {
        this.model.offers = new Offers(new XML(_arg_1));
    }

    private function onTextError(_arg_1:String):void {
        this.logger.error(_arg_1);
    }


}
}//package kabam.rotmg.account.core.services
