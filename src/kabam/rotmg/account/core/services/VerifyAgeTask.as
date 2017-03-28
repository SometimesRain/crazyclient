package kabam.rotmg.account.core.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.model.PlayerModel;

public class VerifyAgeTask extends BaseTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var playerModel:PlayerModel;
    [Inject]
    public var client:AppEngineClient;


    override protected function startTask():void {
        if (this.account.isRegistered()) {
            this.sendVerifyToServer();
        }
        else {
            this.verifyUserAge();
        }
    }

    private function sendVerifyToServer():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/account/verifyage", this.makeDataPacket());
    }

    private function makeDataPacket():Object {
        var _local_1:Object = this.account.getCredentials();
        _local_1.isAgeVerified = 1;
        return (_local_1);
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        ((_arg_1) && (this.verifyUserAge()));
        completeTask(_arg_1, _arg_2);
    }

    private function verifyUserAge():void {
        this.playerModel.setIsAgeVerified(true);
        completeTask(true);
    }


}
}//package kabam.rotmg.account.core.services
