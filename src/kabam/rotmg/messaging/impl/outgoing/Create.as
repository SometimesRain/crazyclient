package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class Create extends OutgoingMessage {

    public var classType:int;
    public var skinType:int;

    public function Create(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeShort(this.classType);
        _arg_1.writeShort(this.skinType);
    }

    override public function toString():String {
        return (formatToString("CREATE", "classType"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
