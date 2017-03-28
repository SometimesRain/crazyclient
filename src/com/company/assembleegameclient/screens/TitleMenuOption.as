package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.util.MoreColorUtil;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;
import flash.utils.getTimer;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;

public class TitleMenuOption extends Sprite {

    protected static const OVER_COLOR_TRANSFORM:ColorTransform = new ColorTransform(1, (220 / 0xFF), (133 / 0xFF));
    private static const DROP_SHADOW_FILTER:DropShadowFilter = new DropShadowFilter(0, 0, 0, 0.5, 12, 12);

    public const clicked:Signal = new Signal();
    public const textField:TextFieldDisplayConcrete = makeTextFieldDisplayConcrete();
    public const changed:Signal = textField.textChanged;

    private var colorTransform:ColorTransform;
    private var size:int;
    private var isPulse:Boolean;
    private var originalWidth:Number;
    private var originalHeight:Number;
    private var active:Boolean;
    private var color:uint = 0xFFFFFF;
    private var hoverColor:uint;

    public function TitleMenuOption(_arg_1:String, _arg_2:int, _arg_3:Boolean) {
        this.size = _arg_2;
        this.isPulse = _arg_3;
        this.textField.setSize(_arg_2).setColor(0xFFFFFF).setBold(true);
        this.setTextKey(_arg_1);
        this.originalWidth = width;
        this.originalHeight = height;
        this.activate();
    }

    public function activate():void {
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        addEventListener(MouseEvent.CLICK, this.onMouseClick);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.active = true;
    }

    public function deactivate():void {
        var _local_1:ColorTransform = new ColorTransform();
        _local_1.color = 0x363636;
        this.setColorTransform(_local_1);
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        removeEventListener(MouseEvent.CLICK, this.onMouseClick);
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.active = false;
    }

    public function setColor(_arg_1:uint):void {
        this.color = _arg_1;
        var _local_2:uint = ((_arg_1 & 0xFF0000) >> 16);
        var _local_3:uint = ((_arg_1 & 0xFF00) >> 8);
        var _local_4:uint = (_arg_1 & 0xFF);
        var _local_5:ColorTransform = new ColorTransform((_local_2 / 0xFF), (_local_3 / 0xFF), (_local_4 / 0xFF));
        this.setColorTransform(_local_5);
    }

    public function isActive():Boolean {
        return (this.active);
    }

    private function makeTextFieldDisplayConcrete():TextFieldDisplayConcrete {
        var _local_1:TextFieldDisplayConcrete;
        _local_1 = new TextFieldDisplayConcrete();
        _local_1.filters = [DROP_SHADOW_FILTER];
        addChild(_local_1);
        return (_local_1);
    }

    public function setTextKey(_arg_1:String):void {
        name = _arg_1;
        this.textField.setStringBuilder(new LineBuilder().setParams(_arg_1));
    }

    public function setAutoSize(_arg_1:String):void {
        this.textField.setAutoSize(_arg_1);
    }

    public function setVerticalAlign(_arg_1:String):void {
        this.textField.setVerticalAlign(_arg_1);
    }

    private function onAddedToStage(_arg_1:Event):void {
        if (this.isPulse) {
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        if (this.isPulse) {
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }
    }

    private function onEnterFrame(_arg_1:Event):void {
        var _local_2:Number = (1.05 + (0.05 * Math.sin((getTimer() / 200))));
        this.textField.scaleX = _local_2;
        this.textField.scaleY = _local_2;
    }

    public function setColorTransform(_arg_1:ColorTransform):void {
        if (_arg_1 == this.colorTransform) {
            return;
        }
        this.colorTransform = _arg_1;
        if (this.colorTransform == null) {
            this.textField.transform.colorTransform = MoreColorUtil.identity;
        }
        else {
            this.textField.transform.colorTransform = this.colorTransform;
        }
    }

    protected function onMouseOver(_arg_1:MouseEvent):void {
        this.setColorTransform(OVER_COLOR_TRANSFORM);
    }

    protected function onMouseOut(_arg_1:MouseEvent):void {
        if (this.color != 0xFFFFFF) {
            this.setColor(this.color);
        }
        else {
            this.setColorTransform(null);
        }
    }

    protected function onMouseClick(_arg_1:MouseEvent):void {
        SoundEffectLibrary.play("button_click");
        this.clicked.dispatch();
    }

    override public function toString():String {
        return ((("[TitleMenuOption " + this.textField.getText()) + "]"));
    }

    public function createNoticeTag(_arg_1:String, _arg_2:int, _arg_3:uint, _arg_4:Boolean):void
    {
        var _local_5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local_5.setSize(_arg_2).setColor(_arg_3).setBold(_arg_4);
        _local_5.setStringBuilder(new LineBuilder().setParams(_arg_1));
        _local_5.x = this.textField.x - 4;
        _local_5.y = this.textField.y - 20;
        addChild(_local_5);
    }


}
}//package com.company.assembleegameclient.screens
