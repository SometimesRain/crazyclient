package com.company.assembleegameclient.ui.guild {
import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.game.events.GuildResultEvent;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.ui.dialogs.Dialog;
import com.company.rotmg.graphics.ScreenGraphic;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class GuildChronicleScreen extends Sprite {

    private var gs_:AGameSprite;
    private var container:Sprite;
    private var guildPlayerList_:GuildPlayerList;
    private var continueButton_:TitleMenuOption;

    public function GuildChronicleScreen(_arg_1:AGameSprite) {
        this.gs_ = _arg_1;
        graphics.clear();
        graphics.beginFill(0x2B2B2B, 0.8);
        graphics.drawRect(0, 0, 800, 600);
        graphics.endFill();
        addChild((this.container = new Sprite()));
        this.addList();
        addChild(new ScreenGraphic());
        this.continueButton_ = new TitleMenuOption(TextKey.OPTIONS_CONTINUE_BUTTON, 36, false);
        this.continueButton_.setAutoSize(TextFieldAutoSize.CENTER);
        this.continueButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.continueButton_.addEventListener(MouseEvent.CLICK, this.onContinueClick);
        addChild(this.continueButton_);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function addList():void {
        if (this.guildPlayerList_ && this.guildPlayerList_.parent) {
            this.container.removeChild(this.guildPlayerList_);
        }
        var _local_1:Player = this.gs_.map.player_;
        this.guildPlayerList_ = new GuildPlayerList(50, 0, (((_local_1 == null)) ? "" : _local_1.name_), _local_1.guildRank_);
        this.guildPlayerList_.addEventListener(GuildPlayerListEvent.SET_RANK, this.onSetRank);
        this.guildPlayerList_.addEventListener(GuildPlayerListEvent.REMOVE_MEMBER, this.onRemoveMember);
        this.container.addChild(this.guildPlayerList_);
    }

    private function removeList():void {
        this.guildPlayerList_.removeEventListener(GuildPlayerListEvent.SET_RANK, this.onSetRank);
        this.guildPlayerList_.removeEventListener(GuildPlayerListEvent.REMOVE_MEMBER, this.onRemoveMember);
        this.container.removeChild(this.guildPlayerList_);
        this.guildPlayerList_ = null;
    }

    private function onSetRank(_arg_1:GuildPlayerListEvent):void {
        this.removeList();
        this.gs_.addEventListener(GuildResultEvent.EVENT, this.onSetRankResult);
        this.gs_.gsc_.changeGuildRank(_arg_1.name_, _arg_1.rank_);
    }

    private function onSetRankResult(_arg_1:GuildResultEvent):void {
        this.gs_.removeEventListener(GuildResultEvent.EVENT, this.onSetRankResult);
        if (!_arg_1.success_) {
            this.showError(_arg_1.errorKey);
        }
        else {
            this.addList();
        }
    }

    private function onRemoveMember(_arg_1:GuildPlayerListEvent):void {
        this.removeList();
        this.gs_.addEventListener(GuildResultEvent.EVENT, this.onRemoveResult);
        this.gs_.gsc_.guildRemove(_arg_1.name_);
    }

    private function onRemoveResult(_arg_1:GuildResultEvent):void {
        this.gs_.removeEventListener(GuildResultEvent.EVENT, this.onRemoveResult);
        if (!_arg_1.success_) {
            this.showError(_arg_1.errorKey);
        }
        else {
            this.addList();
        }
    }

    private function showError(_arg_1:String):void {
        var _local_2:Dialog = new Dialog(TextKey.GUILD_CHRONICLE_LEFT, _arg_1, TextKey.GUILD_CHRONICLE_RIGHT, null, "/guildError");
        _local_2.addEventListener(Dialog.LEFT_BUTTON, this.onErrorTextDone);
        stage.addChild(_local_2);
    }

    private function onErrorTextDone(_arg_1:Event):void {
        var _local_2:Dialog = (_arg_1.currentTarget as Dialog);
        stage.removeChild(_local_2);
        this.addList();
    }

    private function onContinueClick(_arg_1:MouseEvent):void {
        this.close();
    }

    private function onAddedToStage(_arg_1:Event):void {
        this.continueButton_.x = 400;
        this.continueButton_.y = 550;
        stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false, 1);
        stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp, false, 1);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false);
        stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp, false);
    }

    private function onKeyDown(_arg_1:KeyboardEvent):void {
        _arg_1.stopImmediatePropagation();
    }

    private function onKeyUp(_arg_1:KeyboardEvent):void {
        _arg_1.stopImmediatePropagation();
    }

    private function close():void {
        stage.focus = null;
        parent.removeChild(this);
    }


}
}//package com.company.assembleegameclient.ui.guild
