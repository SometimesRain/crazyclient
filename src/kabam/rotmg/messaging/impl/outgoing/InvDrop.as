package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.SlotObjectData;

public class InvDrop extends OutgoingMessage {

    public var slotObject_:SlotObjectData;

    public function InvDrop(_arg_1:uint, _arg_2:Function) {
        this.slotObject_ = new SlotObjectData();
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        this.slotObject_.writeToOutput(_arg_1);
    }

    override public function toString():String {
        return (formatToString("INVDROP", "slotObject_"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
