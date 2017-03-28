package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class GuildResult extends IncomingMessage {

    public var success_:Boolean;
    public var lineBuilderJSON:String;

    public function GuildResult(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.success_ = _arg_1.readBoolean();
        this.lineBuilderJSON = _arg_1.readUTF();
    }

    override public function toString():String {
        return (formatToString("CREATEGUILDRESULT", "success_", "lineBuilderJSON"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
