package kabam.rotmg.classes.control {
import kabam.lib.tasks.TaskMonitor;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.CharacterSkinState;
import kabam.rotmg.classes.services.BuySkinTask;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.ui.view.NotEnoughGoldDialog;

public class BuyCharacterSkinCommand {

    [Inject]
    public var skin:CharacterSkin;
    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var task:BuySkinTask;
    [Inject]
    public var monitor:TaskMonitor;
    [Inject]
    public var openDialog:OpenDialogSignal;


    public function execute():void {
        if (this.isSkinPurchasable()) {
            this.enterPurchaseFlow();
        }
    }

    private function enterPurchaseFlow():void {
        if (this.isSkinAffordable()) {
            this.purchaseSkin();
        }
        else {
            this.enterGetCreditsFlow();
        }
    }

    private function isSkinPurchasable():Boolean {
        return ((this.skin.getState() == CharacterSkinState.PURCHASABLE));
    }

    private function isSkinAffordable():Boolean {
        return ((this.model.getCredits() >= this.skin.cost));
    }

    private function purchaseSkin():void {
        this.monitor.add(this.task);
        this.task.start();
    }

    private function enterGetCreditsFlow():void {
        this.openDialog.dispatch(new NotEnoughGoldDialog());
    }


}
}//package kabam.rotmg.classes.control
