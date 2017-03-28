package kabam.rotmg.ui.view {
import com.company.assembleegameclient.screens.LoadingScreen;

import kabam.rotmg.core.signals.SetLoadingMessageSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class LoadingMediator extends Mediator {

    [Inject]
    public var view:LoadingScreen;
    [Inject]
    public var setMessage:SetLoadingMessageSignal;


    override public function initialize():void {
        this.setMessage.add(this.onSetMessage);
        this.view.setTextKey("Loading.text");
    }

    override public function destroy():void {
        this.setMessage.remove(this.onSetMessage);
    }

    private function onSetMessage(_arg_1:String):void {
        this.view.setTextKey(_arg_1);
    }


}
}//package kabam.rotmg.ui.view
