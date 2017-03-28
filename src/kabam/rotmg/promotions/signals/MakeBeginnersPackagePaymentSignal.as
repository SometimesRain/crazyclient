package kabam.rotmg.promotions.signals {
import kabam.rotmg.account.core.PaymentData;

import org.osflash.signals.Signal;

public class MakeBeginnersPackagePaymentSignal extends Signal {

    public function MakeBeginnersPackagePaymentSignal() {
        super(PaymentData);
    }

}
}//package kabam.rotmg.promotions.signals
