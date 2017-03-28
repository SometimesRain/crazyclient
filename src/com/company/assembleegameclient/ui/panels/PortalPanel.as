package com.company.assembleegameclient.ui.panels {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Portal;
import com.company.assembleegameclient.objects.PortalNameParser;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.tutorial.Tutorial;
import com.company.assembleegameclient.tutorial.doneAction;
import com.company.assembleegameclient.ui.DeprecatedTextButton;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.Signal;

public class PortalPanel extends Panel {

    private const LOCKED:String = "Locked ";
    private const TEXT_PATTERN:RegExp = /\{"text":"(.+)"}/;
    public const exitGameSignal:Signal = new Signal();
    private const waiter:SignalWaiter = new SignalWaiter();

    public var owner_:Portal;
    private var nameText_:TextFieldDisplayConcrete;
    private var enterButton_:DeprecatedTextButton;
    private var fullText_:TextFieldDisplayConcrete;

    public function PortalPanel(_arg_1:GameSprite, _arg_2:Portal) {
        super(_arg_1);
        this.owner_ = _arg_2;
        this.nameText_ = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setBold(true).setTextWidth(WIDTH).setHorizontalAlign(TextFormatAlign.CENTER);
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.nameText_);
        this.waiter.push(this.nameText_.textChanged);
        this.enterButton_ = new DeprecatedTextButton(16, TextKey.PANEL_ENTER);
        addChild(this.enterButton_);
        this.waiter.push(this.enterButton_.textChanged);
        this.fullText_ = new TextFieldDisplayConcrete().setSize(18).setColor(0xFF0000).setHTML(true).setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
        var _local_3:String = ((this.owner_.lockedPortal_) ? TextKey.PORTAL_PANEL_LOCKED : TextKey.PORTAL_PANEL_FULL);
        this.fullText_.setStringBuilder(new LineBuilder().setParams(_local_3).setPrefix('<p align="center">').setPostfix("</p>"));
        this.fullText_.filters = [new DropShadowFilter(0, 0, 0)];
        this.fullText_.textChanged.addOnce(this.alignUI);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.waiter.complete.addOnce(this.alignUI);
    }

    private function alignUI():void {
        this.nameText_.y = 6;
        this.enterButton_.x = ((WIDTH / 2) - (this.enterButton_.width / 2));
        this.enterButton_.y = ((HEIGHT - this.enterButton_.height) - 4);
        this.fullText_.y = (HEIGHT - 30);
        this.fullText_.x = (WIDTH / 2);
    }

    private function onAddedToStage(_arg_1:Event):void {
        this.enterButton_.addEventListener(MouseEvent.CLICK, this.onEnterSpriteClick);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onEnterSpriteClick(_arg_1:MouseEvent):void {
        this.enterPortal();
    }

    private function onKeyDown(_arg_1:KeyboardEvent):void {
        if ((((_arg_1.keyCode == Parameters.data_.interact)) && ((stage.focus == null)))) {
            this.enterPortal();
        }
    }

    private function enterPortal():void {
        var _local_1:String = ObjectLibrary.typeToDisplayId_[this.owner_.objectType_];
        doneAction(gs_, Tutorial.ENTER_PORTAL_ACTION);
        gs_.gsc_.usePortal(this.owner_.objectId_);
        this.exitGameSignal.dispatch();
    }

    override public function draw():void {
        this.updateNameText();
        if (((((!(this.owner_.lockedPortal_)) && (this.owner_.active_))) && (contains(this.fullText_)))) {
            removeChild(this.fullText_);
            addChild(this.enterButton_);
        }
        else {
            if (((((this.owner_.lockedPortal_) || (!(this.owner_.active_)))) && (contains(this.enterButton_)))) {
                removeChild(this.enterButton_);
                addChild(this.fullText_);
            }
        }
    }

    private function updateNameText():void {
        var _local_1:String = this.getName();
        var _local_2:StringBuilder = new PortalNameParser().makeBuilder(_local_1);
        this.nameText_.setStringBuilder(_local_2);
        this.nameText_.x = ((WIDTH - this.nameText_.width) * 0.5);
        this.nameText_.y = (((this.nameText_.height > 30)) ? 0 : 6);
    }

    private function getName():String {
        var _local_1:String = this.owner_.getName();
        if (((this.owner_.lockedPortal_) && ((_local_1.indexOf(this.LOCKED) == 0)))) {
            return (_local_1.substr(this.LOCKED.length));
        }
        return (this.parseJson(_local_1));
    }

    private function parseJson(_arg_1:String):String {
        var _local_2:Array = _arg_1.match(this.TEXT_PATTERN);
        return (((_local_2) ? _local_2[1] : _arg_1));
    }


}
}//package com.company.assembleegameclient.ui.panels
