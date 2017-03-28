package kabam.rotmg.classes.model {
import kabam.rotmg.assets.model.CharacterTemplate;

import org.osflash.signals.Signal;

public class CharacterSkin {

    public const changed:Signal = new Signal(CharacterSkin);

    public var id:int = 0;
    public var name:String = "";
    public var unlockLevel:int;
    public var unlockSpecial:String;
    public var template:CharacterTemplate;
    public var cost:int;
    public var limited:Boolean = false;
    public var skinSelectEnabled:Boolean = true;
    public var is16x16:Boolean = false;
    private var state:CharacterSkinState;
    private var isSelected:Boolean;

    public function CharacterSkin() {
        this.state = CharacterSkinState.NULL;
        super();
    }

    public function getIsSelected():Boolean {
        return (this.isSelected);
    }

    public function setIsSelected(_arg_1:Boolean):void {
        if (this.isSelected != _arg_1) {
            this.isSelected = _arg_1;
            this.changed.dispatch(this);
        }
    }

    public function getState():CharacterSkinState {
        return (this.state);
    }

    public function setState(_arg_1:CharacterSkinState):void {
        if (this.state != _arg_1) {
            this.state = _arg_1;
            this.changed.dispatch(this);
        }
    }


}
}//package kabam.rotmg.classes.model
