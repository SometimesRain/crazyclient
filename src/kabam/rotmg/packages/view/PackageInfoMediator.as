package kabam.rotmg.packages.view {
import kabam.rotmg.dialogs.control.CloseDialogsSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PackageInfoMediator extends Mediator {

    [Inject]
    public var view:PackageInfoDialog;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;


    override public function initialize():void {
        this.view.closed.add(this.onClosed);
    }

    override public function destroy():void {
        this.view.closed.remove(this.onClosed);
    }

    private function onClosed():void {
        this.closeDialogs.dispatch();
    }


}
}//package kabam.rotmg.packages.view
