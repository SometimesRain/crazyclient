package kabam.rotmg.account.kongregate.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.RelayLoginTask;
import kabam.rotmg.account.kongregate.signals.KongregateAlreadyRegisteredSignal;
import kabam.rotmg.account.kongregate.view.KongregateApi;
import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.appengine.api.AppEngineClient;

public class KongregateRelayAPILoginTask extends BaseTask implements RelayLoginTask {

    public static const ALREADY_REGISTERED:String = "Kongregate account already registered";

    [Inject]
    public var account:Account;
    [Inject]
    public var api:KongregateApi;
    [Inject]
    public var data:AccountData;
    [Inject]
    public var alreadyRegistered:KongregateAlreadyRegisteredSignal;
    [Inject]
    public var client:AppEngineClient;


    override protected function startTask():void {
        this.client.setMaxRetries(2);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/kongregate/internalRegister", this.makeDataPacket());
    }

    private function makeDataPacket():Object {
        var _local_1:Object = this.api.getAuthentication();
        _local_1.guid = this.account.getUserId();
        return (_local_1);
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        if (_arg_1) {
            this.onInternalRegisterDone(_arg_2);
        }
        else {
            if (_arg_2 == ALREADY_REGISTERED) {
                this.alreadyRegistered.dispatch(this.data);
            }
        }
        completeTask(_arg_1, _arg_2);
    }

    private function onInternalRegisterDone(_arg_1:String):void {
        var _local_2:XML = new XML(_arg_1);
        this.account.updateUser(_local_2.GUID, _local_2.Secret, "");
        this.account.setPlatformToken(_local_2.PlatformToken);
    }


}
}//package kabam.rotmg.account.kongregate.services
