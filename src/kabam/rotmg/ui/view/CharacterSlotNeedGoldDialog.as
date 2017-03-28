package kabam.rotmg.ui.view {
import com.company.assembleegameclient.ui.dialogs.Dialog;

import flash.display.Sprite;
import flash.events.Event;

import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class CharacterSlotNeedGoldDialog extends Sprite {

    public const buyGold:Signal = new Signal();
    public const cancel:Signal = new Signal();

    private var dialog:Dialog;
    private var price:int;


    public function setPrice(_arg_1:int):void {
        this.price = _arg_1;
        ((((this.dialog) && (contains(this.dialog)))) && (removeChild(this.dialog)));
        this.makeDialog();
        this.dialog.addEventListener(Dialog.LEFT_BUTTON, this.onCancel);
        this.dialog.addEventListener(Dialog.RIGHT_BUTTON, this.onBuyGold);
    }

    private function makeDialog():void {
        this.dialog = new Dialog(TextKey.NOT_ENOUGH_GOLD, "", TextKey.FRAME_CANCEL, TextKey.BUY_GOLD);
        this.dialog.setTextParams(TextKey.CHARACTERSLOTNEEDGOLDDIALOG_PRICE, {"price": this.price});
        addChild(this.dialog);
    }

    public function onCancel(_arg_1:Event):void {
        this.cancel.dispatch();
    }

    public function onBuyGold(_arg_1:Event):void {
        this.buyGold.dispatch();
    }


}
}//package kabam.rotmg.ui.view
