package kabam.rotmg.maploading.commands {
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.assets.model.Animation;
import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.core.model.PlayerModel;

public class CharacterAnimationFactory {

    [Inject]
    public var playerModel:PlayerModel;
    [Inject]
    public var factory:CharacterFactory;
    [Inject]
    public var classesModel:ClassesModel;
    private var currentChar:SavedCharacter;
    private var characterClass:CharacterClass;
    private var skin:CharacterSkin;
    private var tex2:int;
    private var tex1:int;


    public function make():Animation {
        this.currentChar = this.playerModel.getCharacterById(this.playerModel.currentCharId);
        this.characterClass = ((this.currentChar) ? this.getCurrentCharacterClass() : this.getDefaultCharacterClass());
        this.skin = this.characterClass.skins.getSelectedSkin();
        this.tex1 = ((this.currentChar) ? this.currentChar.tex1() : 0);
        this.tex2 = ((this.currentChar) ? this.currentChar.tex2() : 0);
        var _local_1:int = (((Parameters.skinTypes16.indexOf(this.skin.id)) != -1) ? 70 : 100);
        return (this.factory.makeWalkingIcon(this.skin.template, _local_1, this.tex1, this.tex2));
    }

    private function getDefaultCharacterClass():CharacterClass {
        return (this.classesModel.getSelected());
    }

    private function getCurrentCharacterClass():CharacterClass {
        return (this.classesModel.getCharacterClass(this.currentChar.objectType()));
    }


}
}//package kabam.rotmg.maploading.commands
