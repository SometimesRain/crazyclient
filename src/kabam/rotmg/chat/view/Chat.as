package kabam.rotmg.chat.view {
import com.company.assembleegameclient.parameters.Parameters;
import flash.display.Sprite;

import kabam.rotmg.chat.model.ChatModel;

public class Chat extends Sprite {

    public var list:ChatList;
    private var input:ChatInput;
    private var notAllowed:ChatInputNotAllowed;
    private var model:ChatModel;

    public function Chat() {
        mouseEnabled = true;
        mouseChildren = true;
        this.list = new ChatList();
        addChild(this.list);
    }

    public function setup(_arg_1:ChatModel, _arg_2:Boolean):void {
        this.model = _arg_1;
		if (Parameters.data_.uiscale) {
			this.y = (600 - _arg_1.bounds.height);
		}
		else {
			y = 300 + 300 * (1 - (600 / WebMain.sHeight));
		}
        this.list.y = _arg_1.bounds.height;
		//trace("setup",y,list.y)
        if (_arg_2) {
            this.addChatInput();
        }
        else {
            this.addInputNotAllowed();
        }
    }

    private function addChatInput():void {
        input = new ChatInput();
        addChild(input);
    }

    private function addInputNotAllowed():void {
        this.notAllowed = new ChatInputNotAllowed();
        addChild(this.notAllowed);
        this.list.y = (this.model.bounds.height - this.model.lineHeight);
    }

    public function removeRegisterBlock():void {
        if (notAllowed != null && contains(notAllowed)) {
            removeChild(notAllowed);
        }
        if (input == null || !contains(input)) {
            addChatInput();
        }
    }


}
}//package kabam.rotmg.chat.view
