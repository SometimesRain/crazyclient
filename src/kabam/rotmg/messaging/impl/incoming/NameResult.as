package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class NameResult extends IncomingMessage {

    public var success_:Boolean;
    public var errorText_:String;

    public function NameResult(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.success_ = _arg_1.readBoolean();
        this.errorText_ = _arg_1.readUTF();
    }

    override public function toString():String {
        return (formatToString("NAMERESULT", "success_", "errorText_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
