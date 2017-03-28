package kabam.lib.console.view {
import flash.events.KeyboardEvent;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.ui.Keyboard;

import kabam.lib.resizing.view.Resizable;
import kabam.lib.util.StageLifecycleUtil;

public final class ConsoleInputView extends TextField implements Resizable {

    public static const HEIGHT:int = 20;

    private var lifecycle:StageLifecycleUtil;

    public function ConsoleInputView() {
        background = true;
        backgroundColor = 0x3300;
        border = true;
        borderColor = 0x333333;
        defaultTextFormat = new TextFormat("_sans", 14, 0xFFFFFF, true);
        text = "";
        type = TextFieldType.INPUT;
        restrict = "^`";
        this.lifecycle = new StageLifecycleUtil(this);
        this.lifecycle.addedToStage.add(this.onAddedToStage);
        this.lifecycle.removedFromStage.add(this.onRemovedFromStage);
    }

    private function onAddedToStage():void {
        addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onRemovedFromStage():void {
        removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onKeyDown(_arg_1:KeyboardEvent):void {
        var _local_2:String = text;
        switch (_arg_1.keyCode) {
            case Keyboard.ENTER:
                text = "";
                dispatchEvent(new ConsoleEvent(ConsoleEvent.INPUT, _local_2));
                return;
            case Keyboard.UP:
                dispatchEvent(new ConsoleEvent(ConsoleEvent.GET_PREVIOUS));
                return;
            case Keyboard.DOWN:
                dispatchEvent(new ConsoleEvent(ConsoleEvent.GET_NEXT));
                return;
        }
    }

    public function resize(_arg_1:Rectangle):void {
        var _local_2:int = (_arg_1.height * 0.5);
        if (_local_2 > HEIGHT) {
            _local_2 = HEIGHT;
        }
        width = _arg_1.width;
        height = _local_2;
        x = _arg_1.x;
        y = (_arg_1.bottom - height);
    }


}
}//package kabam.lib.console.view
