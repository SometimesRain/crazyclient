package kabam.rotmg.ui.view {
import com.company.assembleegameclient.screens.GraveyardLine;

import kabam.rotmg.fame.control.ShowFameViewSignal;
import kabam.rotmg.fame.model.SimpleFameVO;

import robotlegs.bender.bundles.mvcs.Mediator;

public class NewsLineMediator extends Mediator {

    [Inject]
    public var view:GraveyardLine;
    [Inject]
    public var showFameView:ShowFameViewSignal;


    override public function initialize():void {
        this.view.viewCharacterFame.add(this.onViewFame);
    }

    override public function destroy():void {
        this.view.viewCharacterFame.remove(this.onViewFame);
    }

    private function onViewFame(_arg_1:int):void {
        this.showFameView.dispatch(new SimpleFameVO(this.view.accountId, _arg_1));
    }


}
}//package kabam.rotmg.ui.view
