package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class CheckCredits extends OutgoingMessage {

    public function CheckCredits(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
    }

    override public function toString():String {
        return (formatToString("CHECKCREDITS"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
