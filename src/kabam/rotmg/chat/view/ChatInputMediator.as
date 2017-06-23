package kabam.rotmg.chat.view {
import com.company.assembleegameclient.parameters.Parameters;
import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.text.TextField;

import kabam.rotmg.chat.control.ParseChatMessageSignal;
import kabam.rotmg.chat.control.ShowChatInputSignal;
import kabam.rotmg.chat.model.ChatModel;
import kabam.rotmg.chat.model.ChatShortcutModel;
import kabam.rotmg.chat.model.TellModel;
import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.text.model.TextAndMapProvider;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ChatInputMediator extends Mediator {

    [Inject]
    public var view:ChatInput;
    [Inject]
    public var model:ChatModel;
    [Inject]
    public var textAndMapProvider:TextAndMapProvider;
    [Inject]
    public var fontModel:FontModel;
    [Inject]
    public var parseChatMessage:ParseChatMessageSignal;
    [Inject]
    public var showChatInput:ShowChatInputSignal;
    [Inject]
    public var tellModel:TellModel;
    [Inject]
    public var chatShortcutModel:ChatShortcutModel;
    public var stage:Stage;


    override public function initialize():void {
        this.stage = this.view.stage;
        this.stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        this.view.setup(this.model, this.makeTextfield());
        this.view.message.add(this.onMessage);
        this.view.close.add(this.onDeactivate);
        this.showChatInput.add(this.onShowChatInput);
    }

    override public function destroy():void {
        this.view.message.remove(this.onMessage);
        this.view.close.remove(this.onDeactivate);
        this.showChatInput.remove(this.onShowChatInput);
        this.stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
    }

    private function onDeactivate():void {
        this.showChatInput.dispatch(false, "");
        this.tellModel.resetRecipients();
    }

    private function onMessage(_arg_1:String):void {
        this.parseChatMessage.dispatch(_arg_1);
        this.showChatInput.dispatch(false, "");
    }

    private function onShowChatInput(_arg_1:Boolean, _arg_2:String):void {
        if (_arg_1) {
            this.view.activate(_arg_2, true);
        }
        else {
            this.view.deactivate();
        }
        if (!_arg_1) {
            this.tellModel.resetRecipients();
        }
    }

    private function makeTextfield():TextField {
        var _local_1:TextField = this.textAndMapProvider.getTextField();
        this.fontModel.apply(_local_1, 14, 0xFFFFFF, true);
        return (_local_1);
    }

    private function onKeyUp(_arg_1:KeyboardEvent):void {
        if (view.visible && (_arg_1.keyCode == chatShortcutModel.getTellShortcut() || this.stage.focus == null || viewDoesntHaveFocus())) {
            this.processKeyUp(_arg_1);
        }
    }

    private function viewDoesntHaveFocus():Boolean {
        return (stage.focus.parent != view && stage.focus != view);
    }

    private function processKeyUp(_arg_1:KeyboardEvent):void {
        var _local_2:uint = _arg_1.keyCode;
		//trace("INPUTMED");
		switch (_local_2) {
			case chatShortcutModel.getCommandShortcut():
				view.activate("/", true);
				break;
			case chatShortcutModel.getChatShortcut():
				view.activate("", true);
				break;
			case chatShortcutModel.getGuildShortcut():
				view.activate("/g ", true);
				break;
			case chatShortcutModel.getTellShortcut():
                handleTell();
				break;
			/*case Parameters.data_.hackChat:
				view.activate("/b ", true);
				break;*/
		}
    }

    private function handleTell():void {
        if (!this.view.hasEnteredText()) {
            this.view.activate("/tell " + tellModel.getNext() + " ", true);
        }
    }


}
}//package kabam.rotmg.chat.view
