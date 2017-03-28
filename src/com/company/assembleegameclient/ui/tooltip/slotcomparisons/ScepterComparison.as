package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;

import kabam.rotmg.constants.*;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class ScepterComparison extends SlotComparison {


    override protected function compareSlots(itemXML:XML, curItemXML:XML):void {
        var result:XMLList;
        var otherResult:XMLList;
        var damage:int;
        var otherDamage:int;
        var textColor:uint;
        var targets:int;
        var otherTargets:int;
        var innerLineBuilder:LineBuilder;
        var condition:String;
        var duration:Number;
        var compositeStr:String;
        var htmlStr:String;
        result = itemXML.Activate.(text() == ActivationType.LIGHTNING);
        otherResult = curItemXML.Activate.(text() == ActivationType.LIGHTNING);
        comparisonStringBuilder = new AppendingLineBuilder();
        if ((((result.length() == 1)) && ((otherResult.length() == 1)))) {
            damage = int(result[0].@totalDamage);
            otherDamage = int(otherResult[0].@totalDamage);
            textColor = getTextColor((damage - otherDamage));
            targets = int(result[0].@maxTargets);
            otherTargets = int(otherResult[0].@maxTargets);
            innerLineBuilder = new LineBuilder().setParams(TextKey.DAMAGE_TO_TARGETS, {
                "damage": damage.toString(),
                "targets": targets.toString()
            }).setPrefix(TooltipHelper.getOpenTag(getTextColor((damage - otherDamage)))).setPostfix(TooltipHelper.getCloseTag());
            comparisonStringBuilder.pushParams(TextKey.LIGHTNING, {"data": innerLineBuilder});
            processedTags[result[0].toXMLString()] = true;
        }
        if (String(itemXML.Activate.@condEffect)) {
            condition = itemXML.Activate.@condEffect;
            duration = Number(itemXML.Activate.@condDuration);
            compositeStr = ((((" " + condition) + " for ") + duration) + " secs\n");
            htmlStr = ("Shot Effect:\n" + wrapInColoredFont(compositeStr, NO_DIFF_COLOR));
            comparisonStringBuilder.pushParams(TextKey.SHOT_EFFECT, {"effect": ""});
            comparisonStringBuilder.pushParams(TextKey.EFFECT_FOR_DURATION, {
                "effect": condition,
                "duration": duration.toString()
            }, TooltipHelper.getOpenTag(NO_DIFF_COLOR), TooltipHelper.getCloseTag());
        }
    }


}
}//package com.company.assembleegameclient.ui.tooltip.slotcomparisons
