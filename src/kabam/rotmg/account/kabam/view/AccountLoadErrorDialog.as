package kabam.rotmg.account.kabam.view {
import com.company.assembleegameclient.ui.dialogs.DebugDialog;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class AccountLoadErrorDialog extends DebugDialog {

    private static const MESSAGE:String = "Failed to retrieve valid Kabam request! Click to reload.";

    public var close:Signal;

    public function AccountLoadErrorDialog() {
        super(MESSAGE);
        this.close = new NativeMappedSignal(this, LEFT_BUTTON);
    }

}
}//package kabam.rotmg.account.kabam.view
