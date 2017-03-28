package kabam.rotmg.account.steam.view {
import com.company.assembleegameclient.ui.dialogs.DebugDialog;
import com.company.assembleegameclient.ui.dialogs.Dialog;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class SteamSessionRequestErrorDialog extends DebugDialog {

    public var ok:Signal;

    public function SteamSessionRequestErrorDialog() {
        super("Failed to retrieve valid Steam Credentials! Click to retry.");
        this.ok = new NativeMappedSignal(this, Dialog.LEFT_BUTTON);
    }

}
}//package kabam.rotmg.account.steam.view
