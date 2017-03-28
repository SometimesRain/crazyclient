package com.company.assembleegameclient.ui {
import com.company.assembleegameclient.util.GuildUtil;
import com.company.util.SpriteUtil;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class GuildText extends Sprite {

    private var name_:String;
    private var rank_:int;
    private var icon_:Bitmap;
    private var guildName_:TextFieldDisplayConcrete;

    public function GuildText(_arg_1:String, _arg_2:int, _arg_3:int = 0) {
        this.icon_ = new Bitmap(null);
        this.icon_.y = -8;
        this.icon_.x = -8;
        var _local_4:int = (((_arg_3 == 0)) ? 0 : (_arg_3 - (this.icon_.width - 16)));
        this.guildName_ = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth(_local_4);
        this.guildName_.setAutoSize(TextFieldAutoSize.LEFT);
        this.guildName_.filters = [new DropShadowFilter(0, 0, 0)];
        this.guildName_.x = 24;
        this.guildName_.y = 2;
        this.draw(_arg_1, _arg_2);
    }

    public function draw(_arg_1:String, _arg_2:int):void {
        if ((((this.name_ == _arg_1)) && ((_arg_2 == _arg_2)))) {
            return;
        }
        this.name_ = _arg_1;
        this.rank_ = _arg_2;
        if ((((this.name_ == null)) || ((this.name_ == "")))) {
            SpriteUtil.safeRemoveChild(this, this.icon_);
            SpriteUtil.safeRemoveChild(this, this.guildName_);
        }
        else {
            this.icon_.bitmapData = GuildUtil.rankToIcon(this.rank_, 20);
            SpriteUtil.safeAddChild(this, this.icon_);
            this.guildName_.setStringBuilder(new StaticStringBuilder(this.name_));
            SpriteUtil.safeAddChild(this, this.guildName_);
        }
    }


}
}//package com.company.assembleegameclient.ui
