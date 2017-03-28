package kabam.rotmg.account.kongregate.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.RegisterAccountTask;
import kabam.rotmg.account.kongregate.view.KongregateApi;
import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.appengine.api.AppEngineClient;

public class KongregateRegisterAccountTask extends BaseTask implements RegisterAccountTask {

    [Inject]
    public var data:AccountData;
    [Inject]
    public var api:KongregateApi;
    [Inject]
    public var account:Account;
    [Inject]
    public var client:AppEngineClient;


    override protected function startTask():void {
        this.client.setMaxRetries(2);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/kongregate/register", this.makeDataPacket());
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        ((_arg_1) && (this.onInternalRegisterDone(_arg_2)));
        completeTask(_arg_1, _arg_2);
    }

    private function makeDataPacket():Object {
        var _local_1:Object = this.api.getAuthentication();
        _local_1.newGUID = this.data.username;
        _local_1.newPassword = this.data.password;
        _local_1.entrytag = this.account.getEntryTag();
        return (_local_1);
    }

    private function onInternalRegisterDone(_arg_1:String):void {
        this.updateAccount(_arg_1);
    }

    private function updateAccount(_arg_1:String):void {
        var _local_2:XML = new XML(_arg_1);
        this.account.updateUser(_local_2.GUID, _local_2.Secret, "");
        this.account.setPlatformToken(_local_2.PlatformToken);
    }


}
}//package kabam.rotmg.account.kongregate.services
