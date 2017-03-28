package kabam.rotmg.classes.model {
import org.osflash.signals.Signal;

public class ClassesModel {

    public static const WIZARD_ID:int = 782;

    public const selected:Signal = new Signal(CharacterClass);
    private const map:Object = {};
    private const classes:Vector.<CharacterClass> = new Vector.<CharacterClass>(0);

    private var count:uint = 0;
    private var selectedChar:CharacterClass;


    public function getCount():uint {
        return (this.count);
    }

    public function getClassAtIndex(_arg_1:int):CharacterClass {
        return (this.classes[_arg_1]);
    }

    public function getCharacterClass(_arg_1:int):CharacterClass {
        return ((this.map[_arg_1] = ((this.map[_arg_1]) || (this.makeCharacterClass()))));
    }

    private function makeCharacterClass():CharacterClass {
        var _local_1:CharacterClass = new CharacterClass();
        _local_1.selected.add(this.onClassSelected);
        this.count = this.classes.push(_local_1);
        return (_local_1);
    }

    private function onClassSelected(_arg_1:CharacterClass):void {
        if (this.selectedChar != _arg_1) {
            ((this.selectedChar) && (this.selectedChar.setIsSelected(false)));
            this.selectedChar = _arg_1;
            this.selected.dispatch(_arg_1);
        }
    }

    public function getSelected():CharacterClass {
        return (((this.selectedChar) || (this.getCharacterClass(WIZARD_ID))));
    }

    public function getCharacterSkin(_arg_1:int):CharacterSkin {
        var _local_2:CharacterSkin;
        var _local_3:CharacterClass;
        for each (_local_3 in this.classes) {
            _local_2 = _local_3.skins.getSkin(_arg_1);
            if (_local_2 != _local_3.skins.getDefaultSkin()) break;
        }
        return (_local_2);
    }


}
}//package kabam.rotmg.classes.model
