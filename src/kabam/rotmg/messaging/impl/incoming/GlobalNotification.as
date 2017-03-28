package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class GlobalNotification extends IncomingMessage {

    public var type:int;
    public var text:String;

    public function GlobalNotification(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.type = _arg_1.readInt();
        this.text = _arg_1.readUTF();
    }

    override public function toString():String {
        return (formatToString("GLOBAL_NOTIFICATION", "type", "text"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
