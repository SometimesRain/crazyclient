package kabam.rotmg.minimap.model {

public class UpdateLootBagVO {

    public var tileX:int;
    public var tileY:int;
    public var objectId:int;
    public var remove:Boolean;

    public function UpdateLootBagVO(x:int, y:int, objectId_:int, remove_:Boolean) {
        this.tileX = x;
        this.tileY = y;
        this.objectId = objectId_;
        this.remove = remove_;
    }

}
}//package kabam.rotmg.ui.model
