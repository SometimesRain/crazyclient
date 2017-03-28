package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class ChangeGuildRank extends OutgoingMessage {

    public var name_:String;
    public var guildRank_:int;

    public function ChangeGuildRank(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeUTF(this.name_);
        _arg_1.writeInt(this.guildRank_);
    }

    override public function toString():String {
        return (formatToString("CHANGEGUILDRANK", "name_", "guildRank_"));
    }


}
}//package kabam.rotmg.messaging.impl.outgoing
