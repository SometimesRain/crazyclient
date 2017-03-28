package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class TradeChanged extends IncomingMessage {

    public var offer_:Vector.<Boolean>;

    public function TradeChanged(_arg_1:uint, _arg_2:Function) {
        this.offer_ = new Vector.<Boolean>();
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.offer_.length = 0;
        var _local_2:int = _arg_1.readShort();
        var _local_3:int;
        while (_local_3 < _local_2) {
            this.offer_.push(_arg_1.readBoolean());
            _local_3++;
        }
    }

    override public function toString():String {
        return (formatToString("TRADECHANGED", "offer_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
