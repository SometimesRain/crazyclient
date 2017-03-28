package kabam.rotmg.arena.view {
import kabam.lib.net.api.MessageProvider;
import kabam.lib.net.impl.SocketServer;
import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;
import kabam.rotmg.arena.model.CurrentArenaRunModel;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.external.command.RequestPlayerCreditsCompleteSignal;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.messaging.impl.outgoing.arena.EnterArena;
import kabam.rotmg.ui.model.HUDModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ContinueOrQuitMediator extends Mediator {

    [Inject]
    public var view:ContinueOrQuitDialog;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;
    [Inject]
    public var socketServer:SocketServer;
    [Inject]
    public var messages:MessageProvider;
    [Inject]
    public var hudModel:HUDModel;
    [Inject]
    public var currentRunModel:CurrentArenaRunModel;
    [Inject]
    public var gameModel:GameModel;
    [Inject]
    public var requestPlayerCreditsComplete:RequestPlayerCreditsCompleteSignal;
    [Inject]
    public var openMoneyWindow:OpenMoneyWindowSignal;


    override public function initialize():void {
        this.requestPlayerCreditsComplete.add(this.onRequestPlayerCreditsComplete);
        this.view.quit.add(this.onQuit);
        this.view.buyContinue.add(this.onContinue);
        this.view.init(this.currentRunModel.entry.currentWave, this.gameModel.player.credits_);
    }

    private function onRequestPlayerCreditsComplete():void {
        this.view.setProcessing(false);
    }

    override public function destroy():void {
        this.requestPlayerCreditsComplete.remove(this.onRequestPlayerCreditsComplete);
        this.view.quit.remove(this.onQuit);
        this.view.buyContinue.remove(this.onContinue);
        this.view.destroy();
    }

    private function onContinue(_arg_1:int, _arg_2:int):void {
        var _local_3:EnterArena;
        if (this.gameModel.player.credits_ >= _arg_2) {
            this.closeDialogs.dispatch();
            _local_3 = (this.messages.require(GameServerConnection.ENTER_ARENA) as EnterArena);
            _local_3.currency = _arg_1;
            this.socketServer.sendMessage(_local_3);
        }
        else {
            this.view.setProcessing(true);
            this.openMoneyWindow.dispatch();
        }
    }

    private function onQuit():void {
        this.closeDialogs.dispatch();
        this.hudModel.gameSprite.gsc_.escape();
    }


}
}//package kabam.rotmg.arena.view
