package kabam.rotmg.game.commands {
import kabam.rotmg.game.model.TextPanelData;

import robotlegs.bender.bundles.mvcs.Command;

public class TextPanelMessageUpdateCommand extends Command {

    [Inject]
    public var model:TextPanelData;
    [Inject]
    public var message:String;


    override public function execute():void {
        this.model.message = this.message;
    }


}
}//package kabam.rotmg.game.commands
