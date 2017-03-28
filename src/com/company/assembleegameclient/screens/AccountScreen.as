package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.ui.GuildText;
import com.company.assembleegameclient.ui.RankText;
import com.company.assembleegameclient.ui.tooltip.RankToolTip;

import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.account.core.view.AccountInfoView;

import org.osflash.signals.Signal;

public class AccountScreen extends Sprite {

    public var tooltip:Signal;
    private var rankLayer:Sprite;
    private var guildLayer:Sprite;
    private var accountInfoLayer:Sprite;
    private var guildName:String;
    private var guildRank:int;
    private var stars:int;
    private var rankText:RankText;
    private var guildText:GuildText;
    private var accountInfo:AccountInfoView;

    public function AccountScreen() {
        this.tooltip = new Signal();
        this.makeLayers();
    }

    private function makeLayers():void {
        addChild((this.rankLayer = new Sprite()));
        addChild((this.guildLayer = new Sprite()));
        addChild((this.accountInfoLayer = new Sprite()));
    }

    private function returnHeaderBackground():DisplayObject {
        var _local_1:Shape = new Shape();
        _local_1.graphics.beginFill(0, 0.5);
        _local_1.graphics.drawRect(0, 0, 800, 35);
        return (_local_1);
    }

    public function setGuild(_arg_1:String, _arg_2:int):void {
        this.guildName = _arg_1;
        this.guildRank = _arg_2;
        this.makeGuildText();
    }

    private function makeGuildText():void {
        this.guildText = new GuildText(this.guildName, this.guildRank);
        this.guildText.x = 92;
        this.guildText.y = 6;
        while (this.guildLayer.numChildren > 0) {
            this.guildLayer.removeChildAt(0);
        }
        this.guildLayer.addChild(this.guildText);
    }

    public function setRank(_arg_1:int):void {
        this.stars = _arg_1;
        this.makeRankText();
    }

    private function makeRankText():void {
        this.rankText = new RankText(this.stars, true, false);
        this.rankText.x = 36;
        this.rankText.y = 4;
        this.rankText.mouseEnabled = true;
        this.rankText.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        this.rankText.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
        while (this.rankLayer.numChildren > 0) {
            this.rankLayer.removeChildAt(0);
        }
        this.rankLayer.addChild(this.rankText);
    }

    public function setAccountInfo(_arg_1:AccountInfoView):void {
        var _local_2:DisplayObject;
        this.accountInfo = _arg_1;
        _local_2 = (_arg_1 as DisplayObject);
        _local_2.x = (stage.stageWidth - 10);
        _local_2.y = 2;
        while (this.accountInfoLayer.numChildren > 0) {
            this.accountInfoLayer.removeChildAt(0);
        }
        this.accountInfoLayer.addChild(_local_2);
    }

    protected function onMouseOver(_arg_1:MouseEvent):void {
        this.tooltip.dispatch(new RankToolTip(this.stars));
    }

    protected function onRollOut(_arg_1:MouseEvent):void {
        this.tooltip.dispatch(null);
    }


}
}//package com.company.assembleegameclient.screens
