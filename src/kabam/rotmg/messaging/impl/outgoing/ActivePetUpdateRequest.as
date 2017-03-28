package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class ActivePetUpdateRequest extends OutgoingMessage {

    public var commandtype:uint;
    public var instanceid:uint;

    public function ActivePetUpdateRequest(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeByte(this.commandtype);
        _arg_1.writeInt(this.instanceid);
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
