package kabam.rotmg.account.steam.services {
import flash.display.DisplayObject;
import flash.display.LoaderInfo;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.steam.SteamApi;
import kabam.rotmg.account.steam.view.SteamSessionRequestErrorDialog;
import kabam.rotmg.core.view.Layers;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

import robotlegs.bender.framework.api.ILogger;

public class SteamLoadApiTask extends BaseTask {

    [Inject]
    public var info:LoaderInfo;
    [Inject]
    public var api:SteamApi;
    [Inject]
    public var layers:Layers;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var closeDialog:CloseDialogsSignal;
    [Inject]
    public var logger:ILogger;
    private var dialog:SteamSessionRequestErrorDialog;


    override protected function startTask():void {
        this.logger.debug("startTask");
        this.layers.api.addChild((this.api as DisplayObject));
        this.api.loaded.addOnce(this.requestSessionTicket);
        this.api.load(this.info.parameters.steam_api_path);
    }

    private function requestSessionTicket():void {
        this.logger.debug("requestSessionTicket");
        this.api.sessionReceived.addOnce(this.onSessionReceived);
        this.api.requestSessionTicket();
    }

    private function onSessionReceived(_arg_1:Boolean):void {
        this.logger.debug("session received - isValid? {0}", [_arg_1]);
        if (_arg_1) {
            completeTask(true);
        }
        else {
            this.showErrorDialog();
        }
    }

    private function showErrorDialog():void {
        this.dialog = ((this.dialog) || (new SteamSessionRequestErrorDialog()));
        this.dialog.ok.addOnce(this.onOK);
        this.openDialog.dispatch(this.dialog);
    }

    private function onOK():void {
        this.closeDialog.dispatch();
        this.requestSessionTicket();
    }


}
}//package kabam.rotmg.account.steam.services
