package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class BuyResult extends IncomingMessage {

    public static const UNKNOWN_ERROR_BRID:int = -1;
    public static const SUCCESS_BRID:int = 0;
    public static const INVALID_CHARACTER_BRID:int = 1;
    public static const ITEM_NOT_FOUND_BRID:int = 2;
    public static const NOT_ENOUGH_GOLD_BRID:int = 3;
    public static const INVENTORY_FULL_BRID:int = 4;
    public static const TOO_LOW_RANK_BRID:int = 5;
    public static const NOT_ENOUGH_FAME_BRID:int = 6;
    public static const PET_FEED_SUCCESS_BRID:int = 7;

    public var result_:int;
    public var resultString_:String;

    public function BuyResult(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.result_ = _arg_1.readInt();
        this.resultString_ = _arg_1.readUTF();
    }

    override public function toString():String {
        return (formatToString("BUYRESULT", "result_", "resultString_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
