package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class Notification extends IncomingMessage {

    public var objectId_:int;
    public var message:String;
    public var color_:int;

    public function Notification(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.objectId_ = _arg_1.readInt();
        this.message = _arg_1.readUTF();
        this.color_ = _arg_1.readInt();
    }

    override public function toString():String {
        return (formatToString("NOTIFICATION", "objectId_", "message", "color_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
