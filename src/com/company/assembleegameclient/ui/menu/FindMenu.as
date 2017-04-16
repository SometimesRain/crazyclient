package com.company.assembleegameclient.ui.menu {
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.DeprecatedClickableText;
import com.company.assembleegameclient.ui.GameObjectListItem;
import com.company.assembleegameclient.ui.PlayerGameObjectListItem;
import flash.events.Event;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;

import flash.events.MouseEvent;

public class FindMenu extends Frame {
	
    public var gs_:GameSprite;
    public var closeDialogs:CloseDialogsSignal;
	public var p_:Vector.<Player>;
	private const perRow:int = 5;
	private const padX:int = 130;
	private const padY:int = 28;

    public function FindMenu(gs:GameSprite, players:Vector.<Player>, itemname:String) {
        super(itemname+" (Click to trade)", "", "");
		gs_ = gs;
		p_ = players;
		var le:int = p_.length;
        this.w_ = 12 + (le < perRow ? p_.length : perRow) * padX;
        this.h_ = int(le / perRow) * padY + 75;
		if (le % perRow > 0) {
			h_ += padY;
		}
        var i:int;
		closeDialogs = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
        while (i < le) {
            var _local_3:PlayerGameObjectListItem = new PlayerGameObjectListItem(0xB3B3B3, false, p_[i], false, p_[i].lastAltAttack_);
            _local_3.x = padX * (i % perRow);
            _local_3.y = 28 + padY * int(i / perRow);
            addChild(_local_3);
            _local_3.addEventListener(MouseEvent.CLICK, this.onClick);
            i++;
        }
        var closeButton:DeprecatedClickableText = new DeprecatedClickableText(18, true, "Close");
        closeButton.buttonMode = true;
		closeButton.x = w_ - 100; //120
		closeButton.y = h_ - 40
		addChild(closeButton);
        closeButton.addEventListener(MouseEvent.CLICK, this.onClose);
		if (le > 1) {
			var tradeAll:DeprecatedClickableText = new DeprecatedClickableText(18, true, "Trade All");
			tradeAll.buttonMode = true;
			tradeAll.x = w_ - 200; //210
			tradeAll.y = h_ - 40
			addChild(tradeAll);
			tradeAll.addEventListener(MouseEvent.CLICK, this.tradeAllFunc);
		}
    }

    private function onClick(e:MouseEvent):void {
        var _local_2:GameObject = (e.currentTarget as PlayerGameObjectListItem).go;
		gs_.gsc_.requestTrade(_local_2.name_);
    }

    private function tradeAllFunc(e:MouseEvent):void {
        var _local_2:Player;
		for each(_local_2 in p_) {
			gs_.gsc_.requestTrade(_local_2.name_);
		}
        closeDialogs.dispatch();
    }

    private function onClose(e:MouseEvent):void {
        //this.cancel.dispatch();
        closeDialogs.dispatch();
    }

}
}//package com.company.assembleegameclient.account.ui
