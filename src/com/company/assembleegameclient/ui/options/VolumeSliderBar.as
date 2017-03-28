package com.company.assembleegameclient.ui.options {
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class VolumeSliderBar extends Sprite {

    private const MIN:Number = 0;
    private const MAX:Number = 1;

    private var bar:Shape;
    private var _label:TextFieldDisplayConcrete;
    private var _currentVolume:Number;
    private var _isMouseDown:Boolean;
    private var _mousePoint:Point;
    private var _localPoint:Point;

    public function VolumeSliderBar(_arg_1:Number, _arg_2:Number = 0xFFFFFF) {
        this._mousePoint = new Point(0, 0);
        this._localPoint = new Point(0, 0);
        super();
        this.init();
        this.currentVolume = _arg_1;
        this.draw(0x9B9B9B);
        this._isMouseDown = false;
        this.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        this.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
    }

    private function init():void {
        this._label = new TextFieldDisplayConcrete().setSize(14).setColor(0xABABAB);
        this._label.setAutoSize(TextFieldAutoSize.CENTER).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this._label.setStringBuilder(new StaticStringBuilder("Vol:"));
        this._label.setBold(true);
        this._label.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
        addChild(this._label);
        this.bar = new Shape();
        this.bar.x = 20;
        addChild(this.bar);
        graphics.beginFill(0, 0);
        graphics.drawRect(0, -30, 130, 30);
        graphics.endFill();
    }

    public function get currentVolume():Number {
        return (this._currentVolume);
    }

    public function set currentVolume(_arg_1:Number):void {
        _arg_1 = (((_arg_1) > this.MAX) ? this.MAX : (((_arg_1) < this.MIN) ? this.MIN : _arg_1));
        this._currentVolume = _arg_1;
        this.draw();
    }

    private function draw(_arg_1:uint = 0x9B9B9B):void {
        var _local_2:* = (this._currentVolume * 100);
        var _local_3:Number = (_local_2 * -0.2);
        this.bar.graphics.clear();
        this.bar.graphics.lineStyle(2, 0x9B9B9B);
        this.bar.graphics.moveTo(0, 0);
        this.bar.graphics.lineTo(0, -1);
        this.bar.graphics.lineTo(100, -20);
        this.bar.graphics.lineTo(100, 0);
        this.bar.graphics.lineTo(0, 0);
        this.bar.graphics.beginFill(_arg_1, 0.8);
        this.bar.graphics.moveTo(0, 0);
        this.bar.graphics.lineTo(0, -1);
        this.bar.graphics.lineTo(_local_2, _local_3);
        this.bar.graphics.lineTo(_local_2, 0);
        this.bar.graphics.lineTo(0, 0);
        this.bar.graphics.endFill();
    }

    private function onMouseDown(_arg_1:MouseEvent):void {
        this._isMouseDown = true;
        this.currentVolume = (_arg_1.localX / 100);
        dispatchEvent(new Event(Event.CHANGE, true));
        if (stage) {
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
    }

    private function onMouseUp(_arg_1:MouseEvent):void {
        this._isMouseDown = false;
        if (stage) {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
        }
    }

    private function onMouseMove(_arg_1:MouseEvent):void {
        if (!this._isMouseDown) {
            return;
        }
        this._mousePoint.x = _arg_1.currentTarget.mouseX;
        this._localPoint = this.globalToLocal(this._mousePoint);
        this.currentVolume = (this._localPoint.x / 100);
        dispatchEvent(new Event(Event.CHANGE, true));
    }


}
}//package com.company.assembleegameclient.ui.options
