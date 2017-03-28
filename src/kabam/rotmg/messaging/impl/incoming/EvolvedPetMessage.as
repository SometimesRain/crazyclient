package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class EvolvedPetMessage extends IncomingMessage {

    public var petID:int;
    public var initialSkin:int;
    public var finalSkin:int;

    public function EvolvedPetMessage(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.petID = _arg_1.readInt();
        this.initialSkin = _arg_1.readInt();
        this.finalSkin = _arg_1.readInt();
    }


}
}//package kabam.rotmg.messaging.impl.incoming
