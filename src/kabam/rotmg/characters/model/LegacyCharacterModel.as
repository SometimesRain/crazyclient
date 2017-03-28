package kabam.rotmg.characters.model {
import com.company.assembleegameclient.appengine.SavedCharacter;

import kabam.rotmg.core.model.PlayerModel;

public class LegacyCharacterModel implements CharacterModel {

    [Inject]
    public var wrapped:PlayerModel;
    private var selected:SavedCharacter;


    public function getCharacterCount():int {
        return (this.wrapped.getCharacterCount());
    }

    public function getCharacter(_arg_1:int):SavedCharacter {
        return (this.wrapped.getCharById(_arg_1));
    }

    public function deleteCharacter(_arg_1:int):void {
        this.wrapped.deleteCharacter(_arg_1);
        if (this.selected.charId() == _arg_1) {
            this.selected = null;
        }
    }

    public function select(_arg_1:SavedCharacter):void {
        this.selected = _arg_1;
    }

    public function getSelected():SavedCharacter {
        return (this.selected);
    }


}
}//package kabam.rotmg.characters.model
