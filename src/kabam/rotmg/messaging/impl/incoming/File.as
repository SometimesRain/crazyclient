package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class File extends IncomingMessage {

    public var filename_:String;
    public var file_:String;

    public function File(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.filename_ = _arg_1.readUTF();
        var _local_2:int = _arg_1.readInt();
        this.file_ = _arg_1.readUTFBytes(_local_2);
    }

    override public function toString():String {
        return (formatToString("CLIENTSTAT", "filename_", "file_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
