package kabam.rotmg.pets.view.dialogs {
import flash.display.Sprite;

import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.view.components.PetIcon;

public class PetItem extends Sprite implements Disableable {

    public static const TOP_LEFT:String = "topLeft";
    public static const TOP_RIGHT:String = "topRight";
    public static const BOTTOM_RIGHT:String = "bottomRight";
    public static const BOTTOM_LEFT:String = "bottomLeft";
    public static const REGULAR:String = "regular";
    private static const CUT_STATES:Array = [TOP_LEFT, TOP_RIGHT, BOTTOM_RIGHT, BOTTOM_LEFT];

    public var itemBackgroundFactory:ItemBackgroundFactory;
    private var petIcon:PetIcon;
    private var background:String;
    private var size:int;
    private var backgroundGraphic:PetItemBackground;

    public function PetItem() {
        this.itemBackgroundFactory = new ItemBackgroundFactory();
        super();
    }

    public function setPetIcon(_arg_1:PetIcon):void {
        this.petIcon = _arg_1;
        addChild(_arg_1);
    }

    public function disable():void {
        this.petIcon.disable();
    }

    public function isEnabled():Boolean {
        return (this.petIcon.isEnabled());
    }

    public function setSize(_arg_1:int):void {
        this.size = _arg_1;
    }

    public function setBackground(_arg_1:String):void {
        this.background = _arg_1;
        if (this.backgroundGraphic) {
            removeChild(this.backgroundGraphic);
        }
        this.backgroundGraphic = PetItemBackground(this.itemBackgroundFactory.create(this.size, this.getCuts()));
        addChildAt(this.backgroundGraphic, 0);
    }

    private function getCuts():Array {
        var _local_1:Array = [0, 0, 0, 0];
        if (this.background != REGULAR) {
            _local_1[CUT_STATES.indexOf(this.background)] = 1;
        }
        return (_local_1);
    }

    public function getBackground():String {
        return (this.background);
    }

    public function getPetVO():PetVO {
        return (this.petIcon.getPetVO());
    }


}
}//package kabam.rotmg.pets.view.dialogs
