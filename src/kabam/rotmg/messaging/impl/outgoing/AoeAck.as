package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class AoeAck extends OutgoingMessage {

    public var time_:int;
    public var position_:WorldPosData;

    public function AoeAck(_arg_1:uint, _arg_2:Function) {
        this.position_ = new WorldPosData();
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeInt(this.time_);
        this.position_.writeToOutput(_arg_1);
    }

    override public function toString():String {
        return (formatToString("AOEACK", "time_", "position_"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
