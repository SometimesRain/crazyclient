package kabam.rotmg.pets.view.dialogs.evolving {
import flash.display.DisplayObject;
import flash.display.Sprite;

import kabam.rotmg.assets.EmbeddedAssets;
import kabam.rotmg.messaging.impl.EvolvePetInfo;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.view.components.PetIcon;
import kabam.rotmg.pets.view.components.PetIconFactory;

import org.swiftsuspenders.Injector;

public class EvolveAnimation extends Sprite {

    public const background:DisplayObject = new EmbeddedAssets.EvolveBackground();
    public const backgroundMask:DisplayObject = new EmbeddedAssets.EvolveBackground();

    [Inject]
    public var petIconFactory:PetIconFactory;
    [Inject]
    public var injector:Injector;
    [Inject]
    public var transition:EvolveTransition;
    public var initialPet:PetIcon;
    public var evolvedPet:EvolvedPet;
    private var evolvePetInfo:EvolvePetInfo;

    public function EvolveAnimation() {
        addChild(this.background);
        addChild(this.backgroundMask);
    }

    public function setEvolvedPets(_arg_1:EvolvePetInfo):void {
        this.petIconFactory.outlineSize = 6;
        this.evolvePetInfo = _arg_1;
        this.addInitialPet(_arg_1.initialPet);
        this.makeEvolvedPet(_arg_1.finalPet);
        addChild(this.transition);
        this.transition.opaqueReached.addOnce(this.onOpaque);
        this.transition.play();
    }

    public function getPetInfo():EvolvePetInfo {
        return (this.evolvePetInfo);
    }

    private function makeEvolvedPet(_arg_1:PetVO):void {
        this.evolvedPet = this.injector.getInstance(EvolvedPet);
        this.evolvedPet.setPet(_arg_1);
        this.evolvedPet.mask = this.backgroundMask;
        this.evolvedPet.x = (this.background.width / 2);
        this.evolvedPet.y = (this.background.height / 2);
    }

    private function addInitialPet(_arg_1:PetVO):void {
        this.initialPet = this.petIconFactory.create(_arg_1, 100);
        this.initialPet.x = ((this.background.width - this.initialPet.width) / 2);
        this.initialPet.y = ((this.background.height - this.initialPet.height) / 2);
        addChild(this.initialPet);
    }

    private function onOpaque():void {
        removeChild(this.initialPet);
        addChildAt(this.evolvedPet, getChildIndex(this.transition));
    }


}
}//package kabam.rotmg.pets.view.dialogs.evolving
