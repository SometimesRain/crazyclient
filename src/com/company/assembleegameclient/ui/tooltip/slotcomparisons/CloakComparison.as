package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;

import kabam.rotmg.constants.*;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;

public class CloakComparison extends SlotComparison {


    override protected function compareSlots(_arg_1:XML, _arg_2:XML):void {
        var _local_3:XML;
        var _local_4:XML;
        var _local_5:Number;
        var _local_6:Number;
        _local_3 = this.getInvisibleTag(_arg_1);
        _local_4 = this.getInvisibleTag(_arg_2);
        comparisonStringBuilder = new AppendingLineBuilder();
        if (((!((_local_3 == null))) && (!((_local_4 == null))))) {
            _local_5 = Number(_local_3.@duration);
            _local_6 = Number(_local_4.@duration);
            this.appendDurationText(_local_5, _local_6);
            processedTags[_local_3.toXMLString()] = true;
        }
        this.handleExceptions(_arg_1);
    }

    private function handleExceptions(itemXML:XML):void {
        var teleportTag:XML;
        if (itemXML.@id == "Cloak of the Planewalker") {
            comparisonStringBuilder.pushParams(TextKey.TELEPORT_TO_TARGET, {}, TooltipHelper.getOpenTag(UNTIERED_COLOR), TooltipHelper.getCloseTag());
            teleportTag = XML(itemXML.Activate.(text() == ActivationType.TELEPORT))[0];
            processedTags[teleportTag.toXMLString()] = true;
        }
    }

    private function getInvisibleTag(xml:XML):XML {
        var matches:XMLList;
        var conditionTag:XML;
        matches = xml.Activate.(text() == ActivationType.COND_EFFECT_SELF);
        for each (conditionTag in matches) {
            if (conditionTag.(@effect == "Invisible")) {
                return (conditionTag);
            }
        }
        return (null);
    }

    private function appendDurationText(_arg_1:Number, _arg_2:Number):void {
        var _local_3:uint = getTextColor((_arg_1 - _arg_2));
        comparisonStringBuilder.pushParams(TextKey.EFFECT_ON_SELF, {"effect": ""});
        comparisonStringBuilder.pushParams(TextKey.EFFECT_FOR_DURATION, {
            "effect": TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_INVISIBLE),
            "duration": _arg_1.toString()
        }, TooltipHelper.getOpenTag(_local_3), TooltipHelper.getCloseTag());
    }


}
}//package com.company.assembleegameclient.ui.tooltip.slotcomparisons
