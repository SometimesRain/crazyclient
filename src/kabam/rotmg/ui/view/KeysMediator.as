package kabam.rotmg.ui.view {
import kabam.rotmg.game.signals.GameClosedSignal;
import kabam.rotmg.ui.model.Key;
import kabam.rotmg.ui.signals.HideKeySignal;
import kabam.rotmg.ui.signals.ShowKeySignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class KeysMediator extends Mediator {

    [Inject]
    public var view:KeysView;
    [Inject]
    public var showKey:ShowKeySignal;
    [Inject]
    public var hideKey:HideKeySignal;
    [Inject]
    public var gameClosed:GameClosedSignal;


    override public function initialize():void {
        this.showKey.add(this.onShowKey);
        this.hideKey.add(this.onHideKey);
        this.gameClosed.add(this.onGameClosed);
    }

    override public function destroy():void {
        this.showKey.remove(this.onShowKey);
        this.hideKey.remove(this.onHideKey);
        this.gameClosed.remove(this.onGameClosed);
    }

    private function onShowKey(_arg_1:Key):void {
        this.view.showKey(_arg_1);
    }

    private function onHideKey(_arg_1:Key):void {
        this.view.hideKey(_arg_1);
    }

    private function onGameClosed():void {
        this.view.parent.removeChild(this.view);
    }


}
}//package kabam.rotmg.ui.view
