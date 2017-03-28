package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.BitmapData;

import kabam.rotmg.text.model.TextKey;

public class ClosedVaultChest extends SellableObject {

    public function ClosedVaultChest(_arg_1:XML) {
        super(_arg_1);
    }

    override public function soldObjectName():String {
        return (TextKey.VAULT_CHEST);
    }

    override public function soldObjectInternalName():String {
        return ("Vault Chest");
    }

    override public function getTooltip():ToolTip {
        return (new TextToolTip(0x363636, 0x9B9B9B, this.soldObjectName(), TextKey.VAULT_CHEST_DESCRIPTION, 200));
    }

    override public function getSellableType():int {
        return (ObjectLibrary.idToType_["Vault Chest"]);
    }

    override public function getIcon():BitmapData {
        return (ObjectLibrary.getRedrawnTextureFromType(ObjectLibrary.idToType_["Vault Chest"], 80, true));
    }


}
}//package com.company.assembleegameclient.objects
