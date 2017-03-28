package kabam.rotmg.ui.view {
import com.company.assembleegameclient.mapeditor.MapEditor;
import com.company.assembleegameclient.ui.dialogs.ConfirmDialog;

import flash.events.MouseEvent;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.game.signals.GameClosedSignal;
import kabam.rotmg.servers.api.ServerModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class MapEditorMediator extends Mediator {

    [Inject]
    public var view:MapEditor;
    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var servers:ServerModel;
    [Inject]
    public var gameClosed:GameClosedSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;


    override public function initialize():void {
        this.view.initialize(this.model, this.servers.getServer());
        this.view.editingScreen_.returnButton_.addEventListener(MouseEvent.CLICK, this.onReturnPhase1);
    }

    override public function destroy():void
    {
        this.view.editingScreen_.returnButton_.removeEventListener(MouseEvent.CLICK, this.onReturnPhase1);
    }

    private function onReturnPhase1(_arg_1:MouseEvent):void
    {
        var _local_2:ConfirmDialog = new ConfirmDialog("Go Back", "Are you sure you want to return to the title screen? This will erase your map data.", this.onReturn);
        this.openDialog.dispatch(_local_2);
    }

    private function onReturn():void
    {
        this.gameClosed.dispatch();
    }


}
}//package kabam.rotmg.ui.view
