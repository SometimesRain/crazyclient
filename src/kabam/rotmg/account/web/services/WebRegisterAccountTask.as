package kabam.rotmg.account.web.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.RegisterAccountTask;
import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.model.PlayerModel;

public class WebRegisterAccountTask extends BaseTask implements RegisterAccountTask {

    [Inject]
    public var data:AccountData;
    [Inject]
    public var account:Account;
    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var client:AppEngineClient;


    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/account/register", this.makeDataPacket());
    }

    private function makeDataPacket():Object {
        var _local_1:Object = {};
        _local_1.guid = this.account.getUserId();
        _local_1.newGUID = this.data.username;
        _local_1.newPassword = this.data.password;
        _local_1.entrytag = this.account.getEntryTag();
        _local_1.signedUpKabamEmail = this.data.signedUpKabamEmail;
        _local_1.isAgeVerified = 1;
        return (_local_1);
    }

    private function onComplete(_arg_1:Boolean, _arg_2:String):void {
        _arg_1 && this.onRegisterDone(_arg_2);
        completeTask(_arg_1, _arg_2);
    }

    private function onRegisterDone(_arg_1:String):void {
        this.model.setIsAgeVerified(true);
        var _local_2:XML = new XML(_arg_1);
        if(_local_2.hasOwnProperty("token"))
        {
            this.data.token = _local_2.token;
            this.account.updateUser(this.data.username, this.data.password, _local_2.token);
        }
        else
        {
            this.account.updateUser(this.data.username, this.data.password, "");
        }
    }


}
}//package kabam.rotmg.account.web.services
