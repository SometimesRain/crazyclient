package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class PlayerShoot extends OutgoingMessage {

    public var time_:int;
    public var bulletId_:uint;
    public var containerType_:int;
    public var startingPos_:WorldPosData;
    public var angle_:Number;

    public function PlayerShoot(_arg_1:uint, _arg_2:Function) {
        this.startingPos_ = new WorldPosData();
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeInt(this.time_);
        _arg_1.writeByte(this.bulletId_);
        _arg_1.writeShort(this.containerType_);
        this.startingPos_.writeToOutput(_arg_1);
        _arg_1.writeFloat(this.angle_);
    }

    override public function toString():String {
        return (formatToString("PLAYERSHOOT", "time_", "bulletId_", "containerType_", "startingPos_", "angle_"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
