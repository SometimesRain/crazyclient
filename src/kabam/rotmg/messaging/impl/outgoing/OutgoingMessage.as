package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataInput;
import kabam.lib.net.api.MessageProvider;
import kabam.lib.net.impl.SocketServer;

import kabam.lib.net.impl.Message;

public class OutgoingMessage extends Message {
	
    /*[Inject]
    public var messages:MessageProvider;
    [Inject]
    public var serverConnection:SocketServer;*/

    public function OutgoingMessage(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    final override public function parseFromInput(_arg_1:IDataInput):void {
		//serverConnection.sendMessage(messages.require(id)); //I wonder if I could create some sort of bounceback here
        throw (new Error("Client should not receive " + id + " messages"));
    }
	
	
}
}//package kabam.rotmg.messaging.impl.outgoing
