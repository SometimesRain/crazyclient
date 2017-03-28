package kabam.rotmg.messaging.impl.incoming.pets {
import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.incoming.IncomingMessage;

public class HatchPetMessage extends IncomingMessage {

    public var petName:String;
    public var petSkin:int;

    public function HatchPetMessage(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.petName = _arg_1.readUTF();
        this.petSkin = _arg_1.readInt();
    }


}
}//package kabam.rotmg.messaging.impl.incoming.pets
