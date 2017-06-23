package kabam.rotmg.messaging.impl.incoming.thunderboxer {
import flash.utils.IDataInput;
import kabam.rotmg.messaging.impl.incoming.IncomingMessage;

public class SetSpeed extends IncomingMessage {

    public var spd:int;

    public function SetSpeed(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.spd = _arg_1.readInt();
    }

    override public function toString():String {
        return (formatToString("SETSPEED", "spd"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
