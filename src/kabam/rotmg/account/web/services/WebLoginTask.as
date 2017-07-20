package kabam.rotmg.account.web.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.LoginTask;
import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.appengine.api.AppEngineClient;

public class WebLoginTask extends BaseTask implements LoginTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var data:AccountData;
    [Inject]
    public var client:AppEngineClient;


    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/account/verify", {
            "guid": this.data.username,
            "password": this.data.password
        });
    }

    private function onComplete(_arg_1:Boolean, _arg_2:String):void {
        if (_arg_1) {
            this.updateUser(_arg_2);
        }
        completeTask(_arg_1, _arg_2);
    }

    private function updateUser(_arg_1:String):void { //necessary at all?
		this.account.updateUser(this.data.username,this.data.password,"");
    }

}
}//package kabam.rotmg.account.web.services
