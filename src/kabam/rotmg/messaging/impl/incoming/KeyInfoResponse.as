package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class KeyInfoResponse extends IncomingMessage {

    public var name:String;
    public var description:String;
    public var creator:String;

    public function KeyInfoResponse(_arg_1:uint, _arg_2:Function)
    {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void
    {
        this.name = _arg_1.readUTF();
        this.description = _arg_1.readUTF();
        this.creator = _arg_1.readUTF();
    }

    override public function toString():String
    {
        return formatToString("KEYINFORESPONSE", "name", "description", "creator");
    }

}
}
