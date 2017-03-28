package com.company.assembleegameclient.util.offer {
public class Offer {

    public var id_:String;
    public var price_:Number;
    public var realmGold_:int;
    public var jwt_:String;
    public var data_:String;
    public var currency_:String;
    public var tagline:String;
    public var bonus:int;

    public function Offer(_arg_1:String, _arg_2:Number, _arg_3:int, _arg_4:String, _arg_5:String, _arg_6:String = null):void {
        this.id_ = _arg_1;
        this.price_ = _arg_2;
        this.realmGold_ = _arg_3;
        this.jwt_ = _arg_4;
        this.data_ = _arg_5;
        this.currency_ = (((_arg_6) != null) ? _arg_6 : "USD");
    }

}
}//package com.company.assembleegameclient.util.offer
