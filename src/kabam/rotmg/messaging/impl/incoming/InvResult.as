package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class InvResult extends IncomingMessage {

    public var result_:int;

    public function InvResult(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.result_ = _arg_1.readInt();
    }

    override public function toString():String {
        return (formatToString("INVRESULT", "result_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
