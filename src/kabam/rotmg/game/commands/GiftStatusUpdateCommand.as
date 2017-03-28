package kabam.rotmg.game.commands {
import com.company.assembleegameclient.game.GiftStatusModel;

import robotlegs.bender.bundles.mvcs.Command;

public class GiftStatusUpdateCommand extends Command {

    [Inject]
    public var model:GiftStatusModel;
    [Inject]
    public var hasGift:Boolean;


    override public function execute():void {
        this.model.setHasGift(this.hasGift);
    }


}
}//package kabam.rotmg.game.commands
