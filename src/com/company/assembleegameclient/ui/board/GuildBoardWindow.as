package com.company.assembleegameclient.ui.board {
import com.company.assembleegameclient.ui.dialogs.Dialog;
import com.company.util.MoreObjectUtil;

import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.StaticInjectorContext;

public class GuildBoardWindow extends Sprite {

    private var canEdit_:Boolean;
    private var darkBox_:Shape;
    private var dialog_:Dialog;
    private var text_:String;
    private var viewBoard_:ViewBoard;
    private var editBoard_:EditBoard;
    private var client:AppEngineClient;

    public function GuildBoardWindow(_arg_1:Boolean) {
        this.canEdit_ = _arg_1;
        this.darkBox_ = new Shape();
        var _local_2:Graphics = this.darkBox_.graphics;
        _local_2.clear();
        _local_2.beginFill(0, 0.8);
        _local_2.drawRect(0, 0, 800, 600);
        _local_2.endFill();
        addChild(this.darkBox_);
        this.load();
    }

    private function load():void {
        var _local_1:Account = StaticInjectorContext.getInjector().getInstance(Account);
        this.client = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
        this.client.complete.addOnce(this.onGetBoardComplete);
        this.client.sendRequest("/guild/getBoard", _local_1.getCredentials());
        this.dialog_ = new Dialog(null, "Loading...", null, null, null);
        addChild(this.dialog_);
        this.darkBox_.visible = false;
    }

    private function onGetBoardComplete(_arg_1:Boolean, _arg_2:*):void {
        if (_arg_1) {
            this.showGuildBoard(_arg_2);
        }
        else {
            this.reportError(_arg_2);
        }
    }

    private function showGuildBoard(_arg_1:String):void {
        this.darkBox_.visible = true;
        removeChild(this.dialog_);
        this.dialog_ = null;
        this.text_ = _arg_1;
        this.show();
    }

    private function show():void {
        this.viewBoard_ = new ViewBoard(this.text_, this.canEdit_);
        this.viewBoard_.addEventListener(Event.COMPLETE, this.onViewComplete);
        this.viewBoard_.addEventListener(Event.CHANGE, this.onViewChange);
        addChild(this.viewBoard_);
    }

    private function reportError(_arg_1:String):void {
    }

    private function onViewComplete(_arg_1:Event):void {
        parent.removeChild(this);
    }

    private function onViewChange(_arg_1:Event):void {
        removeChild(this.viewBoard_);
        this.viewBoard_ = null;
        this.editBoard_ = new EditBoard(this.text_);
        this.editBoard_.addEventListener(Event.CANCEL, this.onEditCancel);
        this.editBoard_.addEventListener(Event.COMPLETE, this.onEditComplete);
        addChild(this.editBoard_);
    }

    private function onEditCancel(_arg_1:Event):void {
        removeChild(this.editBoard_);
        this.editBoard_ = null;
        this.show();
    }

    private function onEditComplete(_arg_1:Event):void {
        var _local_2:Account = StaticInjectorContext.getInjector().getInstance(Account);
        var _local_3:Object = {"board": this.editBoard_.getText()};
        MoreObjectUtil.addToObject(_local_3, _local_2.getCredentials());
        this.client = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
        this.client.complete.addOnce(this.onSetBoardComplete);
        this.client.sendRequest("/guild/setBoard", _local_3);
        removeChild(this.editBoard_);
        this.editBoard_ = null;
        this.dialog_ = new Dialog(null, "Saving...", null, null, null);
        addChild(this.dialog_);
        this.darkBox_.visible = false;
    }

    private function onSetBoardComplete(_arg_1:Boolean, _arg_2:*):void {
        if (_arg_1) {
            this.onSaveDone(_arg_2);
        }
        else {
            this.onSaveError(_arg_2);
        }
    }

    private function onSaveDone(_arg_1:String):void {
        this.darkBox_.visible = true;
        removeChild(this.dialog_);
        this.dialog_ = null;
        this.text_ = _arg_1;
        this.show();
    }

    private function onSaveError(_arg_1:String):void {
    }


}
}//package com.company.assembleegameclient.ui.board
