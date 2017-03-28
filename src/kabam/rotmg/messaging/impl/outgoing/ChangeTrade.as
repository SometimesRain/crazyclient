package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class ChangeTrade extends OutgoingMessage {

    public var offer_:Vector.<Boolean>;

    public function ChangeTrade(_arg_1:uint, _arg_2:Function) {
        this.offer_ = new Vector.<Boolean>();
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeShort(this.offer_.length);
        var _local_2:int;
        while (_local_2 < this.offer_.length) {
            _arg_1.writeBoolean(this.offer_[_local_2]);
            _local_2++;
        }
    }

    override public function toString():String {
        return (formatToString("CHANGETRADE", "offer_"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
