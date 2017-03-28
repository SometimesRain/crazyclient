package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;

import kabam.rotmg.constants.*;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;

public class HelmetComparison extends SlotComparison {

    private var berserk:XML;
    private var speedy:XML;
    private var otherBerserk:XML;
    private var otherSpeedy:XML;
    private var armored:XML;
    private var otherArmored:XML;


    override protected function compareSlots(_arg_1:XML, _arg_2:XML):void {
        this.extractDataFromXML(_arg_1, _arg_2);
        comparisonStringBuilder = new AppendingLineBuilder();
        this.handleBerserk();
        this.handleSpeedy();
        this.handleArmored();
    }

    private function extractDataFromXML(_arg_1:XML, _arg_2:XML):void {
        this.berserk = this.getAuraTagByType(_arg_1, "Berserk");
        this.speedy = this.getSelfTagByType(_arg_1, "Speedy");
        this.armored = this.getSelfTagByType(_arg_1, "Armored");
        this.otherBerserk = this.getAuraTagByType(_arg_2, "Berserk");
        this.otherSpeedy = this.getSelfTagByType(_arg_2, "Speedy");
        this.otherArmored = this.getSelfTagByType(_arg_2, "Armored");
    }

    private function getAuraTagByType(xml:XML, typeName:String):XML {
        var matches:XMLList;
        var tag:XML;
        matches = xml.Activate.(text() == ActivationType.COND_EFFECT_AURA);
        for each (tag in matches) {
            if (tag.@effect == typeName) {
                return (tag);
            }
        }
        return (null);
    }

    private function getSelfTagByType(xml:XML, typeName:String):XML {
        var matches:XMLList;
        var tag:XML;
        matches = xml.Activate.(text() == ActivationType.COND_EFFECT_SELF);
        for each (tag in matches) {
            if (tag.@effect == typeName) {
                return (tag);
            }
        }
        return (null);
    }

    private function handleBerserk():void {
        if ((((this.berserk == null)) || ((this.otherBerserk == null)))) {
            return;
        }
        var _local_1:Number = Number(this.berserk.@range);
        var _local_2:Number = Number(this.otherBerserk.@range);
        var _local_3:Number = Number(this.berserk.@duration);
        var _local_4:Number = Number(this.otherBerserk.@duration);
        var _local_5:Number = ((0.5 * _local_1) + (0.5 * _local_3));
        var _local_6:Number = ((0.5 * _local_2) + (0.5 * _local_4));
        var _local_7:uint = getTextColor((_local_5 - _local_6));
        var _local_8:AppendingLineBuilder = new AppendingLineBuilder();
        _local_8.pushParams(TextKey.WITHIN_SQRS, {"range": _local_1.toString()}, TooltipHelper.getOpenTag(_local_7), TooltipHelper.getCloseTag());
        _local_8.pushParams(TextKey.EFFECT_FOR_DURATION, {
            "effect": TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_BERSERK),
            "duration": _local_3.toString()
        }, TooltipHelper.getOpenTag(_local_7), TooltipHelper.getCloseTag());
        comparisonStringBuilder.pushParams(TextKey.PARTY_EFFECT, {"effect": _local_8});
        processedTags[this.berserk.toXMLString()] = true;
    }

    private function handleSpeedy():void {
        var _local_1:Number;
        var _local_2:Number;
        if (((!((this.speedy == null))) && (!((this.otherSpeedy == null))))) {
            _local_1 = Number(this.speedy.@duration);
            _local_2 = Number(this.otherSpeedy.@duration);
            comparisonStringBuilder.pushParams(TextKey.EFFECT_ON_SELF, {"effect": ""});
            comparisonStringBuilder.pushParams(TextKey.EFFECT_FOR_DURATION, {
                "effect": TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_SPEEDY),
                "duration": _local_1.toString()
            }, TooltipHelper.getOpenTag(getTextColor((_local_1 - _local_2))), TooltipHelper.getCloseTag());
            processedTags[this.speedy.toXMLString()] = true;
        }
        else {
            if (((!((this.speedy == null))) && ((this.otherSpeedy == null)))) {
                comparisonStringBuilder.pushParams(TextKey.EFFECT_ON_SELF, {"effect": ""});
                comparisonStringBuilder.pushParams(TextKey.EFFECT_FOR_DURATION, {
                    "effect": TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_SPEEDY),
                    "duration": this.speedy.@duration
                }, TooltipHelper.getOpenTag(BETTER_COLOR), TooltipHelper.getCloseTag());
                processedTags[this.speedy.toXMLString()] = true;
            }
        }
    }

    private function handleArmored():void {
        if (this.armored != null) {
            comparisonStringBuilder.pushParams(TextKey.EFFECT_ON_SELF, {"effect": ""});
            comparisonStringBuilder.pushParams(TextKey.EFFECT_FOR_DURATION, {
                "effect": TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_ARMORED),
                "duration": this.armored.@duration
            }, TooltipHelper.getOpenTag(UNTIERED_COLOR), TooltipHelper.getCloseTag());
            processedTags[this.armored.toXMLString()] = true;
        }
    }


}
}//package com.company.assembleegameclient.ui.tooltip.slotcomparisons
