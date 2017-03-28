package kabam.rotmg.characters.model {
import com.company.assembleegameclient.appengine.SavedCharacter;

public interface CharacterModel {

    function getCharacterCount():int;

    function getCharacter(_arg_1:int):SavedCharacter;

    function deleteCharacter(_arg_1:int):void;

    function select(_arg_1:SavedCharacter):void;

    function getSelected():SavedCharacter;

}
}//package kabam.rotmg.characters.model
