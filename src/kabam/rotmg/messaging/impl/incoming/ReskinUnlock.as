package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class ReskinUnlock extends IncomingMessage {

    public var skinID:int;

    public function ReskinUnlock(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.skinID = _arg_1.readInt();
    }

    override public function toString():String {
        return (formatToString("RESKIN", "skinID"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
