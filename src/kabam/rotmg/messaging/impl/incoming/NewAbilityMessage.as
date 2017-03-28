package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

import kabam.lib.net.impl.Message;

public class NewAbilityMessage extends Message {

    public var type:int;

    public function NewAbilityMessage(_arg_1:uint, _arg_2:Function = null) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.type = _arg_1.readInt();
    }


}
}//package kabam.rotmg.messaging.impl.incoming
