package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class InvitedToGuild extends IncomingMessage {

    public var name_:String;
    public var guildName_:String;

    public function InvitedToGuild(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.name_ = _arg_1.readUTF();
        this.guildName_ = _arg_1.readUTF();
    }

    override public function toString():String {
        return (formatToString("INVITEDTOGUILD", "name_", "guildName_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
