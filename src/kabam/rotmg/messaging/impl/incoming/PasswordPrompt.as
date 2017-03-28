package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class PasswordPrompt extends IncomingMessage {

    public var cleanPasswordStatus:int;

    public function PasswordPrompt(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.cleanPasswordStatus = _arg_1.readInt();
    }

    override public function toString():String {
        return (formatToString("PASSWORDPROMPT", "cleanPasswordStatus"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
