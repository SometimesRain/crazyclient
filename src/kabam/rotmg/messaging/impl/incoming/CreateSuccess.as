package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class CreateSuccess extends IncomingMessage {

    public var objectId_:int;
    public var charId_:int;

    public function CreateSuccess(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.objectId_ = _arg_1.readInt();
        this.charId_ = _arg_1.readInt();
    }

    override public function toString():String {
        return (formatToString("CREATE_SUCCESS", "objectId_", "charId_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
