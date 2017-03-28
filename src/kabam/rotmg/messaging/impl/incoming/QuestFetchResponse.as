package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class QuestFetchResponse extends IncomingMessage {

    public var tier:int;
    public var goal:String;
    public var description:String;
    public var image:String;

    public function QuestFetchResponse(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.tier = _arg_1.readInt();
        this.goal = _arg_1.readUTF();
        this.description = _arg_1.readUTF();
        this.image = _arg_1.readUTF();
    }

    override public function toString():String {
        return (formatToString("QUESTFETCHRESPONSE", "tier", "goal", "description", "image"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
