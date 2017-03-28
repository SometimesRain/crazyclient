package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class AccountList extends IncomingMessage {

    public var accountListId_:int;
    public var accountIds_:Vector.<String>;
    public var lockAction_:int = -1;

    public function AccountList(_arg_1:uint, _arg_2:Function) {
        this.accountIds_ = new Vector.<String>();
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        var _local_2:int;
        this.accountListId_ = _arg_1.readInt();
        this.accountIds_.length = 0;
        var _local_3:int = _arg_1.readShort();
        _local_2 = 0;
        while (_local_2 < _local_3) {
            this.accountIds_.push(_arg_1.readUTF());
            _local_2++;
        }
        this.lockAction_ = _arg_1.readInt();
    }

    override public function toString():String {
        return (formatToString("ACCOUNTLIST", "accountListId_", "accountIds_", "lockAction_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
