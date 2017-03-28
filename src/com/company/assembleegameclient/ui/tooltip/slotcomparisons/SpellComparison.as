package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class SpellComparison extends SlotComparison {

    private var itemXML:XML;
    private var curItemXML:XML;
    private var projXML:XML;
    private var otherProjXML:XML;

    public function SpellComparison() {
        comparisonStringBuilder = new AppendingLineBuilder();
    }

    override protected function compareSlots(_arg_1:XML, _arg_2:XML):void {
        this.itemXML = _arg_1;
        this.curItemXML = _arg_2;
        this.projXML = _arg_1.Projectile[0];
        this.otherProjXML = _arg_2.Projectile[0];
        this.getDamageText();
        this.getRangeText();
        processedTags[this.projXML.toXMLString()] = true;
    }

    private function getDamageText():StringBuilder {
        var _local_1:int = int(this.projXML.MinDamage);
        var _local_2:int = int(this.projXML.MaxDamage);
        var _local_3:int = int(this.otherProjXML.MinDamage);
        var _local_4:int = int(this.otherProjXML.MaxDamage);
        var _local_5:Number = ((_local_1 + _local_2) / 2);
        var _local_6:Number = ((_local_3 + _local_4) / 2);
        var _local_7:uint = getTextColor((_local_5 - _local_6));
        var _local_8:String = (((_local_1) == _local_2) ? _local_2.toString() : ((_local_1 + " - ") + _local_2));
        return (comparisonStringBuilder.pushParams(TextKey.DAMAGE, {"damage": (((('<font color="#' + _local_7.toString(16)) + '">') + _local_8) + "</font>")}));
    }

    private function getRangeText():StringBuilder {
        var _local_1:Number = ((Number(this.projXML.Speed) * Number(this.projXML.LifetimeMS)) / 10000);
        var _local_2:Number = ((Number(this.otherProjXML.Speed) * Number(this.otherProjXML.LifetimeMS)) / 10000);
        var _local_3:uint = getTextColor((_local_1 - _local_2));
        return (comparisonStringBuilder.pushParams(TextKey.RANGE, {"range": (((('<font color="#' + _local_3.toString(16)) + '">') + _local_1) + "</font>")}));
    }


}
}//package com.company.assembleegameclient.ui.tooltip.slotcomparisons
