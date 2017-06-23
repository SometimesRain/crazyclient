package kabam.rotmg.chat.control {
import com.company.assembleegameclient.game.events.ReconnectEvent;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.TextureDataConcrete;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.CJDateUtil;
import flash.utils.ByteArray;
import kabam.rotmg.game.commands.PlayGameCommand;
import kabam.rotmg.messaging.impl.GameServerConnectionConcrete;
import kabam.rotmg.messaging.impl.data.ObjectData;
import kabam.rotmg.servers.api.Server;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.view.ConfirmEmailModal;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.chat.model.TellModel;
import kabam.rotmg.chat.view.ChatListItemFactory;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.fortune.services.FortuneModel;
import kabam.rotmg.friends.model.FriendModel;
import kabam.rotmg.game.model.AddSpeechBalloonVO;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.game.signals.AddSpeechBalloonSignal;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.language.model.StringMap;
import kabam.rotmg.messaging.impl.incoming.Text;
import kabam.rotmg.news.view.NewsTicker;
import kabam.rotmg.servers.api.ServerModel;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.model.HUDModel;
import flash.utils.getTimer;

public class TextHandler {

    private const NORMAL_SPEECH_COLORS:TextColors = new TextColors(14802908, 0xFFFFFF, 0x545454);
    private const ENEMY_SPEECH_COLORS:TextColors = new TextColors(5644060, 16549442, 13484223);
    private const TELL_SPEECH_COLORS:TextColors = new TextColors(2493110, 61695, 13880567);
    private const GUILD_SPEECH_COLORS:TextColors = new TextColors(0x3E8A00, 10944349, 13891532);

    [Inject]
    public var account:Account;
    [Inject]
    public var model:GameModel;
    [Inject]
    public var addTextLine:AddTextLineSignal;
    [Inject]
    public var addSpeechBalloon:AddSpeechBalloonSignal;
    [Inject]
    public var stringMap:StringMap;
    [Inject]
    public var tellModel:TellModel;
    [Inject]
    public var openDialogSignal:OpenDialogSignal;
    [Inject]
    public var hudModel:HUDModel;
    [Inject]
    public var friendModel:FriendModel;
	
	public static var caller:String = "";
	public static var afk:Boolean = false;
	public static var afkTells:Vector.<ChatMessage> = new <ChatMessage>[];
	public static var sendBacks:Vector.<String> = new <String>[];
	public static var afkMsg:String = "";
	private var now:CJDateUtil;
	
	public static var realmspyId:int = -1;
	public static var rsx:Number = -1;
	public static var rsy:Number = -1;

    public function execute(_arg_1:Text):void {
        var _local_3:String;
        var _local_4:String;
        var _local_5:String;
		var lower:String;
        var _local_2:Boolean = _arg_1.numStars_ == -1; //|| _arg_1.objectId_ == -1
		var p:Player = hudModel.gameSprite.map.player_;
		/*if (_local_2 && p.objectType_ == 775 && _arg_1.text_ == "EYE see you!") {
			hudModel.gameSprite.mui_.handlePerfectAim(p); //auto paralyze avatar eyes
		}*/
        if (!Parameters.data_.chatAll && _arg_1.name_ != model.player.name_ && !_local_2 && !isSpecialRecipientChat(_arg_1.recipient_)) {
            if (!(_arg_1.recipient_ == Parameters.GUILD_CHAT_NAME && Parameters.data_.chatGuild)) {
                if (!(_arg_1.recipient_ != "" && Parameters.data_.chatWhisper)) {
                    return;
                }
            }
        }
        if (_arg_1.recipient_ != "" && Parameters.data_.chatFriend && !friendModel.isMyFriend(_arg_1.recipient_)) {
            return; //ignore messages from non-friends if the option is enabled
        }
        if (_arg_1.text_.substr(0,4) != "£åè|" && _arg_1.numStars_ <= Parameters.data_.chatStarRequirement && _arg_1.name_ != model.player.name_ && !_local_2 && _arg_1.recipient_ == "" && !isSpecialRecipientChat(_arg_1.recipient_)) {
            return; //ignore messages from players under star filter
        }
		if (hudModel.gameSprite.map.name_ == "Nexus" && _arg_1.name_.length > 0 && _arg_1.name_.charAt(0) == "#") {
			return; //ignore enemy speech in nexus
		}
		//SPAMFILTER
		lower = _arg_1.text_.toLowerCase();
		for each (var str:String in Parameters.data_.spamFilter) {
			if (lower.indexOf(str) != -1) {
				return;
			}
		}
        if (_arg_1.recipient_) {
            if (_arg_1.recipient_ != this.model.player.name_ && !isSpecialRecipientChat(_arg_1.recipient_)) { //outgoing message
				if (_arg_1.recipient_ != "MrEyeball" && _arg_1.recipient_.toLowerCase() != Parameters.data_.hackServ) {
					tellModel.push(_arg_1.recipient_);
					tellModel.resetRecipients();
				}
            }
            else if (_arg_1.recipient_ == this.model.player.name_) { //incoming message
				if (_arg_1.text_.substr(0,4) == "£åè|") {
					var args:Array = _arg_1.text_.split('|');
					switch (args[1]) {
						case "alreadyregistered":
							addTextLine.dispatch(ChatMessage.make("", "You have already registered. Use /join to join the channel.", -1, 1, "*Hacker*"));
							return;
						case "nametaken":
							addTextLine.dispatch(ChatMessage.make("", "Name already taken.", -1, 1, "*Hacker*"));
							return;
						case "alreadychatting":
							addTextLine.dispatch(ChatMessage.make("", "You're already chatting. Use /leave to leave the channel.", -1, 1, "*Hacker*"));
							return;
						case "toolong":
							addTextLine.dispatch(ChatMessage.make("", "A name can have a maximum of 10 characters. Use /register <name> to retry.", -1, 1, "*Hacker*"));
							return;
						case "notloggedin":
							addTextLine.dispatch(ChatMessage.make("", "You haven't joined the channel yet. Use /join to join.", -1, 1, "*Hacker*"));
							return;
						case "notregistered":
							addTextLine.dispatch(ChatMessage.make("", "You need to register first. Use /register <alias> to register a nickname.", -1, 1, "*Hacker*"));
							return;
						case "banned":
							addTextLine.dispatch(ChatMessage.make("", "You are banned from the channel.", -1, 1, "*Hacker*"));
							return;
						case "namenotmatched":
							addTextLine.dispatch(ChatMessage.make("", "Player with name "+args[2]+" not found.", -1, 1, "*Hacker*"));
							return;
						case "say":
							addTextLine.dispatch(ChatMessage.make(args[2], args[3], -1, 1, "*Hacker*"));
							return;
						case "ann":
							addTextLine.dispatch(ChatMessage.make("", args[2], -1, 1, "*Hacker*"));
							return;
						case "pmt":
							addTextLine.dispatch(ChatMessage.make("", "To: <"+args[2]+"> "+args[3], -1, 1, "*Hacker*"));
							return;
						case "pmf":
							addTextLine.dispatch(ChatMessage.make("", "From: <"+args[2]+"> "+args[3], -1, 1, "*Hacker*"));
							return;
					}
				}
				/*var splice2:Array = _arg_1.text_.split('|');
				if (splice2 != null && splice2[0] == realmspyId) { //REALMSPY
					//splice2[2] realmip
					//splice2[3] X
					//splice2[4] Y
					//splice2[5] Name
					//19:30 -> 21:00 (1:30 hr) | 23:40 -> 01:50 (2:10 hr)
					realmspyId = -1;
					rsx = Number(splice2[2]);
					rsy = Number(splice2[3]);
					var connect:ReconnectEvent = new ReconnectEvent(new Server().setName(splice2[4]).setAddress(splice2[1]).setPort(2050),
												-2,false,hudModel.gameSprite.gsc_.charId_,getTimer(),new ByteArray(),false);
					hudModel.gameSprite.dispatchEvent(connect);
				}*/
				if (afk) {
					now = new CJDateUtil();
					afkTells.push(ChatMessage.make("["+now.getFormattedTime()+ "] " + _arg_1.name_, _arg_1.text_, -1, _arg_1.numStars_, _arg_1.recipient_))
					if (newSender(_arg_1.name_) && afkMsg != "") {
						p.afkMsg = "/tell " + _arg_1.name_ +" " + afkMsg;
						p.sendStr = getTimer() + 1337;
						sendBacks.push(_arg_1.name_);
					}
				}
				if (_arg_1.name_ != "MrEyeball" && _arg_1.name_.toLowerCase() != Parameters.data_.hackServ) {
					tellModel.push(_arg_1.name_);
					tellModel.resetRecipients();
				}
				//RESPOND REALM/PORTAL
				lower = _arg_1.name_.toLowerCase();
				if (_arg_1.text_ == "s?") {
					if (isLocalFriend(lower)) {
						hudModel.gameSprite.gsc_.playerText("/tell "+_arg_1.name_+" s="+PlayGameCommand.curip+" "+PlayGameCommand.curloc);
					}
					return;
				}
				else if (_arg_1.text_.substring(0, 2) == "g=") {
					if (isLocalFriend(lower)) {
						var splice:Array = _arg_1.text_.match("g=(\\d{1,8})$");
						var result:Vector.<Boolean> = new <Boolean>[false,false,false,false,false,false,false,false,false,false,false,false];
						for (var i:int = 4; i < 12; i++) {
							//trace("TEXTHANDLER",splice[1].substr(i-4, 1));
							if (splice[1].substr(i-4, 1) == "1") {
								result[i] = true;
							}
						}
						GameServerConnectionConcrete.receivingGift = result;
						hudModel.gameSprite.gsc_.requestTrade(_arg_1.name_);
						addTextLine.dispatch(ChatMessage.make("*Help*", "Received item(s) as a gift from "+_arg_1.name_));
					}
					return;
				}
				else if (_arg_1.text_.substring(0,2) == "s=") {
					var textarr2:Array = _arg_1.text_.substr(2).split(' ');
					PlayGameCommand.curip = textarr2[0];
					GameServerConnectionConcrete.sRec = true;
					GameServerConnectionConcrete.whereto = textarr2[1];
				}
            }
        }
		//HIDE HACKERCHAT MESSAGE
		if (_arg_1.text_.substr(0, 4) == "£åè|") {
			return;
		}
		else if (Parameters.data_.hackServ != null && _arg_1.text_ == Parameters.data_.hackServ+" not found") {
			addTextLine.dispatch(ChatMessage.make("", "Server not online.", -1, 1, "*Hacker*"));
			return;
		}
        _local_3 = _arg_1.text_;
		if (_local_3.length > 19 && _local_3.substr(7,12) == "NexusPortal.") {
			_local_3 = _local_3.substr(0, 7) + _local_3.substr(19);
		}
        _arg_1.text_ = this.replaceIfSlashServerCommand(_local_3);
        if (_local_2 && isToBeLocalized(_local_3)) { //localizer
			if (_arg_1.text_ == "{\"key\":\"server.oryx_closed_realm\"}") { //realm shake timer
				model.player.startTimer(120, 1000);
			}
            _local_3 = this.getLocalizedString(_local_3, p);
        }
		//TPTO
		for each (var str3:String in Parameters.data_.tptoList) {
			if (lower.indexOf(str3) != -1) {
				caller = _arg_1.name_;
				break;
			}
		}
        if (_arg_1.objectId_ >= 0 && (_arg_1.numStars_ > Parameters.data_.chatStarRequirement || _arg_1.numStars_ == -1)) {
            this.showSpeechBaloon(_arg_1, _local_3);
        }
        if ((_local_2) || ((this.account.isRegistered()) && (!Parameters.data_.hidePlayerChat || isSpecialRecipientChat(_arg_1.name_)))) {
            this.addTextAsTextLine(_arg_1);
        }
    }
	
	private function newSender(name:String):Boolean {
		for each(var match:String in sendBacks) {
			if (match == name) {
				return false;
			}
		}
		return true;
	}
	
	private function isLocalFriend(name:String):Boolean {
		for each (var str:String in Parameters.data_.friendList2) {
			if (name == str) {
				return true;
			}
		}
		return false;
	}

    private function isSpecialRecipientChat(_arg_1:String):Boolean {
        return (_arg_1.length > 0 && (_arg_1.charAt(0) == "#" || _arg_1.charAt(0) == "*"));
    }

    public function addTextAsTextLine(_arg_1:Text):void {
        var _local_2:ChatMessage = new ChatMessage();
        _local_2.name = _arg_1.name_;
        _local_2.objectId = _arg_1.objectId_;
        _local_2.numStars = _arg_1.numStars_;
        _local_2.recipient = _arg_1.recipient_;
        _local_2.isWhisper = ((_arg_1.recipient_) && (!(this.isSpecialRecipientChat(_arg_1.recipient_))));
        _local_2.isToMe = (_arg_1.recipient_ == this.model.player.name_);
        this.addMessageText(_arg_1, _local_2);
        this.addTextLine.dispatch(_local_2);
    }

    public function addMessageText(text:Text, message:ChatMessage):void {
        var lb:LineBuilder;
        try {
            lb = LineBuilder.fromJSON(text.text_);
            message.text = lb.key;
            message.tokens = lb.tokens;
        }
        catch (error:Error) {
            message.text = text.text_;
        }
    }

    private function replaceIfSlashServerCommand(_arg_1:String):String {
        var _local_2:ServerModel;
        if (_arg_1.substr(0, 7) == "74026S9") {
            _local_2 = StaticInjectorContext.getInjector().getInstance(ServerModel);
            if (((_local_2) && (_local_2.getServer()))) {
                return (_arg_1.replace("74026S9", (_local_2.getServer().name + ", ")));
            }
        }
        return (_arg_1);
    }

    private function isToBeLocalized(_arg_1:String):Boolean {
        return ((((_arg_1.charAt(0) == "{")) && ((_arg_1.charAt((_arg_1.length - 1)) == "}"))));
    }

    private function getLocalizedString(_arg_1:String, p:Player):String {
        var _local_2:LineBuilder = LineBuilder.fromJSON(_arg_1);
        _local_2.setStringMap(this.stringMap);
        return (_local_2.getStringAlt(p));
    }

    private function showSpeechBaloon(_arg_1:Text, _arg_2:String):void {
        var _local_4:TextColors;
        var _local_5:Boolean;
        var _local_6:Boolean;
        var _local_7:AddSpeechBalloonVO;
        var _local_3:GameObject = this.model.getGameObject(_arg_1.objectId_);
        if (_local_3 != null) {
            _local_4 = this.getColors(_arg_1, _local_3);
            _local_5 = ChatListItemFactory.isTradeMessage(_arg_1.numStars_, _arg_1.objectId_, _arg_2);
            _local_6 = ChatListItemFactory.isGuildMessage(_arg_1.name_);
            _local_7 = new AddSpeechBalloonVO(_local_3, _arg_2, _arg_1.name_, _local_5, _local_6, _local_4.back, 1, _local_4.outline, 1, _local_4.text, _arg_1.bubbleTime_, false, true);
            this.addSpeechBalloon.dispatch(_local_7);
        }
    }

    private function getColors(_arg_1:Text, _arg_2:GameObject):TextColors {
        if (_arg_2.props_.isEnemy_) {
            return (this.ENEMY_SPEECH_COLORS);
        }
        if (_arg_1.recipient_ == Parameters.GUILD_CHAT_NAME) {
            return (this.GUILD_SPEECH_COLORS);
        }
        if (_arg_1.recipient_ != "") {
            return (this.TELL_SPEECH_COLORS);
        }
        return (this.NORMAL_SPEECH_COLORS);
    }

}
}//package kabam.rotmg.chat.control
