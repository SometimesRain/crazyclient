package kabam.rotmg.account.core.signals {
import kabam.rotmg.account.web.model.AccountData;

import org.osflash.signals.Signal;

public class RegisterSignal extends Signal {

    public function RegisterSignal() {
        super(AccountData);
    }

}
}//package kabam.rotmg.account.core.signals
