package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class Buy extends OutgoingMessage {

    public var objectId_:int;
    public var quantity_:int;

    public function Buy(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeInt(this.objectId_);
        _arg_1.writeInt(this.quantity_);
    }

    override public function toString():String {
        return (formatToString("BUY", "objectId_", "quantity_"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
