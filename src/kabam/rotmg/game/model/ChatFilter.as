package kabam.rotmg.game.model {
import com.company.assembleegameclient.parameters.Parameters;

public class ChatFilter {


    public function guestChatFilter(_arg_1:String):Boolean {
        var _local_2:Boolean;
        if (_arg_1 == null) {
            return (true);
        }
        if ((((((((_arg_1 == Parameters.SERVER_CHAT_NAME)) || ((_arg_1 == Parameters.HELP_CHAT_NAME)))) || ((_arg_1 == Parameters.ERROR_CHAT_NAME)))) || ((_arg_1 == Parameters.CLIENT_CHAT_NAME)))) {
            _local_2 = true;
        }
        if (_arg_1.charAt(0) == "#") {
            _local_2 = true;
        }
        if (_arg_1.charAt(0) == "@") {
            _local_2 = true;
        }
        return (_local_2);
    }


}
}//package kabam.rotmg.game.model
