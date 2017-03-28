package com.company.assembleegameclient.ui.guild {
import com.company.assembleegameclient.ui.Scrollbar;
import com.company.assembleegameclient.util.GuildUtil;
import com.company.ui.BaseSimpleText;
import com.company.util.MoreObjectUtil;

import flash.display.Bitmap;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class GuildPlayerList extends Sprite {

    private var num_:int;
    private var offset_:int;
    private var myName_:String;
    private var myRank_:int;
    private var listClient_:AppEngineClient;
    private var loadingText_:TextFieldDisplayConcrete;
    private var titleText_:BaseSimpleText;
    private var guildFameText_:BaseSimpleText;
    private var guildFameIcon_:Bitmap;
    private var lines_:Shape;
    private var mainSprite_:Sprite;
    private var listSprite_:Sprite;
    private var openSlotsText_:TextFieldDisplayConcrete;
    private var scrollBar_:Scrollbar;

    public function GuildPlayerList(_arg_1:int, _arg_2:int, _arg_3:String = "", _arg_4:int = 0) {
        this.num_ = _arg_1;
        this.offset_ = _arg_2;
        this.myName_ = _arg_3;
        this.myRank_ = _arg_4;
        this.loadingText_ = new TextFieldDisplayConcrete().setSize(22).setColor(0xB3B3B3);
        this.loadingText_.setBold(true);
        this.loadingText_.setStringBuilder(new LineBuilder().setParams(TextKey.LOADING_TEXT));
        this.loadingText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.loadingText_.setAutoSize(TextFieldAutoSize.CENTER).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.loadingText_.x = (800 / 2);
        this.loadingText_.y = 550;
        addChild(this.loadingText_);
        var _local_5:Account = StaticInjectorContext.getInjector().getInstance(Account);
        var _local_6:Object = {
            "num": _arg_1,
            "offset": _arg_2
        };
        MoreObjectUtil.addToObject(_local_6, _local_5.getCredentials());
        this.listClient_ = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
        this.listClient_.setMaxRetries(2);
        this.listClient_.complete.addOnce(this.onComplete);
        this.listClient_.sendRequest("/guild/listMembers", _local_6);
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        if (_arg_1) {
            this.onGenericData(_arg_2);
        }
        else {
            this.onTextError(_arg_2);
        }
    }

    private function onGenericData(_arg_1:String):void {
        this.build(XML(_arg_1));
    }

    private function onTextError(_arg_1:String):void {
    }

    private function build(_arg_1:XML):void {
        var _local_2:Graphics;
        var _local_5:XML;
        var _local_6:int;
        var _local_7:Boolean;
        var _local_8:int;
        var _local_9:MemberListLine;
        removeChild(this.loadingText_);
        this.titleText_ = new BaseSimpleText(32, 0xB3B3B3, false, 0, 0);
        this.titleText_.setBold(true);
        this.titleText_.text = _arg_1.@name;
        this.titleText_.useTextDimensions();
        this.titleText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.titleText_.y = 24;
        this.titleText_.x = (400 - (this.titleText_.width / 2));
        addChild(this.titleText_);
        this.guildFameText_ = new BaseSimpleText(22, 0xFFFFFF, false, 0, 0);
        this.guildFameText_.text = _arg_1.CurrentFame;
        this.guildFameText_.useTextDimensions();
        this.guildFameText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.guildFameText_.x = (0x0300 - this.guildFameText_.width);
        this.guildFameText_.y = ((32 / 2) - (this.guildFameText_.height / 2));
        addChild(this.guildFameText_);
        this.guildFameIcon_ = new Bitmap(GuildUtil.guildFameIcon(40));
        this.guildFameIcon_.x = 760;
        this.guildFameIcon_.y = ((32 / 2) - (this.guildFameIcon_.height / 2));
        addChild(this.guildFameIcon_);
        this.lines_ = new Shape();
        _local_2 = this.lines_.graphics;
        _local_2.clear();
        _local_2.lineStyle(2, 0x545454);
        _local_2.moveTo(0, 100);
        _local_2.lineTo(800, 100);
        _local_2.lineStyle();
        addChild(this.lines_);
        this.mainSprite_ = new Sprite();
        this.mainSprite_.x = 10;
        this.mainSprite_.y = 110;
        var _local_3:Shape = new Shape();
        _local_2 = _local_3.graphics;
        _local_2.beginFill(0);
        _local_2.drawRect(0, 0, MemberListLine.WIDTH, 430);
        _local_2.endFill();
        this.mainSprite_.addChild(_local_3);
        this.mainSprite_.mask = _local_3;
        addChild(this.mainSprite_);
        this.listSprite_ = new Sprite();
        var _local_4:int;
        for each (_local_5 in _arg_1.Member) {
            _local_7 = (this.myName_ == _local_5.Name);
            _local_8 = _local_5.Rank;
            _local_9 = new MemberListLine(((this.offset_ + _local_4) + 1), _local_5.Name, _local_5.Rank, _local_5.Fame, _local_7, this.myRank_);
            _local_9.y = (_local_4 * MemberListLine.HEIGHT);
            this.listSprite_.addChild(_local_9);
            _local_4++;
        }
        _local_6 = (GuildUtil.MAX_MEMBERS - (this.offset_ + _local_4));
        this.openSlotsText_ = new TextFieldDisplayConcrete().setSize(22).setColor(0xB3B3B3);
        this.openSlotsText_.setStringBuilder(new LineBuilder().setParams(TextKey.GUILD_PLAYER_LIST_OPENSLOTS, {"openSlots": _local_6}));
        this.openSlotsText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.openSlotsText_.setAutoSize(TextFieldAutoSize.CENTER);
        this.openSlotsText_.x = (MemberListLine.WIDTH / 2);
        this.openSlotsText_.y = (_local_4 * MemberListLine.HEIGHT);
        this.listSprite_.addChild(this.openSlotsText_);
        this.mainSprite_.addChild(this.listSprite_);
        if (this.listSprite_.height > 400) {
            this.scrollBar_ = new Scrollbar(16, 400);
            this.scrollBar_.x = ((800 - this.scrollBar_.width) - 4);
            this.scrollBar_.y = 104;
            this.scrollBar_.setIndicatorSize(400, this.listSprite_.height);
            this.scrollBar_.addEventListener(Event.CHANGE, this.onScrollBarChange);
            addChild(this.scrollBar_);
        }
    }

    private function onScrollBarChange(_arg_1:Event):void {
        this.listSprite_.y = (-(this.scrollBar_.pos()) * (this.listSprite_.height - 400));
    }


}
}//package com.company.assembleegameclient.ui.guild
