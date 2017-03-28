package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class ServerPlayerShoot extends IncomingMessage {

    public var bulletId_:uint;
    public var ownerId_:int;
    public var containerType_:int;
    public var startingPos_:WorldPosData;
    public var angle_:Number;
    public var damage_:int;

    public function ServerPlayerShoot(_arg_1:uint, _arg_2:Function) {
        this.startingPos_ = new WorldPosData();
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.bulletId_ = _arg_1.readUnsignedByte();
        this.ownerId_ = _arg_1.readInt();
        this.containerType_ = _arg_1.readInt();
        this.startingPos_.parseFromInput(_arg_1);
        this.angle_ = _arg_1.readFloat();
        this.damage_ = _arg_1.readShort();
    }

    override public function toString():String {
        return (formatToString("SHOOT", "bulletId_", "ownerId_", "containerType_", "startingPos_", "angle_", "damage_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
