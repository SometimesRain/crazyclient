package kabam.rotmg.characters.reskin.control {
import com.company.assembleegameclient.objects.Player;

import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.messaging.impl.outgoing.Reskin;

public class ReskinHandler {

    [Inject]
    public var model:GameModel;
    [Inject]
    public var classes:ClassesModel;
    [Inject]
    public var factory:CharacterFactory;


    public function execute(_arg_1:Reskin):void {
        var _local_2:Player;
        var _local_3:int;
        var _local_4:CharacterClass;
        _local_2 = ((_arg_1.player) || (this.model.player));
        _local_3 = _arg_1.skinID;
        _local_4 = this.classes.getCharacterClass(_local_2.objectType_);
        var _local_5:CharacterSkin = _local_4.skins.getSkin(_local_3);
        _local_2.skinId = _local_3;
        _local_2.skin = this.factory.makeCharacter(_local_5.template);
        _local_2.isDefaultAnimatedChar = false;
    }


}
}//package kabam.rotmg.characters.reskin.control
