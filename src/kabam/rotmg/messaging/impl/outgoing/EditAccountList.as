package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class EditAccountList extends OutgoingMessage {

    public var accountListId_:int;
    public var add_:Boolean;
    public var objectId_:int;

    public function EditAccountList(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeInt(this.accountListId_);
        _arg_1.writeBoolean(this.add_);
        _arg_1.writeInt(this.objectId_);
    }

    override public function toString():String {
        return (formatToString("EDITACCOUNTLIST", "accountListId_", "add_", "objectId_"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
