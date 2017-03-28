package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class QuestRedeemResponse extends IncomingMessage {

    public var ok:Boolean;
    public var message:String;

    public function QuestRedeemResponse(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.ok = _arg_1.readBoolean();
        this.message = _arg_1.readUTF();
    }

    override public function toString():String {
        return (formatToString("QUESTREDEEMRESPONSE", "ok", "message"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
