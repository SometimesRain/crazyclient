package kabam.rotmg.account.core.model {
import com.company.assembleegameclient.util.offer.Offer;

import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public interface MoneyConfig {

    function showPaymentMethods():Boolean;

    function showBonuses():Boolean;

    function parseOfferPrice(_arg_1:Offer):StringBuilder;

    function jsInitializeFunction():String;

}
}//package kabam.rotmg.account.core.model
