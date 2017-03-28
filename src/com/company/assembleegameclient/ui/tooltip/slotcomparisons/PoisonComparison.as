package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class PoisonComparison extends SlotComparison {


    override protected function compareSlots(itemXML:XML, curItemXML:XML):void {
        var activate:XMLList;
        var otherActivate:XMLList;
        var damage:int;
        var otherDamage:int;
        var radius:Number;
        var otherRadius:Number;
        var duration:Number;
        var otherDuration:Number;
        var avg:Number;
        var otherAvg:Number;
        var dataLineBuilder:LineBuilder;
        activate = itemXML.Activate.(text() == "PoisonGrenade");
        otherActivate = curItemXML.Activate.(text() == "PoisonGrenade");
        comparisonStringBuilder = new AppendingLineBuilder();
        if ((((activate.length() == 1)) && ((otherActivate.length() == 1)))) {
            damage = int(activate[0].@totalDamage);
            otherDamage = int(otherActivate[0].@totalDamage);
            radius = Number(activate[0].@radius);
            otherRadius = Number(otherActivate[0].@radius);
            duration = Number(activate[0].@duration);
            otherDuration = Number(otherActivate[0].@duration);
            avg = (((0.33 * damage) + (0.33 * radius)) + (0.33 * duration));
            otherAvg = (((0.33 * otherDamage) + (0.33 * otherRadius)) + (0.33 * otherDuration));
            dataLineBuilder = new LineBuilder().setParams(TextKey.POISON_GRENADE_DATA, {
                "damage": damage.toString(),
                "duration": duration.toString(),
                "radius": radius.toString()
            }).setPrefix(TooltipHelper.getOpenTag(getTextColor((avg - otherAvg)))).setPostfix(TooltipHelper.getCloseTag());
            comparisonStringBuilder.pushParams(TextKey.POISON_GRENADE, {"data": dataLineBuilder});
            processedTags[activate[0].toXMLString()] = true;
        }
    }


}
}//package com.company.assembleegameclient.ui.tooltip.slotcomparisons
