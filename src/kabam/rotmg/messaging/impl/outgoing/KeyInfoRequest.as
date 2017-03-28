package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class KeyInfoRequest extends OutgoingMessage{

    public var itemType_:int;

    public function KeyInfoRequest(_arg_1:uint, _arg_2:Function)
    {
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void
    {
        _arg_1.writeInt(this.itemType_);
    }

    override public function toString():String
    {
        return formatToString("ITEMTYPE", "itemType_");
    }

}
}
