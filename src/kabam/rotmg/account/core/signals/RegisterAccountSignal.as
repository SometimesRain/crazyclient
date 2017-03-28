package kabam.rotmg.account.core.signals {
import kabam.rotmg.account.web.model.AccountData;

import org.osflash.signals.Signal;

public class RegisterAccountSignal extends Signal {

    public function RegisterAccountSignal() {
        super(AccountData);
    }

}
}//package kabam.rotmg.account.core.signals
