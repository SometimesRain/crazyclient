package com.company.assembleegameclient.ui.options {
import com.company.util.KeyCodes;

import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.utils.getTimer;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class KeyCodeBox extends Sprite {

    public static const WIDTH:int = 80;
    public static const HEIGHT:int = 32;

    public var keyCode_:uint;
    public var selected_:Boolean;
    public var inputMode_:Boolean;
    private var char_:TextFieldDisplayConcrete = null;

    public function KeyCodeBox(_arg_1:uint) {
        this.keyCode_ = _arg_1;
        this.selected_ = false;
        this.inputMode_ = false;
        this.char_ = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF);
        this.char_.setBold(true);
        this.char_.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
        this.char_.setAutoSize(TextFieldAutoSize.CENTER).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        addChild(this.char_);
        this.drawBackground();
        this.setNormalMode();
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
    }

    public function value():uint {
        return (this.keyCode_);
    }

    public function setKeyCode(_arg_1:uint):void {
		//trace("key set to "+_arg_1);
        if (_arg_1 == this.keyCode_) {
            return;
        }
        this.keyCode_ = _arg_1;
        this.setTextToKey();
        dispatchEvent(new Event(Event.CHANGE, true));
    }

    public function setTextToKey():void {
        this.setText(new StaticStringBuilder(KeyCodes.CharCodeStrings[this.keyCode_]));
    }

    private function drawBackground():void {
        var _local_1:Graphics = graphics;
        _local_1.clear();
        _local_1.lineStyle(2, ((((this.selected_) || (this.inputMode_))) ? 0xB3B3B3 : 0x444444));
        _local_1.beginFill(0x333333);
        _local_1.drawRect(0, 0, WIDTH, HEIGHT);
        _local_1.endFill();
        _local_1.lineStyle();
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        this.selected_ = true;
        this.drawBackground();
    }

    private function onRollOut(_arg_1:MouseEvent):void {
        this.selected_ = false;
        this.drawBackground();
    }

    private function setText(_arg_1:StringBuilder):void {
        this.char_.setStringBuilder(_arg_1);
        this.char_.x = (WIDTH / 2);
        this.char_.y = (HEIGHT / 2);
        this.drawBackground();
    }

    private function setNormalMode():void {
        this.inputMode_ = false;
        removeEventListener(Event.ENTER_FRAME, this.onInputEnterFrame);
        if (stage != null) {
            removeEventListener(KeyboardEvent.KEY_DOWN, this.onInputKeyDown);
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onInputMouseDown, true);
        }
        this.setTextToKey();
        addEventListener(MouseEvent.CLICK, this.onNormalClick);
    }

    private function setInputMode():void {
        if (stage == null) {
            return;
        }
        stage.stageFocusRect = false;
        stage.focus = this;
        this.inputMode_ = true;
        removeEventListener(MouseEvent.CLICK, this.onNormalClick);
        addEventListener(Event.ENTER_FRAME, this.onInputEnterFrame);
        addEventListener(KeyboardEvent.KEY_DOWN, this.onInputKeyDown);
        stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onInputMouseDown, true);
    }

    private function onNormalClick(_arg_1:MouseEvent):void {
        this.setInputMode();
    }

    private function onInputEnterFrame(_arg_1:Event):void {
        var _local_2:int = (getTimer() / 400);
        var _local_3:Boolean = ((_local_2 % 2) == 0);
        if (_local_3) {
            this.setText(new StaticStringBuilder(""));
        }
        else {
            this.setText(new LineBuilder().setParams(TextKey.KEYCODEBOX_HITKEY));
        }
    }

    private function onInputKeyDown(_arg_1:KeyboardEvent):void {
        _arg_1.stopImmediatePropagation();
        this.keyCode_ = _arg_1.keyCode;
		//trace("key set to "+keyCode_);
        this.setNormalMode();
        dispatchEvent(new Event(Event.CHANGE, true));
    }

    private function onInputMouseDown(_arg_1:MouseEvent):void {
        this.setNormalMode();
    }


}
}//package com.company.assembleegameclient.ui.options
