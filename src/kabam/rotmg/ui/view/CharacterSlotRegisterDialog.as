package kabam.rotmg.ui.view {
import com.company.assembleegameclient.ui.dialogs.Dialog;

import flash.display.Sprite;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class CharacterSlotRegisterDialog extends Sprite {

    private static const TEXT:String = "In order to have more than one character slot, you must be a registered user.";
    private static const TITLE:String = "Not Registered";
    private static const CANCEL:String = "Cancel";
    private static const REGISTER:String = "Register";

    public var cancel:Signal;
    public var register:Signal;
    private var dialog:Dialog;

    public function CharacterSlotRegisterDialog() {
        this.makeDialog();
        this.makeSignals();
    }

    private function makeDialog():void {
        this.dialog = new Dialog(TITLE, TEXT, CANCEL, REGISTER);
        addChild(this.dialog);
    }

    private function makeSignals():void {
        this.cancel = new NativeMappedSignal(this.dialog, Dialog.LEFT_BUTTON);
        this.register = new NativeMappedSignal(this.dialog, Dialog.RIGHT_BUTTON);
    }


}
}//package kabam.rotmg.ui.view
