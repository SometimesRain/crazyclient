package kabam.rotmg.account.core.signals {
import com.company.assembleegameclient.util.offer.Offer;

import org.osflash.signals.Signal;

public class PurchaseGoldSignal extends Signal {

    public function PurchaseGoldSignal() {
        super(Offer, String);
    }

}
}//package kabam.rotmg.account.core.signals
