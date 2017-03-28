package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class EnemyShoot extends IncomingMessage {

    public var bulletId_:uint;
    public var ownerId_:int;
    public var bulletType_:int;
    public var startingPos_:WorldPosData;
    public var angle_:Number;
    public var damage_:int;
    public var numShots_:int;
    public var angleInc_:Number;

    public function EnemyShoot(_arg_1:uint, _arg_2:Function) {
        this.startingPos_ = new WorldPosData();
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.bulletId_ = _arg_1.readUnsignedByte();
        this.ownerId_ = _arg_1.readInt();
        this.bulletType_ = _arg_1.readUnsignedByte();
        this.startingPos_.parseFromInput(_arg_1);
        this.angle_ = _arg_1.readFloat();
        this.damage_ = _arg_1.readShort();
        if (_arg_1.bytesAvailable > 0) {
            this.numShots_ = _arg_1.readUnsignedByte();
            this.angleInc_ = _arg_1.readFloat();
        }
        else {
            this.numShots_ = 1;
            this.angleInc_ = 0;
        }
    }

    override public function toString():String {
        return (formatToString("SHOOT", "bulletId_", "ownerId_", "bulletType_", "startingPos_", "angle_", "damage_", "numShots_", "angleInc_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
