package kabam.rotmg.messaging.impl.incoming.arena {
import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.incoming.IncomingMessage;

public class ArenaDeath extends IncomingMessage {

    public var cost:int;

    public function ArenaDeath(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.cost = _arg_1.readInt();
    }

    override public function toString():String {
        return (formatToString("ARENADEATH", "cost"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming.arena
