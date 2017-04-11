package kabam.rotmg.chat.view {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
//import kabam.rotmg.chat.model.ChatMessage;
//import kabam.rotmg.game.signals.AddTextLineSignal;
import org.swiftsuspenders.Injector;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.utils.getTimer;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.ui.model.HUDModel;

public class ChatListItem extends Sprite {

    private static const CHAT_ITEM_TIMEOUT:uint = 20000;

    private var itemWidth:int;
    private var list:Vector.<DisplayObject>;
    private var count:uint;
    private var layoutHeight:uint;
    private var creationTime:uint;
    private var timedOutOverride:Boolean;
    public var playerObjectId:int;
    public var playerName:String = "";
    public var fromGuild:Boolean = false;
    public var isTrade:Boolean = false;
	
	private var model:HUDModel;
	//private var addTextLine:AddTextLineSignal;

    public function ChatListItem(_arg_1:Vector.<DisplayObject>, _arg_2:int, _arg_3:int, _arg_4:Boolean, _arg_5:int, _arg_6:String, _arg_7:Boolean, _arg_8:Boolean) {
        mouseEnabled = true;
        this.itemWidth = _arg_2;
        this.layoutHeight = _arg_3;
        this.list = _arg_1;
        this.count = _arg_1.length;
        this.creationTime = getTimer();
        this.timedOutOverride = _arg_4;
        this.playerObjectId = _arg_5;
        this.playerName = _arg_6;
        this.fromGuild = _arg_7;
        this.isTrade = _arg_8;
        this.layoutItems();
        this.addItems();
        var _local_2:Injector = StaticInjectorContext.getInjector();
        //addTextLine = _local_2.getInstance(AddTextLineSignal);
        model = _local_2.getInstance(HUDModel);
        addEventListener(MouseEvent.RIGHT_CLICK, this.onRightMouseDown);
        //addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onRightMouseDown);
    }

    public function onRightMouseDown(e:MouseEvent):void {
		if (Parameters.data_.rclickTp) {
			var go_:GameObject = model.gameSprite.map.goDict_[playerObjectId];
			if (go_ != null && go_ is Player) {
				model.gameSprite.gsc_.teleport(go_.name_);
			}
		}
		else {
			var aPlayer:Player;
			if (model.gameSprite.map.goDict_[playerObjectId] != null && model.gameSprite.map.goDict_[playerObjectId] is Player && model.gameSprite.map.player_.objectId_ != playerObjectId) {
				aPlayer = (model.gameSprite.map.goDict_[this.playerObjectId] as Player);
				model.gameSprite.addChatPlayerMenu(aPlayer, e.stageX, e.stageY);
			}
			else if (this.playerName != null && this.playerName != "" && model.gameSprite.map.player_.name_ != this.playerName) {
				if (!isTrade) {
					model.gameSprite.addChatPlayerMenu(null, e.stageX, e.stageY, this.playerName, this.fromGuild);
				}
				else if (isTrade) {
					model.gameSprite.addChatPlayerMenu(null, e.stageX, e.stageY, this.playerName, false, true);
				}
			}
		}
    }

    public function isTimedOut():Boolean {
        return ((((getTimer() > (this.creationTime + CHAT_ITEM_TIMEOUT))) || (this.timedOutOverride)));
    }

    private function layoutItems():void {
        var _local_1:int;
        var _local_3:DisplayObject;
        var _local_4:Rectangle;
        var _local_5:int;
        _local_1 = 0;
        var _local_2:int;
        while (_local_2 < this.count) {
            _local_3 = this.list[_local_2];
            _local_4 = _local_3.getRect(_local_3);
            _local_3.x = _local_1;
            _local_3.y = (((this.layoutHeight - _local_4.height) * 0.5) - this.layoutHeight);
            if ((_local_1 + _local_4.width) > this.itemWidth) {
                _local_3.x = 0;
                _local_1 = 0;
                _local_5 = 0;
                while (_local_5 < _local_2) {
                    this.list[_local_5].y = (this.list[_local_5].y - this.layoutHeight);
                    _local_5++;
                }
            }
            _local_1 = (_local_1 + _local_4.width);
            _local_2++;
        }
    }

    private function addItems():void {
        var _local_1:DisplayObject;
        for each (_local_1 in this.list) {
            addChild(_local_1);
        }
    }


}
}//package kabam.rotmg.chat.view
