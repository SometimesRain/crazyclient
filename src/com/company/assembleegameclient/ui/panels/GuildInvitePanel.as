package com.company.assembleegameclient.ui.panels {
import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.ui.DeprecatedTextButton;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.utils.Timer;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

public class GuildInvitePanel extends Panel {

    private const waiter:SignalWaiter = new SignalWaiter();

    public var name_:String;
    private var title_:TextFieldDisplayConcrete;
    private var guildName_:String;
    private var guildNameText_:TextFieldDisplayConcrete;
    private var rejectButton_:DeprecatedTextButton;
    private var acceptButton_:DeprecatedTextButton;
    private var timer_:Timer;

    public function GuildInvitePanel(_arg_1:AGameSprite, _arg_2:String, _arg_3:String) {
        super(_arg_1);
        this.name_ = _arg_2;
        this.guildName_ = _arg_3;
        this.title_ = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth(WIDTH).setBold(true).setAutoSize(TextFieldAutoSize.CENTER).setHTML(true);
        this.title_.setStringBuilder(new LineBuilder().setParams(TextKey.GUILD_INVITATION, {"playerName": _arg_2}).setPrefix('<p align="center">').setPostfix("</p>"));
        this.title_.filters = [new DropShadowFilter(0, 0, 0)];
        this.title_.y = 0;
        addChild(this.title_);
        this.guildNameText_ = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth(WIDTH).setAutoSize(TextFieldAutoSize.CENTER).setBold(true).setHTML(true);
        this.guildNameText_.setStringBuilder(new StaticStringBuilder((('<p align="center">' + this.guildName_) + "</p>")));
        this.guildNameText_.filters = [new DropShadowFilter(0, 0, 0)];
        this.guildNameText_.y = 20;
        addChild(this.guildNameText_);
        this.rejectButton_ = new DeprecatedTextButton(16, TextKey.GUILD_REJECTION);
        this.rejectButton_.addEventListener(MouseEvent.CLICK, this.onRejectClick);
        this.waiter.push(this.rejectButton_.textChanged);
        addChild(this.rejectButton_);
        this.acceptButton_ = new DeprecatedTextButton(16, TextKey.GUILD_ACCEPT);
        this.acceptButton_.addEventListener(MouseEvent.CLICK, this.onAcceptClick);
        this.waiter.push(this.acceptButton_.textChanged);
        addChild(this.acceptButton_);
        this.timer_ = new Timer((20 * 1000), 1);
        this.timer_.start();
        this.timer_.addEventListener(TimerEvent.TIMER, this.onTimer);
        this.waiter.complete.addOnce(this.alignUI);
    }

    private function alignUI():void {
        this.rejectButton_.x = ((WIDTH / 4) - (this.rejectButton_.width / 2));
        this.rejectButton_.y = ((HEIGHT - this.rejectButton_.height) - 4);
        this.acceptButton_.x = (((3 * WIDTH) / 4) - (this.acceptButton_.width / 2));
        this.acceptButton_.y = ((HEIGHT - this.acceptButton_.height) - 4);
    }

    private function onTimer(_arg_1:TimerEvent):void {
        dispatchEvent(new Event(Event.COMPLETE));
    }

    private function onRejectClick(_arg_1:MouseEvent):void {
        dispatchEvent(new Event(Event.COMPLETE));
    }

    private function onAcceptClick(_arg_1:MouseEvent):void {
        gs_.gsc_.joinGuild(this.guildName_);
        dispatchEvent(new Event(Event.COMPLETE));
    }


}
}//package com.company.assembleegameclient.ui.panels
