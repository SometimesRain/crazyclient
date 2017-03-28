package kabam.rotmg.account.kongregate.signals {
import kabam.rotmg.account.web.model.AccountData;

import org.osflash.signals.Signal;

public class KongregateAlreadyRegisteredSignal extends Signal {

    public function KongregateAlreadyRegisteredSignal() {
        super(AccountData);
    }

}
}//package kabam.rotmg.account.kongregate.signals
