package com.company.assembleegameclient.ui.menu {
import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.GameObjectListItem;
import com.company.assembleegameclient.util.GuildUtil;
import com.company.util.AssetLibrary;

import flash.events.Event;
import flash.events.MouseEvent;

import kabam.rotmg.chat.control.ShowChatInputSignal;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.friends.controller.FriendActionSignal;
import kabam.rotmg.friends.model.FriendConstant;
import kabam.rotmg.friends.model.FriendRequestVO;
import kabam.rotmg.text.model.TextKey;

public class PlayerMenu extends Menu {

    public var gs_:AGameSprite;
    public var playerName_:String;
    public var player_:Player;
    public var playerPanel_:GameObjectListItem;

    public function PlayerMenu() {
        super(0x363636, 0xFFFFFF);
    }

    public function initDifferentServer(_arg_1:AGameSprite, _arg_2:String, _arg_3:Boolean = false, _arg_4:Boolean = false):void {
        var _local_5:MenuOption;
        this.gs_ = _arg_1;
        this.playerName_ = _arg_2;
        this.player_ = null;
        this.yOffset = (this.yOffset - 25);
		if (Parameters.data_.wMenu) {
			_local_5 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",21),16777215,TextKey.PLAYERMENU_PM);
			_local_5.addEventListener(MouseEvent.CLICK,this.onPrivateMessage);
			addOption(_local_5);
		}
    }

    public function init(_arg_1:AGameSprite, _arg_2:Player):void {
        var _local_3:MenuOption;
        this.gs_ = _arg_1;
        this.playerName_ = _arg_2.name_;
        this.player_ = _arg_2;
        this.playerPanel_ = new GameObjectListItem(0xB3B3B3, true, this.player_, true);
        this.yOffset = (this.yOffset + 7);
        addChild(this.playerPanel_);
		
		//teleport
        if (((this.gs_.map.allowPlayerTeleport()) && (this.player_.isTeleportEligible(this.player_)))) {
            _local_3 = new TeleportMenuOption(this.gs_.map.player_);
            _local_3.addEventListener(MouseEvent.CLICK, this.onTeleport);
            addOption(_local_3);
        }
		//invite
        if (this.gs_.map.player_.guildRank_ >= GuildUtil.OFFICER && (_arg_2.guildName_ == null || _arg_2.guildName_.length == 0)) {
            _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 10), 0xFFFFFF, TextKey.PLAYERMENU_INVITE);
            _local_3.addEventListener(MouseEvent.CLICK, this.onInvite);
            addOption(_local_3);
        }
		//lock
        if (!this.player_.starred_) {
            _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterface2", 5), 0xFFFFFF, TextKey.PLAYERMENU_LOCK);
            _local_3.addEventListener(MouseEvent.CLICK, this.onLock);
            addOption(_local_3);
        }
        else {
            _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterface2", 6), 0xFFFFFF, TextKey.PLAYERMENU_UNLOCK);
            _local_3.addEventListener(MouseEvent.CLICK, this.onUnlock);
            addOption(_local_3);
        }
		//trade
        _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 7), 0xFFFFFF, TextKey.PLAYERMENU_TRADE);
        _local_3.addEventListener(MouseEvent.CLICK, this.onTrade);
        addOption(_local_3);
		//whisper
		if (Parameters.data_.wMenu) {
			_local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig",21),16777215,TextKey.PLAYERMENU_PM);
			_local_3.addEventListener(MouseEvent.CLICK,this.onPrivateMessage);
			addOption(_local_3);
		}
		//ignore
        if (!this.player_.ignored_) {
            _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 8), 0xFFFFFF, TextKey.FRIEND_BLOCK_BUTTON);
            _local_3.addEventListener(MouseEvent.CLICK, this.onIgnore);
            addOption(_local_3);
        }
        else {
            _local_3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 9), 0xFFFFFF, TextKey.PLAYERMENU_UNIGNORE);
            _local_3.addEventListener(MouseEvent.CLICK, this.onUnignore);
            addOption(_local_3);
        }
    }

    private function onPrivateMessage(_arg_1:Event):void {
        var _local_2:ShowChatInputSignal = StaticInjectorContext.getInjector().getInstance(ShowChatInputSignal);
        _local_2.dispatch(true, (("/tell " + this.playerName_) + " "));
        remove();
    }

    private function onAddFriend(_arg_1:Event):void {
        var _local_2:FriendActionSignal = StaticInjectorContext.getInjector().getInstance(FriendActionSignal);
        _local_2.dispatch(new FriendRequestVO(FriendConstant.INVITE, this.playerName_));
        remove();
    }

    private function onTradeMessage(_arg_1:Event):void {
        var _local_2:ShowChatInputSignal = StaticInjectorContext.getInjector().getInstance(ShowChatInputSignal);
        _local_2.dispatch(true, ("/trade " + this.playerName_));
        remove();
    }

    private function onGuildMessage(_arg_1:Event):void {
        var _local_2:ShowChatInputSignal = StaticInjectorContext.getInjector().getInstance(ShowChatInputSignal);
        _local_2.dispatch(true, "/g ");
        remove();
    }

    private function onTeleport(_arg_1:Event):void {
        this.gs_.map.player_.teleportTo(this.player_);
        remove();
    }

    private function onInvite(_arg_1:Event):void {
        this.gs_.gsc_.guildInvite(this.playerName_);
        remove();
    }

    private function onLock(_arg_1:Event):void {
        this.gs_.map.party_.lockPlayer(this.player_);
        remove();
    }

    private function onUnlock(_arg_1:Event):void {
        this.gs_.map.party_.unlockPlayer(this.player_);
        remove();
    }

    private function onTrade(_arg_1:Event):void {
        this.gs_.gsc_.requestTrade(this.playerName_);
        remove();
    }

    private function onIgnore(_arg_1:Event):void {
        this.gs_.map.party_.ignorePlayer(this.player_);
        remove();
    }

    private function onUnignore(_arg_1:Event):void {
        this.gs_.map.party_.unignorePlayer(this.player_);
        remove();
    }


}
}//package com.company.assembleegameclient.ui.menu
