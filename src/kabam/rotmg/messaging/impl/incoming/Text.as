package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class Text extends IncomingMessage {

    public var name_:String;
    public var objectId_:int;
    public var numStars_:int;
    public var bubbleTime_:uint;
    public var recipient_:String;
    public var text_:String;
    public var cleanText_:String;

    public function Text(_arg_1:uint, _arg_2:Function) {
        this.name_ = new String();
        this.text_ = new String();
        this.cleanText_ = new String();
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        this.name_ = _arg_1.readUTF();
        this.objectId_ = _arg_1.readInt();
        this.numStars_ = _arg_1.readInt();
        this.bubbleTime_ = _arg_1.readUnsignedByte();
        this.recipient_ = _arg_1.readUTF();
        this.text_ = _arg_1.readUTF();
        this.cleanText_ = _arg_1.readUTF();
    }

    override public function toString():String {
        return (formatToString("TEXT", "name_", "objectId_", "numStars_", "bubbleTime_", "recipient_", "text_", "cleanText_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
