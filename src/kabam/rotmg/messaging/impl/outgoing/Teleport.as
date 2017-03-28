package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class Teleport extends OutgoingMessage {

    public var objectId_:int;

    public function Teleport(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeInt(this.objectId_);
    }

    override public function toString():String {
        return (formatToString("TELEPORT", "objectId_"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
