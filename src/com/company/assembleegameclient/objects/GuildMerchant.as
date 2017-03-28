package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.assembleegameclient.util.Currency;
import com.company.assembleegameclient.util.GuildUtil;

import flash.display.BitmapData;

public class GuildMerchant extends SellableObject implements IInteractiveObject {

    public var description_:String;

    public function GuildMerchant(_arg_1:XML) {
        super(_arg_1);
        price_ = int(_arg_1.Price);
        currency_ = Currency.GUILD_FAME;
        this.description_ = _arg_1.Description;
        guildRankReq_ = GuildUtil.LEADER;
    }

    override public function soldObjectName():String {
        return (ObjectLibrary.typeToDisplayId_[objectType_]);
    }

    override public function soldObjectInternalName():String {
        var _local_1:XML = ObjectLibrary.xmlLibrary_[objectType_];
        return (_local_1.@id.toString());
    }

    override public function getTooltip():ToolTip {
        return (new TextToolTip(0x363636, 0x9B9B9B, this.soldObjectName(), this.description_, 200));
    }

    override public function getSellableType():int {
        return (objectType_);
    }

    override public function getIcon():BitmapData {
        return (ObjectLibrary.getRedrawnTextureFromType(objectType_, 80, true));
    }


}
}//package com.company.assembleegameclient.objects
