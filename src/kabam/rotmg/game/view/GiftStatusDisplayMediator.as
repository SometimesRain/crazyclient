package kabam.rotmg.game.view {
import com.company.assembleegameclient.game.GiftStatusModel;

import kabam.rotmg.game.signals.UpdateGiftStatusDisplaySignal;

public class GiftStatusDisplayMediator {

    [Inject]
    public var updateGiftStatusDisplay:UpdateGiftStatusDisplaySignal;
    [Inject]
    public var view:GiftStatusDisplay;
    [Inject]
    public var giftStatusModel:GiftStatusModel;


    public function initialize():void {
        this.updateGiftStatusDisplay.add(this.onGiftChestUpdate);
        if (this.giftStatusModel.hasGift) {
            this.view.drawAsOpen();
        }
        else {
            this.view.drawAsClosed();
        }
    }

    private function onGiftChestUpdate():void {
        if (this.giftStatusModel.hasGift) {
            this.view.drawAsOpen();
        }
        else {
            this.view.drawAsClosed();
        }
    }


}
}//package kabam.rotmg.game.view
