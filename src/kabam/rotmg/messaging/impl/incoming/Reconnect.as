package kabam.rotmg.messaging.impl.incoming {
import flash.utils.ByteArray;
import flash.utils.IDataInput;

public class Reconnect extends IncomingMessage {

    public var name_:String;
    public var host_:String;
    public var port_:int;
    public var gameId_:int;
    public var keyTime_:int;
    public var key_:ByteArray;
    public var isFromArena_:Boolean;

    public function Reconnect(_arg_1:uint, _arg_2:Function) {
        this.key_ = new ByteArray();
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.name_ = _arg_1.readUTF();
        this.host_ = _arg_1.readUTF();
        this.port_ = _arg_1.readInt();
        this.gameId_ = _arg_1.readInt();
        this.keyTime_ = _arg_1.readInt();
        this.isFromArena_ = _arg_1.readBoolean();
        var _local_2:int = _arg_1.readShort();
        this.key_.length = 0;
        _arg_1.readBytes(this.key_, 0, _local_2);
    }

    override public function toString():String {
        return (formatToString("RECONNECT", "name_", "host_", "port_", "gameId_", "keyTime_", "key_", "isFromArena_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
