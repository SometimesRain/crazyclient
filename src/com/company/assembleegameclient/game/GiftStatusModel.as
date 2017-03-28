package com.company.assembleegameclient.game {
import kabam.rotmg.game.signals.UpdateGiftStatusDisplaySignal;

public class GiftStatusModel {

    [Inject]
    public var updateGiftStatusDisplay:UpdateGiftStatusDisplaySignal;
    public var hasGift:Boolean;


    public function setHasGift(_arg_1:Boolean):void {
        this.hasGift = _arg_1;
        this.updateGiftStatusDisplay.dispatch();
    }


}
}//package com.company.assembleegameclient.game
