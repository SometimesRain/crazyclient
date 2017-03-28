package kabam.rotmg.messaging.impl.outgoing.arena {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;

public class QuestRedeem extends OutgoingMessage {

    public var slotObject:SlotObjectData;

    public function QuestRedeem(_arg_1:uint, _arg_2:Function) {
        this.slotObject = new SlotObjectData();
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        this.slotObject.writeToOutput(_arg_1);
    }


}
}//package kabam.rotmg.messaging.impl.outgoing.arena
