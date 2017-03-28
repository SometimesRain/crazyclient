package kabam.rotmg.game.view {
import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;
import kabam.rotmg.core.model.PlayerModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class CreditDisplayMediator extends Mediator {

    [Inject]
    public var view:CreditDisplay;
    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var openMoneyWindow:OpenMoneyWindowSignal;


    override public function initialize():void {
        this.model.creditsChanged.add(this.onCreditsChanged);
        this.model.fameChanged.add(this.onFameChanged);
        this.model.tokensChanged.add(this.onTokensChanged);
        this.view.openAccountDialog.add(this.onOpenAccountDialog);
    }

    override public function destroy():void {
        this.model.creditsChanged.remove(this.onCreditsChanged);
        this.model.fameChanged.remove(this.onFameChanged);
        this.view.openAccountDialog.remove(this.onOpenAccountDialog);
    }

    private function onCreditsChanged(_arg_1:int):void {
        this.view.draw(_arg_1, this.model.getFame());
    }

    private function onFameChanged(_arg_1:int):void {
        this.view.draw(this.model.getCredits(), _arg_1);
    }

    private function onTokensChanged(_arg_1:int):void {
        this.view.draw(this.model.getCredits(), this.model.getFame(), _arg_1);
    }

    private function onOpenAccountDialog():void {
        this.openMoneyWindow.dispatch();
    }


}
}//package kabam.rotmg.game.view
