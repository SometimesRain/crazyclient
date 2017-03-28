package kabam.rotmg.chat.model {
public class ChatMessage {

    public var name:String;
    public var text:String;
    public var objectId:int = -1;
    public var numStars:int = -1;
    public var recipient:String = "";
    public var isToMe:Boolean;
    public var isWhisper:Boolean;
    public var tokens:Object;


    public static function make(_arg_1:String, _arg_2:String, _arg_3:int = -1, _arg_4:int = -1, _arg_5:String = "", _arg_6:Boolean = false, _arg_7:Object = null, _arg_8:Boolean = false):ChatMessage {
        var _local_9:ChatMessage = new (ChatMessage)();
        _local_9.name = _arg_1;
        _local_9.text = _arg_2;
        _local_9.objectId = _arg_3;
        _local_9.numStars = _arg_4;
        _local_9.recipient = _arg_5;
        _local_9.isToMe = _arg_6;
        _local_9.isWhisper = _arg_8;
        _local_9.tokens = (((_arg_7 == null)) ? {} : _arg_7);
        return (_local_9);
    }


}
}//package kabam.rotmg.chat.model
