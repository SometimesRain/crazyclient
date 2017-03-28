package kabam.rotmg.messaging.impl.incoming.pets {
import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.incoming.IncomingMessage;

public class DeletePetMessage extends IncomingMessage {

    public var petID:int;

    public function DeletePetMessage(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.petID = _arg_1.readInt();
    }


}
}//package kabam.rotmg.messaging.impl.incoming.pets
