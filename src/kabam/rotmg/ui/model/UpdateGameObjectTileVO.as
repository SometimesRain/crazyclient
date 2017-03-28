package kabam.rotmg.ui.model {
import com.company.assembleegameclient.objects.GameObject;

public class UpdateGameObjectTileVO {

    public var tileX:int;
    public var tileY:int;
    public var gameObject:GameObject;

    public function UpdateGameObjectTileVO(_arg_1:int, _arg_2:int, _arg_3:GameObject) {
        this.tileX = _arg_1;
        this.tileY = _arg_2;
        this.gameObject = _arg_3;
    }

}
}//package kabam.rotmg.ui.model
