package kabam.rotmg.core.commands {
import com.company.assembleegameclient.appengine.SavedCharactersList;
import com.company.assembleegameclient.editor.Command;

import kabam.rotmg.core.model.PlayerModel;

public class UpdatePlayerModelCommand extends Command {

    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var data:XML;


    override public function execute():void {
        this.model.setCharacterList(new SavedCharactersList(this.data));
        this.model.isInvalidated = false;
    }


}
}//package kabam.rotmg.core.commands
