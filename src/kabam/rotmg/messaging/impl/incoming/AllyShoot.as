package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class AllyShoot extends IncomingMessage {

    public var bulletId_:uint;
    public var ownerId_:int;
    public var containerType_:int;
    public var angle_:Number;

    public function AllyShoot(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.bulletId_ = _arg_1.readUnsignedByte();
        this.ownerId_ = _arg_1.readInt();
        this.containerType_ = _arg_1.readShort();
        this.angle_ = _arg_1.readFloat();
    }

    override public function toString():String {
        return (formatToString("ALLYSHOOT", "bulletId_", "ownerId_", "containerType_", "angle_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
