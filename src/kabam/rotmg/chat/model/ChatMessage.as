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


    public static function make(name:String, text:String, objId:int = -1, stars:int = -1, recipient:String = "", isToMe:Boolean = false, token:Object = null, isWhisper:Boolean = false):ChatMessage {
        var _local_9:ChatMessage = new ChatMessage();
        _local_9.name = name;
        _local_9.text = text;
        _local_9.objectId = objId;
        _local_9.numStars = stars;
        _local_9.recipient = recipient;
        _local_9.isToMe = isToMe;
        _local_9.isWhisper = isWhisper;
        _local_9.tokens = (((token == null)) ? {} : token);
        return (_local_9);
    }


}
}//package kabam.rotmg.chat.model
