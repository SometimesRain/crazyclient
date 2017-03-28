package kabam.rotmg.classes.view {
import kabam.rotmg.classes.control.BuyCharacterSkinSignal;
import kabam.rotmg.classes.control.FocusCharacterSkinSignal;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class CharacterSkinListItemMediator extends Mediator {

    [Inject]
    public var view:CharacterSkinListItem;
    [Inject]
    public var model:ClassesModel;
    [Inject]
    public var buyCharacterSkin:BuyCharacterSkinSignal;
    [Inject]
    public var focusCharacterSkin:FocusCharacterSkinSignal;


    override public function initialize():void {
        this.view.buy.add(this.onBuy);
        this.view.over.add(this.onOver);
        this.view.out.add(this.onOut);
        this.view.selected.add(this.onSelected);
    }

    override public function destroy():void {
        this.view.buy.remove(this.onBuy);
        this.view.over.remove(this.onOver);
        this.view.out.remove(this.onOut);
        this.view.selected.remove(this.onSelected);
        this.view.setModel(null);
    }

    private function onOver():void {
        this.focusCharacterSkin.dispatch(this.view.getModel());
    }

    private function onOut():void {
        this.focusCharacterSkin.dispatch(null);
    }

    private function onBuy():void {
        var _local_1:CharacterSkin = this.view.getModel();
        this.buyCharacterSkin.dispatch(_local_1);
    }

    private function onSelected(_arg_1:Boolean):void {
        this.view.getModel().setIsSelected(_arg_1);
    }


}
}//package kabam.rotmg.classes.view
