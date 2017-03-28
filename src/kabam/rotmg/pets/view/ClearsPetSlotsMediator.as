package kabam.rotmg.pets.view {
import kabam.rotmg.maploading.signals.ChangeMapSignal;
import kabam.rotmg.pets.data.PetSlotsState;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ClearsPetSlotsMediator extends Mediator {

    [Inject]
    public var petSlotsState:PetSlotsState;
    [Inject]
    public var changeMapSignal:ChangeMapSignal;


    override public function initialize():void {
        this.changeMapSignal.add(this.onMapChange);
    }

    override public function destroy():void {
        this.changeMapSignal.remove(this.onMapChange);
    }

    private function onMapChange():void {
        this.petSlotsState.clear();
    }


}
}//package kabam.rotmg.pets.view
