package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class JoinGuild extends OutgoingMessage {

    public var guildName_:String;

    public function JoinGuild(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeUTF(this.guildName_);
    }

    override public function toString():String {
        return (formatToString("JOINGUILD", "guildName_"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
