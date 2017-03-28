package kabam.rotmg.characters.deletion.service {
import com.company.assembleegameclient.appengine.SavedCharacter;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.characters.model.CharacterModel;

public class DeleteCharacterTask extends BaseTask {

    [Inject]
    public var character:SavedCharacter;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var account:Account;
    [Inject]
    public var model:CharacterModel;


    override protected function startTask():void {
        this.client.setMaxRetries(2);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/char/delete", this.getRequestPacket());
    }

    private function getRequestPacket():Object {
        var _local_1:Object = this.account.getCredentials();
        _local_1.charId = this.character.charId();
        _local_1.reason = 1;
        return (_local_1);
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        ((_arg_1) && (this.updateUserData()));
        completeTask(_arg_1, _arg_2);
    }

    private function updateUserData():void {
        this.model.deleteCharacter(this.character.charId());
    }


}
}//package kabam.rotmg.characters.deletion.service
