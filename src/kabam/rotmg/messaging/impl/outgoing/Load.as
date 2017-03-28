package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class Load extends OutgoingMessage {

    public var charId_:int;
    public var isFromArena_:Boolean;

    public function Load(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeInt(this.charId_);
        _arg_1.writeBoolean(this.isFromArena_);
    }

    override public function toString():String {
        return (formatToString("LOAD", "charId_", "isFromArena_"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
