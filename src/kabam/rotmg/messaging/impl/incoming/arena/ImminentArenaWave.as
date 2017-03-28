package kabam.rotmg.messaging.impl.incoming.arena {
import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.incoming.IncomingMessage;

public class ImminentArenaWave extends IncomingMessage {

    public var currentRuntime:int;

    public function ImminentArenaWave(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.currentRuntime = _arg_1.readInt();
    }

    override public function toString():String {
        return (formatToString("IMMINENTARENAWAVE", "currentRuntime"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming.arena
