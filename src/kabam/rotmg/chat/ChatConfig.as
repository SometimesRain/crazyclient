package kabam.rotmg.chat {
import kabam.lib.net.api.MessageMap;
import kabam.rotmg.chat.control.AddChatSignal;
import kabam.rotmg.chat.control.ClearTellModelCommand;
import kabam.rotmg.chat.control.ParseAddTextLineCommand;
import kabam.rotmg.chat.control.ParseChatMessageCommand;
import kabam.rotmg.chat.control.ParseChatMessageSignal;
import kabam.rotmg.chat.control.ScrollListSignal;
import kabam.rotmg.chat.control.ShowChatInputSignal;
import kabam.rotmg.chat.control.TextHandler;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.chat.model.ChatModel;
import kabam.rotmg.chat.model.TellModel;
import kabam.rotmg.chat.view.Chat;
import kabam.rotmg.chat.view.ChatInput;
import kabam.rotmg.chat.view.ChatInputMediator;
import kabam.rotmg.chat.view.ChatInputNotAllowed;
import kabam.rotmg.chat.view.ChatInputNotAllowedMediator;
import kabam.rotmg.chat.view.ChatList;
import kabam.rotmg.chat.view.ChatListItemFactory;
import kabam.rotmg.chat.view.ChatListMediator;
import kabam.rotmg.chat.view.ChatMediator;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.game.signals.ExitGameSignal;
import kabam.rotmg.game.signals.GameClosedSignal;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.messaging.impl.incoming.Text;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.impl.SignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class ChatConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var messageMap:MessageMap;
    [Inject]
    public var commandMap:SignalCommandMap;
    [Inject]
    public var mediatorMap:IMediatorMap;


    public function configure():void {
        this.injector.map(ChatModel).asSingleton();
        this.injector.map(ChatConfig).asSingleton();
        this.injector.map(ChatListItemFactory).asSingleton();
        this.injector.map(TellModel).asSingleton();
        this.injector.map(AddChatSignal).asSingleton();
        this.injector.map(ScrollListSignal).asSingleton();
        this.injector.map(ShowChatInputSignal).asSingleton();
        this.commandMap.map(AddTextLineSignal).toCommand(ParseAddTextLineCommand);
        this.commandMap.map(ExitGameSignal).toCommand(ClearTellModelCommand);
        this.commandMap.map(GameClosedSignal).toCommand(ClearTellModelCommand);
        this.messageMap.map(GameServerConnection.TEXT).toMessage(Text).toHandler(TextHandler);
        this.commandMap.map(ParseChatMessageSignal).toCommand(ParseChatMessageCommand);
        this.mediatorMap.map(ChatInput).toMediator(ChatInputMediator);
        this.mediatorMap.map(ChatList).toMediator(ChatListMediator);
        this.mediatorMap.map(Chat).toMediator(ChatMediator);
        this.mediatorMap.map(ChatInputNotAllowed).toMediator(ChatInputNotAllowedMediator);
    }

}
}//package kabam.rotmg.chat
