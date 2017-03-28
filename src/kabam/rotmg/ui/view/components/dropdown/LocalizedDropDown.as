package kabam.rotmg.ui.view.components.dropdown {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import kabam.rotmg.ui.view.SignalWaiter;

public class LocalizedDropDown extends Sprite {

    protected const h_:int = 36;

    protected var strings_:Vector.<String>;
    protected var w_:int = 0;
    protected var selected_:LocalizedDropDownItem;
    private var items_:Vector.<LocalizedDropDownItem>;
    private var all_:Sprite;
    private var waiter:SignalWaiter;

    public function LocalizedDropDown(_arg_1:Vector.<String>) {
        this.items_ = new Vector.<LocalizedDropDownItem>();
        this.all_ = new Sprite();
        this.waiter = new SignalWaiter();
        super();
        this.strings_ = _arg_1;
        this.makeDropDownItems();
        this.updateView();
        addChild(this.all_);
        this.all_.visible = false;
        this.waiter.complete.addOnce(this.onComplete);
    }

    public function getValue():String {
        return (this.selected_.getValue());
    }

    public function setValue(_arg_1:String):void {
        var _local_3:String;
        var _local_2:int = this.strings_.indexOf(_arg_1);
        if (_local_2 > 0) {
            _local_3 = this.strings_[0];
            this.strings_[_local_2] = _local_3;
            this.strings_[0] = _arg_1;
            this.updateView();
            dispatchEvent(new Event(Event.CHANGE));
        }
    }

    public function getClosedHeight():int {
        return (this.h_);
    }

    private function makeDropDownItems():void {
        var _local_1:LocalizedDropDownItem;
        if (this.strings_.length > 0) {
            _local_1 = this.makeDropDownItem(this.strings_[0]);
            this.items_.push(_local_1);
            this.selected_ = _local_1;
            this.selected_.addEventListener(MouseEvent.CLICK, this.onClick);
            addChild(this.selected_);
        }
        var _local_2:int = 1;
        while (_local_2 < this.strings_.length) {
            _local_1 = this.makeDropDownItem(this.strings_[_local_2]);
            _local_1.addEventListener(MouseEvent.CLICK, this.onSelect);
            _local_1.y = (this.h_ * _local_2);
            this.items_.push(_local_1);
            this.all_.addChild(_local_1);
            _local_2++;
        }
    }

    private function makeDropDownItem(_arg_1:String):LocalizedDropDownItem {
        var _local_2:LocalizedDropDownItem = new LocalizedDropDownItem(_arg_1, 0, this.h_);
        this.waiter.push(_local_2.getTextChanged());
        return (_local_2);
    }

    private function updateView():void {
        var _local_1:int;
        while (_local_1 < this.strings_.length) {
            this.items_[_local_1].setValue(this.strings_[_local_1]);
            this.items_[_local_1].setWidth(this.w_);
            _local_1++;
        }
        if (this.items_.length > 0) {
            this.selected_ = this.items_[0];
        }
    }

    private function showAll():void {
        this.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
        this.all_.visible = true;
    }

    private function hideAll():void {
        this.removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
        this.all_.visible = false;
    }

    private function onComplete():void {
        var _local_2:LocalizedDropDownItem;
        var _local_1:int = 83;
        for each (_local_2 in this.items_) {
            _local_1 = Math.max(_local_2.width, _local_1);
        }
        this.w_ = _local_1;
        this.updateView();
    }

    private function onClick(_arg_1:MouseEvent):void {
        _arg_1.stopImmediatePropagation();
        this.selected_.removeEventListener(MouseEvent.CLICK, this.onClick);
        this.selected_.addEventListener(MouseEvent.CLICK, this.onSelect);
        this.showAll();
    }

    private function onSelect(_arg_1:MouseEvent):void {
        _arg_1.stopImmediatePropagation();
        this.selected_.addEventListener(MouseEvent.CLICK, this.onClick);
        this.selected_.removeEventListener(MouseEvent.CLICK, this.onSelect);
        this.hideAll();
        var _local_2:LocalizedDropDownItem = (_arg_1.target as LocalizedDropDownItem);
        this.setValue(_local_2.getValue());
    }

    private function onOut(_arg_1:MouseEvent):void {
        this.selected_.addEventListener(MouseEvent.CLICK, this.onClick);
        this.selected_.removeEventListener(MouseEvent.CLICK, this.onSelect);
        this.hideAll();
    }


}
}//package kabam.rotmg.ui.view.components.dropdown
