package kabam.rotmg.account.web.signals {
import kabam.rotmg.account.web.model.ChangePasswordData;

import org.osflash.signals.Signal;

public class WebChangePasswordSignal extends Signal {

    public function WebChangePasswordSignal() {
        super(ChangePasswordData);
    }

}
}//package kabam.rotmg.account.web.signals
