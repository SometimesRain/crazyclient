package com.company.assembleegameclient.ui.panels {
import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.DeprecatedTextButton;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.utils.Timer;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

public class TradeRequestPanel extends Panel {

    public var name_:String;
    private var title_:TextFieldDisplayConcrete;
    private var rejectButton_:DeprecatedTextButton;
    private var acceptButton_:DeprecatedTextButton;
    private var timer_:Timer;

    public function TradeRequestPanel(_arg_1:AGameSprite, _arg_2:String) {
        super(_arg_1);
        this.name_ = _arg_2;
        this.title_ = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setTextWidth(WIDTH);
        this.title_.setStringBuilder(new LineBuilder().setParams(TextKey.TRADEREQUESTPANEL_WANTSTRADE, {"name": _arg_2}));
        this.title_.setBold(true);
        this.title_.setWordWrap(true).setMultiLine(true);
        this.title_.setAutoSize(TextFieldAutoSize.CENTER);
        this.title_.filters = [new DropShadowFilter(0, 0, 0)];
        this.title_.y = 0;
        addChild(this.title_);
        this.rejectButton_ = new DeprecatedTextButton(16, TextKey.TRADE_REJECT);
        this.rejectButton_.addEventListener(MouseEvent.CLICK, this.onRejectClick);
        addChild(this.rejectButton_);
        this.acceptButton_ = new DeprecatedTextButton(16, TextKey.TRADE_ACCEPT);
        this.acceptButton_.addEventListener(MouseEvent.CLICK, this.onAcceptClick);
        addChild(this.acceptButton_);
        this.timer_ = new Timer((20 * 1000), 1);
        this.timer_.start();
        this.timer_.addEventListener(TimerEvent.TIMER, this.onTimer);
        var _local_3:SignalWaiter = new SignalWaiter();
        _local_3.pushArgs(this.rejectButton_.textChanged, this.acceptButton_.textChanged);
        _local_3.complete.addOnce(this.onComplete);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onComplete():void {
        this.rejectButton_.x = ((WIDTH / 4) - (this.rejectButton_.width / 2));
        this.acceptButton_.x = (((3 * WIDTH) / 4) - (this.acceptButton_.width / 2));
        this.rejectButton_.y = ((HEIGHT - this.rejectButton_.height) - 4);
        this.acceptButton_.y = ((HEIGHT - this.acceptButton_.height) - 4);
    }

    private function onAddedToStage(_arg_1:Event):void
    {
        stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onRemovedFromStage(_arg_1:Event):void
    {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onKeyDown(_arg_1:KeyboardEvent):void
    {
        if(_arg_1.keyCode == Parameters.data_.interact && stage.focus == null)
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }

    private function onTimer(_arg_1:TimerEvent):void {
        dispatchEvent(new Event(Event.COMPLETE));
    }

    private function onRejectClick(_arg_1:MouseEvent):void {
        dispatchEvent(new Event(Event.COMPLETE));
    }

    private function onAcceptClick(_arg_1:MouseEvent):void {
        gs_.gsc_.requestTrade(this.name_);
        dispatchEvent(new Event(Event.COMPLETE));
    }


}
}//package com.company.assembleegameclient.ui.panels
