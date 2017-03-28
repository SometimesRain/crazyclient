package kabam.rotmg.game.view.components {
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;

import flash.display.Sprite;

import kabam.rotmg.ui.model.TabStripModel;
import kabam.rotmg.ui.view.PotionInventoryView;

public class InventoryTabContent extends Sprite {

    private var storageContent:Sprite;
    private var storage:InventoryGrid;
    private var potionsInventory:PotionInventoryView;

    public function InventoryTabContent(_arg_1:Player) {
        this.storageContent = new Sprite();
        this.potionsInventory = new PotionInventoryView();
        super();
        this.init(_arg_1);
        this.addChildren();
        this.positionChildren();
    }

    private function init(_arg_1:Player):void {
        this.storage = new InventoryGrid(_arg_1, _arg_1, 4);
        this.storageContent.name = TabStripModel.MAIN_INVENTORY;
    }

    private function addChildren():void {
        this.storageContent.addChild(this.storage);
        this.storageContent.addChild(this.potionsInventory);
        addChild(this.storageContent);
    }

    private function positionChildren():void {
        this.storageContent.x = 7;
        this.storageContent.y = 7;
        this.potionsInventory.y = (this.storage.height + 4);
    }


}
}//package kabam.rotmg.game.view.components
