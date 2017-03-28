package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataOutput;

import kabam.lib.net.impl.Message;

public class IncomingMessage extends Message {

    public function IncomingMessage(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    final override public function writeToOutput(_arg_1:IDataOutput):void {
        throw (new Error((("Client should not send " + id) + " messages")));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
