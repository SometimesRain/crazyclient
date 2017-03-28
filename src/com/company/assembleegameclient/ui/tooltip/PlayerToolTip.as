package com.company.assembleegameclient.ui.tooltip {
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.GameObjectListItem;
import com.company.assembleegameclient.ui.GuildText;
import com.company.assembleegameclient.ui.RankText;
import com.company.assembleegameclient.ui.StatusBar;
import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;

import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.StatMetersView;
import kabam.rotmg.game.view.components.StatsView;
import com.company.assembleegameclient.parameters.Parameters;

public class PlayerToolTip extends ToolTip {

    public var player_:Player;
    private var playerPanel_:GameObjectListItem;
    private var rankText_:RankText;
    private var guildText_:GuildText;
    private var hpBar_:StatusBar;
    private var mpBar_:StatusBar;
    private var clickMessage_:TextFieldDisplayConcrete;
    private var eGrid:EquippedGrid;
    private var sBars:StatMetersView;
    private var stats:StatsView;

    public function PlayerToolTip(_arg_1:Player) {
        var _local_2:int;
        super(0x363636, 0.5, 0xFFFFFF, 1);
        this.player_ = _arg_1;
        this.playerPanel_ = new GameObjectListItem(0xB3B3B3, true, this.player_);
        addChild(this.playerPanel_);
        _local_2 = 34;
        this.rankText_ = new RankText(this.player_.numStars_, false, true);
        this.rankText_.x = 6;
        this.rankText_.y = _local_2;
        addChild(this.rankText_);
        _local_2 = (_local_2 + 30);
        if (((!((_arg_1.guildName_ == null))) && (!((_arg_1.guildName_ == ""))))) {
            this.guildText_ = new GuildText(this.player_.guildName_, this.player_.guildRank_, 136);
            this.guildText_.x = 6;
            this.guildText_.y = (_local_2 - 2);
            addChild(this.guildText_);
            _local_2 = (_local_2 + 30);
        }
		//
        if(Parameters.data_["StatsViewer"])
        {
            sBars = new StatMetersView();
            sBars.x = 6;
            sBars.y = _local_2;
            addChild(sBars);
            sBars.myPlayer = false;
            _local_2 = _local_2 + 64;
            stats = new StatsView();
            stats.scaleX = 0.89;
            stats.x = 6;
            stats.y = _local_2;
            stats.myPlayer = false;
            addChild(stats);
            _local_2 = _local_2 + 52;
        }
        else
        {
			this.hpBar_ = new StatusBar(176, 16, 14693428, 0x545454, TextKey.STATUS_BAR_HEALTH_POINTS);
			this.hpBar_.x = 6;
			this.hpBar_.y = _local_2;
			addChild(this.hpBar_);
			_local_2 = (_local_2 + 24); //set pos for next element
			this.mpBar_ = new StatusBar(176, 16, 6325472, 0x545454, TextKey.STATUS_BAR_MANA_POINTS);
			this.mpBar_.x = 6;
			this.mpBar_.y = _local_2;
			addChild(this.mpBar_);
			_local_2 = (_local_2 + 24); //set pos for next element
        }
		//
        /*this.hpBar_ = new StatusBar(176, 16, 14693428, 0x545454, TextKey.STATUS_BAR_HEALTH_POINTS);
        this.hpBar_.x = 6;
        this.hpBar_.y = _local_2;
        addChild(this.hpBar_);
        _local_2 = (_local_2 + 24); //set pos for next element
        this.mpBar_ = new StatusBar(176, 16, 6325472, 0x545454, TextKey.STATUS_BAR_MANA_POINTS);
        this.mpBar_.x = 6;
        this.mpBar_.y = _local_2;
        addChild(this.mpBar_);
        _local_2 = (_local_2 + 24); //set pos for next element*/
		//
        this.eGrid = new EquippedGrid(null, this.player_.slotTypes_, this.player_, 0, true);
        this.eGrid.x = 8;
        this.eGrid.y = _local_2;
        addChild(this.eGrid);
		if (Parameters.data_["InvViewer"]) {
			_local_2 = (_local_2 + 118); //set pos for next element, was 52
		}
		else {
			_local_2 = (_local_2 + 42);
		}
		//
        this.clickMessage_ = new TextFieldDisplayConcrete().setSize(12).setColor(0xB3B3B3);
        this.clickMessage_.setAutoSize(TextFieldAutoSize.CENTER);
        this.clickMessage_.setStringBuilder(new LineBuilder().setParams(""));
        this.clickMessage_.filters = [new DropShadowFilter(0, 0, 0)];
        this.clickMessage_.x = (width / 2);
        this.clickMessage_.y = _local_2;
        waiter.push(this.clickMessage_.textChanged);
        addChild(this.clickMessage_);
    }

    override public function draw():void {
        if(Parameters.data_["StatsViewer"])
        {
            sBars.update(player_);
            stats.draw(player_);
        }
        else
        {
			this.hpBar_.draw(this.player_.hp_, this.player_.maxHP_, this.player_.maxHPBoost_, this.player_.maxHPMax_);
			this.mpBar_.draw(this.player_.mp_, this.player_.maxMP_, this.player_.maxMPBoost_, this.player_.maxMPMax_);
        }
		//
        /*this.hpBar_.draw(this.player_.hp_, this.player_.maxHP_, this.player_.maxHPBoost_, this.player_.maxHPMax_);
        this.mpBar_.draw(this.player_.mp_, this.player_.maxMP_, this.player_.maxMPBoost_, this.player_.maxMPMax_);*/
		//
        this.eGrid.setItems(this.player_.equipment_);
        this.rankText_.draw(this.player_.numStars_);
        super.draw();
    }


}
}//package com.company.assembleegameclient.ui.tooltip
