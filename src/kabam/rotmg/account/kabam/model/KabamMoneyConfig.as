package kabam.rotmg.account.kabam.model {
import com.company.assembleegameclient.util.offer.Offer;

import kabam.rotmg.account.core.model.MoneyConfig;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class KabamMoneyConfig implements MoneyConfig {


    public function showPaymentMethods():Boolean {
        return (true);
    }

    public function showBonuses():Boolean {
        return (false);
    }

    public function parseOfferPrice(_arg_1:Offer):StringBuilder {
        return (new LineBuilder());
    }

    public function jsInitializeFunction():String {
        return ("rotmg.KabamPayment.setupKabamAccount");
    }


}
}//package kabam.rotmg.account.kabam.model
