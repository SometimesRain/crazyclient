package com.company.assembleegameclient.util {
import com.company.assembleegameclient.util.offer.Offer;

import flash.net.URLVariables;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.model.TextKey;

public class PaymentMethod {

    public static const GO_METHOD:PaymentMethod = new PaymentMethod(TextKey.PAYMENTS_GOOGLE_CHECKOUT, "co", "");
    public static const PAYPAL_METHOD:PaymentMethod = new PaymentMethod(TextKey.PAYMENTS_PAYPAL, "ps", "P3");
    public static const CREDITS_METHOD:PaymentMethod = new PaymentMethod(TextKey.PAYMENTS_CREDIT_CARDS, "ps", "CH");
    public static const PAYMENT_METHODS:Vector.<PaymentMethod> = new <PaymentMethod>[GO_METHOD, PAYPAL_METHOD, CREDITS_METHOD];

    public var label_:String;
    public var provider_:String;
    public var paymentid_:String;

    public function PaymentMethod(_arg_1:String, _arg_2:String, _arg_3:String) {
        this.label_ = _arg_1;
        this.provider_ = _arg_2;
        this.paymentid_ = _arg_3;
    }

    public static function getPaymentMethodByLabel(_arg_1:String):PaymentMethod {
        var _local_2:PaymentMethod;
        for each (_local_2 in PAYMENT_METHODS) {
            if (_local_2.label_ == _arg_1) {
                return (_local_2);
            }
        }
        return (null);
    }


    public function getURL(_arg_1:String, _arg_2:String, _arg_3:Offer):String {
        var _local_4:Account = StaticInjectorContext.getInjector().getInstance(Account);
        var _local_5:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
        var _local_6:URLVariables = new URLVariables();
        _local_6["tok"] = _arg_1;
        _local_6["exp"] = _arg_2;
        _local_6["guid"] = _local_4.getUserId();
        _local_6["provider"] = this.provider_;
        switch (this.provider_) {
            case "co":
                _local_6["jwt"] = _arg_3.jwt_;
                break;
            case "ps":
                _local_6["jwt"] = _arg_3.jwt_;
                _local_6["price"] = _arg_3.price_.toString();
                _local_6["paymentid"] = this.paymentid_;
                break;
        }
        return (((_local_5.getAppEngineUrl(true) + "/credits/add?") + _local_6.toString()));
    }


}
}//package com.company.assembleegameclient.util
