package kabam.rotmg.game.model {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;

import flash.utils.Dictionary;

public class GameModel {

    public var player:Player;
    public var gameObjects:Dictionary;


    public function getGameObject(_arg_1:int):GameObject {
        var _local_2:GameObject = this.gameObjects[_arg_1];
        if (((!(_local_2)) && ((this.player.objectId_ == _arg_1)))) {
            _local_2 = this.player;
        }
        return (_local_2);
    }


}
}//package kabam.rotmg.game.model
