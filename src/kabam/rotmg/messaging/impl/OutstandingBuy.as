package kabam.rotmg.messaging.impl {

public class OutstandingBuy {

    private var id_:String;
    private var price_:int;
    private var currency_:int;
    private var converted_:Boolean;

    public function OutstandingBuy(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Boolean) {
        this.id_ = _arg_1;
        this.price_ = _arg_2;
        this.currency_ = _arg_3;
        this.converted_ = _arg_4;
    }


}
}//package kabam.rotmg.messaging.impl
