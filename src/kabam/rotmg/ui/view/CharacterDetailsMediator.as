package kabam.rotmg.ui.view {
import com.company.assembleegameclient.objects.Player;

import kabam.rotmg.ui.model.HUDModel;
import kabam.rotmg.ui.signals.HUDModelInitialized;
import kabam.rotmg.ui.signals.NameChangedSignal;
import kabam.rotmg.ui.signals.UpdateHUDSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class CharacterDetailsMediator extends Mediator {

    [Inject]
    public var view:CharacterDetailsView;
    [Inject]
    public var hudModel:HUDModel;
    [Inject]
    public var initHUDModelSignal:HUDModelInitialized;
    [Inject]
    public var updateHUD:UpdateHUDSignal;
    [Inject]
    public var nameChanged:NameChangedSignal;


    override public function initialize():void {
        this.view.init(this.hudModel.getPlayerName(), this.hudModel.getButtonType());
        this.updateHUD.addOnce(this.onUpdateHUD);
        this.nameChanged.add(this.onNameChange);
    }

    override public function destroy():void {
        this.nameChanged.remove(this.onNameChange);
    }

    private function onUpdateHUD(_arg_1:Player):void {
        this.view.update(_arg_1);
    }

    private function onNameChange(_arg_1:String):void {
        this.view.setName(_arg_1);
    }


}
}//package kabam.rotmg.ui.view
