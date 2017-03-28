package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class AcceptTrade extends OutgoingMessage {

    public var myOffer_:Vector.<Boolean>;
    public var yourOffer_:Vector.<Boolean>;

    public function AcceptTrade(_arg_1:uint, _arg_2:Function) {
        this.myOffer_ = new Vector.<Boolean>();
        this.yourOffer_ = new Vector.<Boolean>();
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        var _local_2:int;
        _arg_1.writeShort(this.myOffer_.length);
        _local_2 = 0;
        while (_local_2 < this.myOffer_.length) {
            _arg_1.writeBoolean(this.myOffer_[_local_2]);
            _local_2++;
        }
        _arg_1.writeShort(this.yourOffer_.length);
        _local_2 = 0;
        while (_local_2 < this.yourOffer_.length) {
            _arg_1.writeBoolean(this.yourOffer_[_local_2]);
            _local_2++;
        }
    }

    override public function toString():String {
        return (formatToString("ACCEPTTRADE", "myOffer_", "yourOffer_"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
