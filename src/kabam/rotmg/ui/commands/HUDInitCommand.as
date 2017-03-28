package kabam.rotmg.ui.commands {
import com.company.assembleegameclient.editor.Command;
import com.company.assembleegameclient.game.GameSprite;

import kabam.rotmg.ui.model.HUDModel;
import kabam.rotmg.ui.signals.HUDModelInitialized;

public class HUDInitCommand extends Command {

    [Inject]
    public var gameSprite:GameSprite;
    [Inject]
    public var model:HUDModel;
    [Inject]
    public var hudModelInitialized:HUDModelInitialized;


    override public function execute():void {
        this.model.gameSprite = this.gameSprite;
        this.hudModelInitialized.dispatch();
    }


}
}//package kabam.rotmg.ui.commands
