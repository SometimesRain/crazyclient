package kabam.rotmg.game.view.components {
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;

import flash.display.Sprite;

import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.ui.model.TabStripModel;
import kabam.rotmg.ui.view.PotionInventoryView;

public class BackpackTabContent extends Sprite {

    private var backpackContent:Sprite;
    private var backpack:InventoryGrid;
    private var backpackPotionsInventory:PotionInventoryView;

    public function BackpackTabContent(_arg_1:Player) {
        this.backpackContent = new Sprite();
        this.backpackPotionsInventory = new PotionInventoryView();
        super();
        this.init(_arg_1);
        this.addChildren();
        this.positionChildren();
    }

    private function init(_arg_1:Player):void {
        this.backpackContent.name = TabStripModel.BACKPACK;
        this.backpack = new InventoryGrid(_arg_1, _arg_1, (GeneralConstants.NUM_EQUIPMENT_SLOTS + GeneralConstants.NUM_INVENTORY_SLOTS), true);
    }

    private function positionChildren():void {
        this.backpackContent.x = 7;
        this.backpackContent.y = 7;
        this.backpackPotionsInventory.y = (this.backpack.height + 4);
    }

    private function addChildren():void {
        this.backpackContent.addChild(this.backpack);
        this.backpackContent.addChild(this.backpackPotionsInventory);
        addChild(this.backpackContent);
    }


}
}//package kabam.rotmg.game.view.components
