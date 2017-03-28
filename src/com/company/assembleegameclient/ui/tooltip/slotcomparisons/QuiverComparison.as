package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;
import com.company.assembleegameclient.util.ConditionEffect;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class QuiverComparison extends SlotComparison {

    private var projectileComparison:GeneralProjectileComparison;
    private var condition:XMLList;
    private var otherCondition:XMLList;

    public function QuiverComparison() {
        this.projectileComparison = new GeneralProjectileComparison();
        super();
    }

    override protected function compareSlots(itemXML:XML, curItemXML:XML):void {
        var tagStr:String;
        var duration:Number;
        var conditionEffect:ConditionEffect;
        this.condition = itemXML.Projectile.ConditionEffect.(((((text() == "Slowed")) || ((text() == "Paralyzed")))) || ((text() == "Dazed")));
        this.otherCondition = curItemXML.Projectile.ConditionEffect.(((((text() == "Slowed")) || ((text() == "Paralyzed")))) || ((text() == "Dazed")));
        this.projectileComparison.compare(itemXML, curItemXML);
        comparisonStringBuilder = this.projectileComparison.comparisonStringBuilder;
        for (tagStr in this.projectileComparison.processedTags) {
            processedTags[tagStr] = true;
        }
        if ((((this.condition.length() == 1)) && ((this.otherCondition.length() == 1)))) {
            duration = Number(this.condition[0].@duration);
            conditionEffect = ConditionEffect.getConditionEffectEnumFromName(this.condition.text());
            comparisonStringBuilder.pushParams(TextKey.SHOT_EFFECT, {"effect": ""});
            comparisonStringBuilder.pushParams(TextKey.EFFECT_FOR_DURATION, {
                "effect": new LineBuilder().setParams(conditionEffect.localizationKey_),
                "duration": duration
            }, TooltipHelper.getOpenTag(NO_DIFF_COLOR), TooltipHelper.getCloseTag());
            processedTags[this.condition[0].toXMLString()] = true;
        }
    }


}
}//package com.company.assembleegameclient.ui.tooltip.slotcomparisons
