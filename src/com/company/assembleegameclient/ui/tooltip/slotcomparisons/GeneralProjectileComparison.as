package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;

public class GeneralProjectileComparison extends SlotComparison {

    private var itemXML:XML;
    private var curItemXML:XML;
    private var projXML:XML;
    private var otherProjXML:XML;


    override protected function compareSlots(_arg_1:XML, _arg_2:XML):void {
        this.itemXML = _arg_1;
        this.curItemXML = _arg_2;
        comparisonStringBuilder = new AppendingLineBuilder();
        if (_arg_1.hasOwnProperty("NumProjectiles")) {
            this.addNumProjectileText();
            processedTags[_arg_1.NumProjectiles.toXMLString()] = true;
        }
        if (_arg_1.hasOwnProperty("Projectile")) {
            this.addProjectileText();
            processedTags[_arg_1.Projectile.toXMLString()] = true;
        }
        this.buildRateOfFireText();
    }

    private function addProjectileText():void {
        this.addDamageText();
        var _local_1:Number = ((Number(this.projXML.Speed) * Number(this.projXML.LifetimeMS)) / 10000);
        var _local_2:Number = ((Number(this.otherProjXML.Speed) * Number(this.otherProjXML.LifetimeMS)) / 10000);
        var _local_3:String = TooltipHelper.getFormattedRangeString(_local_1);
        comparisonStringBuilder.pushParams(TextKey.RANGE, {"range": wrapInColoredFont(_local_3, getTextColor((_local_1 - _local_2)))});
        if (this.projXML.hasOwnProperty("MultiHit")) {
            comparisonStringBuilder.pushParams(TextKey.MULTIHIT, {}, TooltipHelper.getOpenTag(NO_DIFF_COLOR), TooltipHelper.getCloseTag());
        }
        if (this.projXML.hasOwnProperty("PassesCover")) {
            comparisonStringBuilder.pushParams(TextKey.PASSES_COVER, {}, TooltipHelper.getOpenTag(NO_DIFF_COLOR), TooltipHelper.getCloseTag());
        }
        if (this.projXML.hasOwnProperty("ArmorPiercing")) {
            comparisonStringBuilder.pushParams(TextKey.ARMOR_PIERCING, {}, TooltipHelper.getOpenTag(NO_DIFF_COLOR), TooltipHelper.getCloseTag());
        }
    }

    private function addNumProjectileText():void {
        var _local_1:int = int(this.itemXML.NumProjectiles);
        var _local_2:int = int(this.curItemXML.NumProjectiles);
        var _local_3:uint = getTextColor((_local_1 - _local_2));
        comparisonStringBuilder.pushParams(TextKey.SHOTS, {"numShots": wrapInColoredFont(_local_1.toString(), _local_3)});
    }

    private function addDamageText():void {
        this.projXML = XML(this.itemXML.Projectile);
        var _local_1:int = int(this.projXML.MinDamage);
        var _local_2:int = int(this.projXML.MaxDamage);
        var _local_3:Number = ((_local_2 + _local_1) / 2);
        this.otherProjXML = XML(this.curItemXML.Projectile);
        var _local_4:int = int(this.otherProjXML.MinDamage);
        var _local_5:int = int(this.otherProjXML.MaxDamage);
        var _local_6:Number = ((_local_5 + _local_4) / 2);
        var _local_7:String = (((_local_1 == _local_2)) ? _local_1 : ((_local_1 + " - ") + _local_2)).toString();
        comparisonStringBuilder.pushParams(TextKey.DAMAGE, {"damage": wrapInColoredFont(_local_7, getTextColor((_local_3 - _local_6)))});
    }

    private function buildRateOfFireText():void {
        if ((((this.itemXML.RateOfFire.length() == 0)) || ((this.curItemXML.RateOfFire.length() == 0)))) {
            return;
        }
        var _local_1:Number = Number(this.curItemXML.RateOfFire[0]);
        var _local_2:Number = Number(this.itemXML.RateOfFire[0]);
        var _local_3:int = int(((_local_2 / _local_1) * 100));
        var _local_4:int = (_local_3 - 100);
        if (_local_4 == 0) {
            return;
        }
        var _local_5:uint = getTextColor(_local_4);
        var _local_6:String = _local_4.toString();
        if (_local_4 > 0) {
            _local_6 = ("+" + _local_6);
        }
        _local_6 = wrapInColoredFont((_local_6 + "%"), _local_5);
        comparisonStringBuilder.pushParams(TextKey.RATE_OF_FIRE, {"data": _local_6});
        processedTags[this.itemXML.RateOfFire[0].toXMLString()];
    }


}
}//package com.company.assembleegameclient.ui.tooltip.slotcomparisons
