package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class TradeRequested extends IncomingMessage {

    public var name_:String;

    public function TradeRequested(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.name_ = _arg_1.readUTF();
    }

    override public function toString():String {
        return (formatToString("TRADEREQUESTED", "name_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
