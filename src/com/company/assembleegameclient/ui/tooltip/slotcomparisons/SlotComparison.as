package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import flash.utils.Dictionary;

import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;

public class SlotComparison {

    public static const BETTER_COLOR:uint = 0xFF00;
    public static const WORSE_COLOR:uint = 0xFF0000;
    public static const NO_DIFF_COLOR:uint = 16777103;
    public static const LABEL_COLOR:uint = 0xB3B3B3;
    public static const UNTIERED_COLOR:uint = 9055202;

    public var processedTags:Dictionary;
    public var processedActivateOnEquipTags:AppendingLineBuilder;
    public var comparisonStringBuilder:AppendingLineBuilder;


    public function compare(_arg_1:XML, _arg_2:XML):void {
        this.resetFields();
        this.compareSlots(_arg_1, _arg_2);
    }

    protected function compareSlots(_arg_1:XML, _arg_2:XML):void {
    }

    private function resetFields():void {
        this.processedTags = new Dictionary();
        this.processedActivateOnEquipTags = new AppendingLineBuilder();
    }

    protected function getTextColor(_arg_1:Number):uint {
        if (_arg_1 < 0) {
            return (WORSE_COLOR);
        }
        if (_arg_1 > 0) {
            return (BETTER_COLOR);
        }
        return (NO_DIFF_COLOR);
    }

    protected function wrapInColoredFont(_arg_1:String, _arg_2:uint = 16777103):String {
        return ((((('<font color="#' + _arg_2.toString(16)) + '">') + _arg_1) + "</font>"));
    }

    protected function getMpCostText(_arg_1:String):String {
        return (((this.wrapInColoredFont("MP Cost: ", LABEL_COLOR) + this.wrapInColoredFont(_arg_1, NO_DIFF_COLOR)) + "\n"));
    }


}
}//package com.company.assembleegameclient.ui.tooltip.slotcomparisons
