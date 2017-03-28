package kabam.rotmg.account.kongregate.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.LoginTask;
import kabam.rotmg.account.kongregate.view.KongregateApi;
import kabam.rotmg.appengine.api.AppEngineClient;

public class KongregateLoginTask extends BaseTask implements LoginTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var api:KongregateApi;
    [Inject]
    public var local:KongregateSharedObject;
    [Inject]
    public var client:AppEngineClient;


    override protected function startTask():void {
        this.client.setMaxRetries(2);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/kongregate/getcredentials", this.api.getAuthentication());
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        ((_arg_1) && (this.onGetCredentialsDone(_arg_2)));
        completeTask(_arg_1, _arg_2);
    }

    private function onGetCredentialsDone(_arg_1:String):void {
        var _local_2:XML = new XML(_arg_1);
        this.account.updateUser(_local_2.GUID, _local_2.Secret, "");
        this.account.setPlatformToken(_local_2.PlatformToken);
        completeTask(true);
    }


}
}//package kabam.rotmg.account.kongregate.services
