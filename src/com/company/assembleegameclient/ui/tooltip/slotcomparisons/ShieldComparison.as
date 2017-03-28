package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class ShieldComparison extends SlotComparison {

    private var projectileComparison:GeneralProjectileComparison;

    public function ShieldComparison() {
        this.projectileComparison = new GeneralProjectileComparison();
        super();
    }

    override protected function compareSlots(_arg_1:XML, _arg_2:XML):void {
        var _local_3:String;
        this.projectileComparison.compare(_arg_1, _arg_2);
        comparisonStringBuilder = this.projectileComparison.comparisonStringBuilder;
        for (_local_3 in this.projectileComparison.processedTags) {
            processedTags[_local_3] = this.projectileComparison.processedTags[_local_3];
        }
        this.handleException(_arg_1);
    }

    private function handleException(itemXML:XML):void {
        var tag:XML;
        var innerLineBuilder:LineBuilder;
        if (itemXML.@id == "Shield of Ogmur") {
            tag = itemXML.ConditionEffect.(text() == "Armor Broken")[0];
            innerLineBuilder = new LineBuilder().setParams(TextKey.EFFECT_FOR_DURATION, {
                "effect": TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_ARMOR_BROKEN),
                "duration": tag.@duration
            }).setPrefix(TooltipHelper.getOpenTag(UNTIERED_COLOR)).setPostfix(TooltipHelper.getCloseTag());
            comparisonStringBuilder.pushParams(TextKey.PARTY_EFFECT, {"effect": innerLineBuilder});
            processedTags[tag.toXMLString()] = true;
        }
    }


}
}//package com.company.assembleegameclient.ui.tooltip.slotcomparisons
