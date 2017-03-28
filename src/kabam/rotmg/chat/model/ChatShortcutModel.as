package kabam.rotmg.chat.model {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.options.Options;

public class ChatShortcutModel {

    private var commandShortcut:int = 191;
    private var chatShortcut:int = 13;
    private var tellShortcut:int = 9;
    private var guildShortcut:int = 71;
    private var scrollUp:uint = 33;
    private var scrollDown:uint = 34;


    public function getCommandShortcut():int {
        return (Parameters.data_[Options.CHAT_COMMAND]);
    }

    public function getChatShortcut():int {
        return (Parameters.data_[Options.CHAT]);
    }

    public function getTellShortcut():int {
        return (Parameters.data_[Options.TELL]);
    }

    public function getGuildShortcut():int {
        return (Parameters.data_[Options.GUILD_CHAT]);
    }

    public function getScrollUp():uint {
        return (Parameters.data_[Options.SCROLL_CHAT_UP]);
    }

    public function getScrollDown():uint {
        return (Parameters.data_[Options.SCROLL_CHAT_DOWN]);
    }


}
}//package kabam.rotmg.chat.model
