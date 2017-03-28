package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class EnemyHit extends OutgoingMessage {

    public var time_:int;
    public var bulletId_:uint;
    public var targetId_:int;
    public var kill_:Boolean;

    public function EnemyHit(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeInt(this.time_);
        _arg_1.writeByte(this.bulletId_);
        _arg_1.writeInt(this.targetId_);
        _arg_1.writeBoolean(this.kill_);
    }

    override public function toString():String {
        return (formatToString("ENEMYHIT", "time_", "bulletId_", "targetId_", "kill_"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
