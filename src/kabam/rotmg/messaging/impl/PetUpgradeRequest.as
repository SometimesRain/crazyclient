package kabam.rotmg.messaging.impl {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;

public class PetUpgradeRequest extends OutgoingMessage {

    public static const GOLD_PAYMENT_TYPE:int = 0;
    public static const FAME_PAYMENT_TYPE:int = 1;

    public var petTransType:int;
    public var PIDOne:int;
    public var PIDTwo:int;
    public var objectId:int;
    public var slotObject:SlotObjectData;
    public var paymentTransType:int;

    public function PetUpgradeRequest(_arg_1:uint, _arg_2:Function) {
        this.slotObject = new SlotObjectData();
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeByte(this.petTransType);
        _arg_1.writeInt(this.PIDOne);
        _arg_1.writeInt(this.PIDTwo);
        _arg_1.writeInt(this.objectId);
        this.slotObject.writeToOutput(_arg_1);
        _arg_1.writeByte(this.paymentTransType);
    }


}
}//package kabam.rotmg.messaging.impl
