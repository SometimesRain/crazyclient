package com.company.assembleegameclient.account.ui {
import com.company.assembleegameclient.account.ui.components.Selectable;
import com.company.assembleegameclient.account.ui.components.SelectionGroup;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import kabam.lib.ui.api.Layout;
import kabam.lib.ui.impl.HorizontalLayout;
import kabam.rotmg.ui.view.SignalWaiter;

public class PaymentMethodRadioButtons extends Sprite {

    private const waiter:SignalWaiter = new SignalWaiter();

    private var labels:Vector.<String>;
    private var boxes:Vector.<PaymentMethodRadioButton>;
    private var group:SelectionGroup;

    public function PaymentMethodRadioButtons(_arg_1:Vector.<String>) {
        this.labels = _arg_1;
        this.waiter.complete.add(this.alignRadioButtons);
        this.makeRadioButtons();
        this.alignRadioButtons();
        this.makeSelectionGroup();
    }

    public function setSelected(_arg_1:String):void {
        this.group.setSelected(_arg_1);
    }

    public function getSelected():String {
        return (this.group.getSelected().getValue());
    }

    private function makeRadioButtons():void {
        var _local_1:int = this.labels.length;
        this.boxes = new Vector.<PaymentMethodRadioButton>(_local_1, true);
        var _local_2:int;
        while (_local_2 < _local_1) {
            this.boxes[_local_2] = this.makeRadioButton(this.labels[_local_2]);
            _local_2++;
        }
    }

    private function makeRadioButton(_arg_1:String):PaymentMethodRadioButton {
        var _local_2:PaymentMethodRadioButton = new PaymentMethodRadioButton(_arg_1);
        _local_2.addEventListener(MouseEvent.CLICK, this.onSelected);
        this.waiter.push(_local_2.textSet);
        addChild(_local_2);
        return (_local_2);
    }

    private function onSelected(_arg_1:Event):void {
        var _local_2:Selectable = (_arg_1.currentTarget as Selectable);
        this.group.setSelected(_local_2.getValue());
    }

    private function alignRadioButtons():void {
        var _local_1:Vector.<DisplayObject> = this.castBoxesToDisplayObjects();
        var _local_2:Layout = new HorizontalLayout();
        _local_2.setPadding(20);
        _local_2.layout(_local_1);
    }

    private function castBoxesToDisplayObjects():Vector.<DisplayObject> {
        var _local_1:int = this.boxes.length;
        var _local_2:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
        var _local_3:int;
        while (_local_3 < _local_1) {
            _local_2[_local_3] = this.boxes[_local_3];
            _local_3++;
        }
        return (_local_2);
    }

    private function makeSelectionGroup():void {
        var _local_1:Vector.<Selectable> = this.castBoxesToSelectables();
        this.group = new SelectionGroup(_local_1);
        this.group.setSelected(this.boxes[0].getValue());
    }

    private function castBoxesToSelectables():Vector.<Selectable> {
        var _local_1:int = this.boxes.length;
        var _local_2:Vector.<Selectable> = new Vector.<Selectable>(0);
        var _local_3:int;
        while (_local_3 < _local_1) {
            _local_2[_local_3] = this.boxes[_local_3];
            _local_3++;
        }
        return (_local_2);
    }


}
}//package com.company.assembleegameclient.account.ui
