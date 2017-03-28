package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class PlaySound extends IncomingMessage {

    public var ownerId_:int;
    public var soundId_:int;

    public function PlaySound(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.ownerId_ = _arg_1.readInt();
        this.soundId_ = _arg_1.readUnsignedByte();
    }

    override public function toString():String {
        return (formatToString("PLAYSOUND", "ownerId_", "soundId_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
