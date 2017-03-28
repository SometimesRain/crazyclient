package kabam.rotmg.characters.reskin.view {
import kabam.rotmg.characters.reskin.control.OpenReskinDialogSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ReskinPanelMediator extends Mediator {

    [Inject]
    public var view:ReskinPanel;
    [Inject]
    public var openReskinDialog:OpenReskinDialogSignal;


    override public function initialize():void {
        this.view.reskin.add(this.onReskin);
    }

    override public function destroy():void {
        this.view.reskin.remove(this.onReskin);
    }

    private function onReskin():void {
        this.openReskinDialog.dispatch();
    }


}
}//package kabam.rotmg.characters.reskin.view
