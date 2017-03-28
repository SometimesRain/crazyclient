package kabam.rotmg.ui.view {
import com.company.assembleegameclient.ui.dialogs.Dialog;

import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class ChooseNameRegisterDialog extends Dialog {

    public var cancel:Signal;
    public var register:Signal;

    public function ChooseNameRegisterDialog() {
        super(TextKey.REGISTER_PROMPT_NOT_REGISTERED, TextKey.CHOOSENAMEREGISTERDIALOG_TEXT, TextKey.REGISTER_PROMPT_CANCEL, TextKey.REGISTER_PROMPT_REGISTER);
        this.cancel = new NativeMappedSignal(this, LEFT_BUTTON);
        this.register = new NativeMappedSignal(this, RIGHT_BUTTON);
    }

}
}//package kabam.rotmg.ui.view
