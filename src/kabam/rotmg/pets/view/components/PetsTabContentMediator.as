package kabam.rotmg.pets.view.components {
import kabam.rotmg.pets.data.PetsModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PetsTabContentMediator extends Mediator {

    [Inject]
    public var view:PetsTabContentView;
    [Inject]
    public var model:PetsModel;


    override public function initialize():void {
        this.view.init(this.model.getActivePet());
    }

    override public function destroy():void {
    }


}
}//package kabam.rotmg.pets.view.components
