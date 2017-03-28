package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class Ping extends IncomingMessage {

    public var serial_:int;

    public function Ping(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.serial_ = _arg_1.readInt();
    }

    override public function toString():String {
        return (formatToString("PING", "serial_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
