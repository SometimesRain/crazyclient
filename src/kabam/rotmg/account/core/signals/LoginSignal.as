package kabam.rotmg.account.core.signals {
import kabam.rotmg.account.web.model.AccountData;

import org.osflash.signals.Signal;

public class LoginSignal extends Signal {

    public function LoginSignal() {
        super(AccountData);
    }

}
}//package kabam.rotmg.account.core.signals
