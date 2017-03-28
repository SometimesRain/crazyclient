package kabam.rotmg.account.kabam.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.LoadAccountTask;
import kabam.rotmg.account.kabam.KabamAccount;
import kabam.rotmg.account.kabam.model.KabamParameters;
import kabam.rotmg.account.kabam.view.AccountLoadErrorDialog;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class KabamLoadAccountTask extends BaseTask implements LoadAccountTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var parameters:KabamParameters;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var client:AppEngineClient;
    private var kabam:KabamAccount;


    override protected function startTask():void {
        this.kabam = (this.account as KabamAccount);
        this.kabam.signedRequest = this.parameters.getSignedRequest();
        this.kabam.userSession = this.parameters.getUserSession();
        if (this.kabam.userSession == null) {
            this.openDialog.dispatch(new AccountLoadErrorDialog());
            completeTask(false);
        }
        else {
            this.sendRequest();
        }
    }

    private function sendRequest():void {
        var _local_1:Object = {
            "signedRequest": this.kabam.signedRequest,
            "entrytag": this.account.getEntryTag()
        };
        this.client.setMaxRetries(2);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/kabam/getcredentials", _local_1);
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        ((_arg_1) && (this.onGetCredentialsDone(_arg_2)));
        completeTask(_arg_1, _arg_2);
    }

    private function onGetCredentialsDone(_arg_1:String):void {
        var _local_2:XML = new XML(_arg_1);
        this.account.updateUser(_local_2.GUID, _local_2.Secret, "");
        this.account.setPlatformToken(_local_2.PlatformToken);
    }


}
}//package kabam.rotmg.account.kabam.services
