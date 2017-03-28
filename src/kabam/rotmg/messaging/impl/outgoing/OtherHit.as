package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class OtherHit extends OutgoingMessage {

    public var time_:int;
    public var bulletId_:uint;
    public var objectId_:int;
    public var targetId_:int;

    public function OtherHit(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeInt(this.time_);
        _arg_1.writeByte(this.bulletId_);
        _arg_1.writeInt(this.objectId_);
        _arg_1.writeInt(this.targetId_);
    }

    override public function toString():String {
        return (formatToString("OTHERHIT", "time_", "bulletId_", "objectId_", "targetId_"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
