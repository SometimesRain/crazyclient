package com.company.assembleegameclient.ui.panels.mediators {
import com.company.assembleegameclient.account.ui.CreateGuildFrame;
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.dialogs.Dialog;
import com.company.assembleegameclient.ui.panels.GuildRegisterPanel;

import flash.events.Event;

import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.ui.model.HUDModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class GuildRegisterPanelMediator extends Mediator {

    [Inject]
    public var view:GuildRegisterPanel;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var closeDialog:CloseDialogsSignal;
    [Inject]
    public var hudModel:HUDModel;


    override public function initialize():void {
        this.view.openCreateGuildFrame.add(this.onDispatchCreateGuildFrame);
        this.view.renounce.add(this.onRenounceClick);
    }

    override public function destroy():void {
        this.view.openCreateGuildFrame.remove(this.onDispatchCreateGuildFrame);
        this.view.renounce.remove(this.onRenounceClick);
    }

    private function onDispatchCreateGuildFrame():void {
        this.openDialog.dispatch(new CreateGuildFrame(this.hudModel.gameSprite));
    }

    public function onRenounceClick():void {
        var _local_1:GameSprite = this.hudModel.gameSprite;
        if ((((_local_1.map == null)) || ((_local_1.map.player_ == null)))) {
            return;
        }
        var _local_2:Player = _local_1.map.player_;
        var _local_3:Dialog = new Dialog(TextKey.RENOUNCE_DIALOG_SUBTITLE, TextKey.RENOUNCE_DIALOG_TITLE, TextKey.RENOUNCE_DIALOG_CANCEL, TextKey.RENOUNCE_DIALOG_ACCEPT, "/renounceGuild");
        _local_3.setTextParams(TextKey.RENOUNCE_DIALOG_TITLE, {"guildName": _local_2.guildName_});
        _local_3.addEventListener(Dialog.LEFT_BUTTON, this.onRenounce);
        _local_3.addEventListener(Dialog.RIGHT_BUTTON, this.onCancel);
        this.openDialog.dispatch(_local_3);
    }

    private function onCancel(_arg_1:Event):void {
        this.closeDialog.dispatch();
    }

    private function onRenounce(_arg_1:Event):void {
        var _local_2:GameSprite = this.hudModel.gameSprite;
        if ((((_local_2.map == null)) || ((_local_2.map.player_ == null)))) {
            return;
        }
        var _local_3:Player = _local_2.map.player_;
        _local_2.gsc_.guildRemove(_local_3.name_);
        this.closeDialog.dispatch();
    }


}
}//package com.company.assembleegameclient.ui.panels.mediators
