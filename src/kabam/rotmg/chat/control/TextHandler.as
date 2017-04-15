package kabam.rotmg.chat.control {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.TextureDataConcrete;
import com.company.assembleegameclient.parameters.Parameters;
import kabam.rotmg.game.commands.PlayGameCommand;
import kabam.rotmg.messaging.impl.GameServerConnectionConcrete;

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

public class TextHandler {

    private const NORMAL_SPEECH_COLORS:TextColors = new TextColors(14802908, 0xFFFFFF, 0x545454);
    private const ENEMY_SPEECH_COLORS:TextColors = new TextColors(5644060, 16549442, 13484223);
    private const TELL_SPEECH_COLORS:TextColors = new TextColors(2493110, 61695, 13880567);
    private const GUILD_SPEECH_COLORS:TextColors = new TextColors(0x3E8A00, 10944349, 13891532);
	public static var caller:String = "";

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


    public function execute(_arg_1:Text):void {
        var _local_3:String;
        var _local_4:String;
        var _local_5:String;
		var lower:String;
        var _local_2:Boolean = _arg_1.numStars_ == -1; //|| _arg_1.objectId_ == -1
		var p:Player = hudModel.gameSprite.map.player_;
		if (_local_2 && p.objectType_ == 775 && _arg_1.text_ == "EYE see you!") {
			hudModel.gameSprite.mui_.handlePerfectAim(p); //auto paralyze avatar eyes
		}
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
        if (_arg_1.numStars_ <= Parameters.data_.chatStarRequirement && _arg_1.name_ != model.player.name_ && !_local_2 && _arg_1.recipient_ == "" && !isSpecialRecipientChat(_arg_1.recipient_)) {
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
            if (_arg_1.recipient_ != this.model.player.name_ && !isSpecialRecipientChat(_arg_1.recipient_)) {
				if (_arg_1.recipient_ != "MrEyeball") {
					tellModel.push(_arg_1.recipient_);
					tellModel.resetRecipients();
				}
            }
            else if (_arg_1.recipient_ == this.model.player.name_) {
				if (_arg_1.name_ != "MrEyeball") {
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
        if (this.useCleanString(_arg_1)) {
            _local_3 = _arg_1.cleanText_;
			if (_local_3.length > 19 && _local_3.substr(7,12) == "NexusPortal.") {
				_local_3 = _local_3.substr(0, 7) + _local_3.substr(19);
			}
            _arg_1.cleanText_ = this.replaceIfSlashServerCommand(_local_3);
        }
        else {
            _local_3 = _arg_1.text_;
			if (_local_3.length > 19 && _local_3.substr(7,12) == "NexusPortal.") {
				_local_3 = _local_3.substr(0, 7) + _local_3.substr(19);
			}
            _arg_1.text_ = this.replaceIfSlashServerCommand(_local_3);
        }
        if (_local_2 && isToBeLocalized(_local_3)) { //localizer
			if (_arg_1.text_ == "{\"key\":\"server.oryx_closed_realm\"}") { //realm shake timer
				model.player.startTimer(120, 1000);
			}
            _local_3 = this.getLocalizedString(_local_3);
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
            message.text = ((useCleanString(text)) ? text.cleanText_ : text.text_);
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

    private function getLocalizedString(_arg_1:String):String {
        var _local_2:LineBuilder = LineBuilder.fromJSON(_arg_1);
        _local_2.setStringMap(this.stringMap);
        return (_local_2.getString());
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

    private function useCleanString(_arg_1:Text):Boolean {
        return (((((Parameters.data_.filterLanguage) && ((_arg_1.cleanText_.length > 0)))) && (!((_arg_1.objectId_ == this.model.player.objectId_)))));
    }

}
}//package kabam.rotmg.chat.control
