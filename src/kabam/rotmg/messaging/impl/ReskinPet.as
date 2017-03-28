package kabam.rotmg.messaging.impl {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;

public class ReskinPet extends OutgoingMessage {

    public var petInstanceId:int;
    public var pickedNewPetType:int;
    public var item:SlotObjectData;

    public function ReskinPet(_arg_1:uint, _arg_2:Function) {
        this.item = new SlotObjectData();
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeInt(this.petInstanceId);
        _arg_1.writeInt(this.pickedNewPetType);
        this.item.writeToOutput(_arg_1);
    }

    override public function toString():String {
        return (formatToString("ENTER_ARENA", "petInstanceId", "pickedNewPetType"));
    }


}
}//package kabam.rotmg.messaging.impl
