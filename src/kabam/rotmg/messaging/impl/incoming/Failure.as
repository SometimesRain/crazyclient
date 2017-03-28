package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class Failure extends IncomingMessage {

    public static const INCORRECT_VERSION:int = 4;
    public static const BAD_KEY:int = 5;
    public static const INVALID_TELEPORT_TARGET:int = 6;
    public static const EMAIL_VERIFICATION_NEEDED:int = 7;

    public var errorId_:int;
    public var errorDescription_:String;

    public function Failure(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.errorId_ = _arg_1.readInt();
        this.errorDescription_ = _arg_1.readUTF();
    }

    override public function toString():String {
        return (formatToString("FAILURE", "errorId_", "errorDescription_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
