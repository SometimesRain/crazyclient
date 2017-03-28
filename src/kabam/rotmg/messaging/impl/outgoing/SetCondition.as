package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class SetCondition extends OutgoingMessage {

    public var conditionEffect_:uint;
    public var conditionDuration_:Number;

    public function SetCondition(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeByte(this.conditionEffect_);
        _arg_1.writeFloat(this.conditionDuration_);
    }

    override public function toString():String {
        return (formatToString("SETCONDITION", "conditionEffect_", "conditionDuration_"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
