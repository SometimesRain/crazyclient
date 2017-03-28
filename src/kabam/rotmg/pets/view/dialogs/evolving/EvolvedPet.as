package kabam.rotmg.pets.view.dialogs.evolving {
import flash.display.DisplayObject;
import flash.display.Sprite;

import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.view.components.PetIconFactory;

import org.swiftsuspenders.Injector;

public class EvolvedPet extends Sprite {

    [Inject]
    public var petIconFactory:PetIconFactory;
    [Inject]
    public var injector:Injector;
    public var littleSpinner:Spinner;
    public var bigSpinner:Spinner;
    public var petIcon:DisplayObject;
    private var petVO:PetVO;


    public function setPet(_arg_1:PetVO):void {
        this.petIconFactory.outlineSize = 8;
        this.petVO = _arg_1;
        this.bigSpinner = this.addSpinner();
        this.littleSpinner = this.addSpinner();
        this.addPetIcon(_arg_1);
        this.configureSpinners();
    }

    public function getPet():PetVO {
        return (this.petVO);
    }

    private function addPetIcon(_arg_1:PetVO):void {
        this.petIcon = this.petIconFactory.create(_arg_1, 120);
        this.petIcon.x = ((-1 * this.petIcon.width) / 2);
        this.petIcon.y = ((-1 * this.petIcon.height) / 2);
        addChild(this.petIcon);
    }

    private function configureSpinners():void {
        this.bigSpinner.degreesPerSecond = 50;
        this.littleSpinner.degreesPerSecond = (this.bigSpinner.degreesPerSecond * 1.5);
        var _local_1:Number = 0.7;
        this.littleSpinner.width = (this.bigSpinner.width * _local_1);
        this.littleSpinner.height = (this.bigSpinner.height * _local_1);
        this.littleSpinner.alpha = (this.bigSpinner.alpha = 0.7);
    }

    private function addSpinner():Spinner {
        var _local_1:Spinner = this.injector.getInstance(Spinner);
        addChild(_local_1);
        return (_local_1);
    }


}
}//package kabam.rotmg.pets.view.dialogs.evolving
