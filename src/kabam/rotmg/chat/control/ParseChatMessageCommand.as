package kabam.rotmg.chat.control {
import com.company.assembleegameclient.map.AbstractMap;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.menu.FindMenu;
import flash.events.TimerEvent;
import flash.external.ExternalInterface;
import flash.net.FileReference;
import flash.net.URLRequest;
import flash.utils.Dictionary;
import flash.utils.Timer;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.servers.api.Server;
import kabam.rotmg.ui.signals.NameChangedSignal;
import kabam.rotmg.ui.view.CharacterDetailsView;

import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.ui.model.HUDModel;
import com.company.assembleegameclient.game.MapUserInput;
import com.company.assembleegameclient.objects.ObjectLibrary;
import kabam.rotmg.messaging.impl.GameServerConnectionConcrete;

import com.company.assembleegameclient.game.events.ReconnectEvent;
import com.company.assembleegameclient.parameters.Parameters;
import flash.display.DisplayObject;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.net.navigateToURL;
import kabam.rotmg.game.commands.PlayGameCommand;
import flash.utils.getTimer;

public class ParseChatMessageCommand {

    [Inject]
    public var data:String;
    [Inject]
    public var hudModel:HUDModel;
    [Inject]
    public var addTextLine:AddTextLineSignal;
	[Inject]
	public var openDialog:OpenDialogSignal;
	
	private var itemnames:Array = new Array("life","mana","def","att","wis","vit","dex","spd");
	private var itemids:Array = new Array("2793","2794","2592","2591","2613","2612","2636","2593");
	private static var lastMsg:String = "";
	private static var lastTell:String = "";
	private static var lastTellTo:String = "";
	private static var slot:int = -1;
	
	private static var needed:String;
	public static var switch_:Boolean = false;

    private function fsCommands(param1:String):Boolean {
        param1 = param1.toLowerCase();
        var _loc2_:DisplayObject = Parameters.root;
        if (param1 == "/fs")
        {
            if (_loc2_.stage.scaleMode == StageScaleMode.EXACT_FIT) {
                _loc2_.stage.scaleMode = StageScaleMode.NO_SCALE;
                Parameters.data_.stageScale = StageScaleMode.NO_SCALE;
				addTextLine.dispatch(ChatMessage.make("*Help*","Fullscreen: On"));
            }
            else {
                _loc2_.stage.scaleMode = StageScaleMode.EXACT_FIT;
                Parameters.data_.stageScale = StageScaleMode.EXACT_FIT;
				addTextLine.dispatch(ChatMessage.make("*Help*","Fullscreen: Off"));
            }
            Parameters.save();
            _loc2_.dispatchEvent(new Event(Event.RESIZE));
            return true;
        }
        if (param1 == "/mscale") {
            addTextLine.dispatch(ChatMessage.make("*Help*","Map Scale: " + Parameters.data_.mscale + " - Usage: /mscale <any decimal number>."));
            return true;
        }
        var _loc3_:Array = param1.match("/mscale (\\d*\\.*\\d+)$");
        if(_loc3_ != null) {
            Parameters.data_.mscale = _loc3_[1];
            Parameters.save();
            _loc2_.dispatchEvent(new Event(Event.RESIZE));
            addTextLine.dispatch(ChatMessage.make("*Help*","Map Scale: " + _loc3_[1]));
            return true;
        }
        if (param1 == "/scaleui") {
            Parameters.data_.uiscale = !Parameters.data_.uiscale;
            Parameters.save();
            _loc2_.dispatchEvent(new Event(Event.RESIZE));
            addTextLine.dispatch(ChatMessage.make("*Help*","Scale UI: " + Parameters.data_.uiscale));
            return true;
        }
        return false;
    }
    
    private function aimAssistCommands():Boolean {
        var _loc1_:Array = null;
        var _loc2_:Boolean = false;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        _loc1_ = data.toLowerCase().match("/aex (\\d+)$");
        if(_loc1_ != null)
        {
            _loc2_ = false;
            for each(_loc3_ in Parameters.data_.AAException)
            {
                if(_loc3_ == _loc1_[1])
                {
                    _loc2_ = true;
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " (" + (ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined ? ObjectLibrary.xmlLibrary_[_loc1_[1]].@id:"") + ") already exists in exception list."));
                    break;
                }
            }
            if(_loc2_ == false)
            {
                if(ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined)
                {
                    Parameters.data_.AAException.push(_loc1_[1]);
                    addTextLine.dispatch(ChatMessage.make("*Help*","Added " + _loc1_[1] + " (" + ObjectLibrary.xmlLibrary_[_loc1_[1]].@id + ") to exception list."));
                }
                else
                {
                    addTextLine.dispatch(ChatMessage.make("*Help*","No mob has the type " + _loc1_[1] + "."));
                }
            }
            Parameters.save();
            return true;
        }
        _loc1_ = data.toLowerCase().match("/aig (\\d+)$");
        if(_loc1_ != null)
        {
            _loc2_ = false;
            for each(_loc3_ in Parameters.data_.AAIgnore)
            {
                if(_loc3_ == _loc1_[1])
                {
                    _loc2_ = true;
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " (" + (ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined?ObjectLibrary.xmlLibrary_[_loc1_[1]].@id:"") + ") already exists in ignore list."));
                    break;
                }
            }
            if(_loc2_ == false)
            {
                if(ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined)
                {
                    Parameters.data_.AAIgnore.push(_loc1_[1]);
                    addTextLine.dispatch(ChatMessage.make("*Help*","Added " + _loc1_[1] + " (" + ObjectLibrary.xmlLibrary_[_loc1_[1]].@id + ") to ignore list."));
                }
                else
                {
                    addTextLine.dispatch(ChatMessage.make("*Help*","No mob has the type " + _loc1_[1] + "."));
                }
            }
            Parameters.save();
            return true;
        }
        _loc1_ = data.toLowerCase().match("/asp (.+)$");
        if(_loc1_ != null)
        {
            _loc2_ = false;
            for each(_loc3_ in Parameters.data_.spamFilter)
            {
                if(_loc3_ == _loc1_[1])
                {
                    _loc2_ = true;
                    addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] +"\" already being filtered out."));
                    break;
                }
            }
            if(_loc2_ == false)
            {
                Parameters.data_.spamFilter.push(_loc1_[1]);
                addTextLine.dispatch(ChatMessage.make("*Help*","Added \"" + _loc1_[1] + "\" to spamfilter list."));
            }
            Parameters.save();
            return true;
        }
        _loc1_ = data.toLowerCase().match("/afr (\\w+)$");
        if(_loc1_ != null)
        {
            _loc2_ = false;
            for each(_loc3_ in Parameters.data_.friendList2)
            {
                if(_loc3_ == _loc1_[1])
                {
                    _loc2_ = true;
                    addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] +"\" already exists in friend list."));
                    break;
                }
            }
            if(_loc2_ == false)
            {
                Parameters.data_.friendList2.push(_loc1_[1]);
                addTextLine.dispatch(ChatMessage.make("*Help*","Added \"" + _loc1_[1] + "\" to friend list."));
            }
            Parameters.save();
            return true;
        }
        _loc1_ = data.toLowerCase().match("/atp (\\w+)$");
        if(_loc1_ != null)
        {
            _loc2_ = false;
            for each(_loc3_ in Parameters.data_.tptoList)
            {
                if(_loc3_ == _loc1_[1])
                {
                    _loc2_ = true;
                    addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] +"\" already exists in teleport keyword list."));
                    break;
                }
            }
            if(_loc2_ == false)
            {
                Parameters.data_.tptoList.push(_loc1_[1]);
                addTextLine.dispatch(ChatMessage.make("*Help*","Added \"" + _loc1_[1] + "\" to teleport keyword list."));
            }
            Parameters.save();
            return true;
        }
        _loc1_ = data.toLowerCase().match("/rig (\\d+)$");
        if(_loc1_ != null)
        {
            _loc2_ = false;
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.AAIgnore.length)
            {
                if(Parameters.data_.AAIgnore[_loc4_] == _loc1_[1])
                {
                    _loc2_ = true;
                    Parameters.data_.AAIgnore.splice(_loc4_,1);
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " (" + (ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined?ObjectLibrary.xmlLibrary_[_loc1_[1]].@id:"") + ") removed from ignore list."));
                    break;
                }
                _loc4_++;
            }
            if(_loc2_ == false)
            {
                if(ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined)
                {
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " (" + ObjectLibrary.xmlLibrary_[_loc1_[1]].@id + ") not found in ignore list."));
                }
                else
                {
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " not found in ignore list."));
                }
            }
            Parameters.save();
            return true;
        }
        _loc1_ = data.toLowerCase().match("/rex (\\d+)$");
        if(_loc1_ != null)
        {
            _loc2_ = false;
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.AAException.length)
            {
                if(Parameters.data_.AAException[_loc4_] == _loc1_[1])
                {
                    _loc2_ = true;
                    Parameters.data_.AAException.splice(_loc4_,1);
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " (" + (ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined?ObjectLibrary.xmlLibrary_[_loc1_[1]].@id:"") + ") removed from exception list."));
                    break;
                }
                _loc4_++;
            }
            if(_loc2_ == false)
            {
                if(ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined)
                {
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " (" + ObjectLibrary.xmlLibrary_[_loc1_[1]].@id + ") not found in exception list."));
                }
                else
                {
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " not found in exception list."));
                }
            }
            Parameters.save();
            return true;
        }
        _loc1_ = data.toLowerCase().match("/rsp (.+)$");
        if(_loc1_ != null)
        {
            _loc2_ = false;
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.spamFilter.length)
            {
                if(Parameters.data_.spamFilter[_loc4_] == _loc1_[1])
                {
                    _loc2_ = true;
                    Parameters.data_.spamFilter.splice(_loc4_,1);
                    addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] + "\" removed from spamfilter list."));
                    break;
                }
                _loc4_++;
            }
            if(_loc2_ == false)
            {
                addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] + "\" not found in spamfilter list."));
            }
            Parameters.save();
            return true;
        }
        _loc1_ = data.toLowerCase().match("/rfr (\\w+)$");
        if(_loc1_ != null)
        {
            _loc2_ = false;
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.friendList2.length)
            {
                if(Parameters.data_.friendList2[_loc4_] == _loc1_[1])
                {
                    _loc2_ = true;
                    Parameters.data_.friendList2.splice(_loc4_,1);
                    addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] + "\" removed from friend list."));
                    break;
                }
                _loc4_++;
            }
            if(_loc2_ == false)
            {
                addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] + "\" not found in friend list."));
            }
            Parameters.save();
            return true;
        }
        _loc1_ = data.toLowerCase().match("/rtp (\\w+)$");
        if(_loc1_ != null)
        {
            _loc2_ = false;
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.tptoList.length)
            {
                if(Parameters.data_.tptoList[_loc4_] == _loc1_[1])
                {
                    _loc2_ = true;
                    Parameters.data_.tptoList.splice(_loc4_,1);
                    addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] + "\" removed from teleport keyword list."));
                    break;
                }
                _loc4_++;
            }
            if(_loc2_ == false)
            {
                addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] + "\" not found in teleport keyword list."));
            }
            Parameters.save();
            return true;
        }
        if(data.toLowerCase() == "/exlist")
        {
            addTextLine.dispatch(ChatMessage.make("*Help*","Auto aim  exception list (" + Parameters.data_.AAException.length + " mobs):"));
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.AAException.length)
            {
                addTextLine.dispatch(ChatMessage.make("*Help*",Parameters.data_.AAException[_loc4_] + " - " + (ObjectLibrary.xmlLibrary_[Parameters.data_.AAException[_loc4_]] != undefined?ObjectLibrary.xmlLibrary_[Parameters.data_.AAException[_loc4_]].@id:"")));
                _loc4_++;
            }
            return true;
        }
        if(data.toLowerCase() == "/iglist")
        {
            addTextLine.dispatch(ChatMessage.make("*Help*","Auto aim ignore list (" + Parameters.data_.AAIgnore.length + " mobs):"));
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.AAIgnore.length)
            {
                addTextLine.dispatch(ChatMessage.make("*Help*",Parameters.data_.AAIgnore[_loc4_] + " - " + (ObjectLibrary.xmlLibrary_[Parameters.data_.AAIgnore[_loc4_]] != undefined?ObjectLibrary.xmlLibrary_[Parameters.data_.AAIgnore[_loc4_]].@id:"")));
                _loc4_++;
            }
            return true;
        }
        if(data.toLowerCase() == "/splist")
        {
            addTextLine.dispatch(ChatMessage.make("*Help*","Spamfilter list (" + Parameters.data_.spamFilter.length + " filtered words):"));
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.spamFilter.length)
            {
                addTextLine.dispatch(ChatMessage.make("*Help*",Parameters.data_.spamFilter[_loc4_]));
                _loc4_++;
            }
            return true;
        }
        if(data.toLowerCase() == "/frlist")
        {
            addTextLine.dispatch(ChatMessage.make("*Help*","Friend list (" + Parameters.data_.friendList2.length + " friends):"));
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.friendList2.length)
            {
                addTextLine.dispatch(ChatMessage.make("*Help*",Parameters.data_.friendList2[_loc4_]));
                _loc4_++;
            }
            return true;
        }
        if(data.toLowerCase() == "/tplist")
        {
            addTextLine.dispatch(ChatMessage.make("*Help*","Teleport keyword list (" + Parameters.data_.tptoList.length + " keywords):"));
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.tptoList.length)
            {
                addTextLine.dispatch(ChatMessage.make("*Help*",Parameters.data_.tptoList[_loc4_]));
                _loc4_++;
            }
            return true;
        }
        if(data.toLowerCase() == "/igclear")
        {
            Parameters.data_.AAIgnore = new Array();
            addTextLine.dispatch(ChatMessage.make("*Help*","Auto aim ignore list cleared."));
            Parameters.save();
            return true;
        }
        if(data.toLowerCase() == "/exclear")
        {
            Parameters.data_.AAException = new Array();
            addTextLine.dispatch(ChatMessage.make("*Help*","Auto aim exception list cleared."));
            Parameters.save();
            return true;
        }
        if(data.toLowerCase() == "/spclear")
        {
            Parameters.data_.spamFilter = new Array();
            addTextLine.dispatch(ChatMessage.make("*Help*","Spamfilter list cleared."));
            Parameters.save();
            return true;
        }
        if(data.toLowerCase() == "/frclear")
        {
            Parameters.data_.friendList2 = new Array();
            addTextLine.dispatch(ChatMessage.make("*Help*","Friend list cleared."));
            Parameters.save();
            return true;
        }
        if(data.toLowerCase() == "/tpclear")
        {
            Parameters.data_.tptoList = new Array();
            addTextLine.dispatch(ChatMessage.make("*Help*","Teleport keyword list cleared."));
            Parameters.save();
            return true;
        }
        if(data.toLowerCase() == "/igdefault")
        {
            Parameters.data_.AAIgnore = [1550,1551,1552,1619,1715,2309,2310,2311,2371,3441,2312,2313,2370,2392,2393,2400,2401,3335,3336,3337,3338,3413,3418,3419,3420,3421,3427,3454,3638,3645,6157,28715,28716,28717,28718,28719,28730,28731,28732,28733,28734,29306,29568,29594,29597,29710,29711,29742,29743,29746,29748,30001];
            addTextLine.dispatch(ChatMessage.make("*Help*","Default ignore list restored."));
            Parameters.save();
            return true;
        }
        if(data.toLowerCase() == "/exdefault")
        {
            Parameters.data_.AAException = [3448,3449,3472,3334,5952,2354,2369,3368,3366,3367,3391,3389,3390,5920,2314,3412,3639,3634,2327,2335,2336,1755,24582,24351,24363,24135,24133,24134,24132,24136,3356,3357,3358,3359,3360,3361,3362,3363,3364,2352,28780,28781,28795,28942,28957,28988,28938,29291,29018,29517,24338,29580,29712,6282,0x717e,0x727c,0x727d,0x736e,0x736f,0x724a,0x724b,0x724c,0x724d,0x724e];
            addTextLine.dispatch(ChatMessage.make("*Help*","Default exception list restored."));
            Parameters.save();
            return true;
        }
        if(data.toLowerCase() == "/spdefault")
        {
            Parameters.data_.spamFilter = ["realmk!ngs", "oryx.ln", "realmpower.net", "oryxsh0p.net", "lifepot. org"];
            addTextLine.dispatch(ChatMessage.make("*Help*","Default spamfilter list restored."));
            Parameters.save();
            return true;
        }
        if(data.toLowerCase() == "/tpdefault")
        {
            Parameters.data_.tptoList = ["lab","manor", "sewer"];
            addTextLine.dispatch(ChatMessage.make("*Help*","Default teleport keyword list restored."));
            Parameters.save();
            return true;
        }
        return false;
    }
    
    private function cjCommands() : Boolean
    {
		var i:int;
		switch (data.toLowerCase()) {
			/*case "/list":
				var file:FileReference = new FileReference();
				var savedata:String = "";
				var addr:Array = PlayGameCommand.visited;
				for each (var str:String in addr) {
					savedata += str+"\n";
				}
				file.save(savedata, 'addr.txt');
				return true;*/
			case "/serv":
				hudModel.gameSprite.gsc_.playerText("/server");
				return true;
			case "/hide":
				hudModel.gameSprite.gsc_.playerText("/tell mreyeball hide me");
				return true;
			case "/friends":
				hudModel.gameSprite.gsc_.playerText("/tell mreyeball friends");
				return true;
			case "/l2m":
			case "/left2max":
			case "/lefttomax":
				needed = "You need ";
				var youre88:Boolean = true;
				var p:Player = hudModel.gameSprite.map.player_;
				var diffs:Array = new Array(
						int((p.maxHPMax_ - p.maxHP_ + p.maxHPBoost_) / 5 + ((p.maxHPMax_ - p.maxHP_ + p.maxHPBoost_) % 5 > 0 ? 1 : 0)), 
						int((p.maxMPMax_ - p.maxMP_ + p.maxMPBoost_) / 5 + ((p.maxMPMax_ - p.maxMP_ + p.maxMPBoost_) % 5 > 0 ? 1 : 0)), 
						p.attackMax_ - p.attack_ + p.attackBoost_, 
						p.defenseMax_ - p.defense_ + p.defenseBoost_, 
						p.speedMax_ - p.speed_ + p.speedBoost_, 
						p.dexterityMax_ - p.dexterity_ + p.dexterityBoost_, 
						p.vitalityMax_ - p.vitality_ + p.vitalityBoost_, 
						p.wisdomMax_ - p.wisdom_ + p.wisdomBoost_
				);
				var statabbr:Array = new Array("Life", "Mana", "ATT", "DEF", "SPD", "DEX", "VIT", "WIS");
				for (var j:int = 0; j < diffs.length; j++) {
					if (diffs[j] > 0) {
						needed += diffs[j] + " " + statabbr[j]+ ", ";
						youre88 = false;
					}
				}
				needed = youre88 ? "You're maxed" : needed.substr(0, needed.length - 2) + " to be maxed";
				addTextLine.dispatch(ChatMessage.make("*Help*", needed));
				return true;
			case "/stats":
			case "/roll":
				hudModel.gameSprite.gsc_.playerText("/tell mreyeball stats");
				return true;
			case "/mates":
				hudModel.gameSprite.gsc_.playerText("/tell mreyeball mates");
				return true;
			case "/tut":
			//case "/tutorial":
				hudModel.gameSprite.gsc_.playerText("/nexustutorial");
				return true;
			case "/tr":
				hudModel.gameSprite.gsc_.playerText("/trade "+lastTellTo);
				return true;
			case "/fame":
				var playTime:int = (getTimer() - PlayGameCommand.startTime) / 60000;
				var fpm:Number;
				if (playTime == 0) {
					fpm = GameServerConnectionConcrete.totalfamegain;
				}
				else {
					fpm = Math.round(GameServerConnectionConcrete.totalfamegain / playTime * 100) / 100;
				}
				hudModel.gameSprite.map.player_.notifyPlayer(GameServerConnectionConcrete.totalfamegain+" fame\n"+playTime+" minutes\n"+fpm+" fame/min", 0xE25F00, 3000);
				return true;
			case "/s":
			case "/switch":
			case "/swap":
				if (hudModel.gameSprite.map.player_.hasBackpack_) {
					switch_ = true;
				}
				else {
					addTextLine.dispatch(ChatMessage.make("*Help*","Whoa, that was close! Your items almost disappeared."));
				}
				return true;
			case "/unname":
			case "/name":
				Parameters.data_.fakeName = null;
				Parameters.save();
				hudModel.gameSprite.hudView.characterDetails.setName(hudModel.gameSprite.map.player_.name_);
				return true;
		}
		var splice:Array = data.toLowerCase().match("/player (\\w+)$")
		if (splice != null) {
			navigateToURL(new URLRequest("https://www.realmeye.com/player/" + splice[1]), "_blank");
			return true;
		}
		splice = data.toLowerCase().match("/sell (\\w{3,4}) (\\w{3,4})$");
		if (splice != null) {
			var id1:String;
			var id2:String;
			for (i = 0; i < itemnames.length; i++) {
				if (itemnames[i] == splice[1]) {
					id1 = itemids[i];
				}
				else if (itemnames[i] == splice[2]) {
					id2 = itemids[i];
				}
			}
			if (id1 != null && id2 != null) {
				navigateToURL(new URLRequest("https://www.realmeye.com/offers-to/buy/" + id1 + "/" + id2), "_blank");
				return true;
			}
		}
		splice = data.toLowerCase().match("/sell (\\d{1,2})$"); //incl backpack
		if (splice != null) {
			var slot:int = int(splice[1]) + 3;
			navigateToURL(new URLRequest("https://www.realmeye.com/offers-to/buy/" + GameServerConnectionConcrete.PLAYER_.equipment_[slot] + "/2793"), "_blank");
			return true;
		}
		splice = data.toLowerCase().match("^/re$");
		if (splice != null) {
			hudModel.gameSprite.gsc_.playerText(lastMsg);
			return true;
		}
		splice = data.toLowerCase().match("/re (\\w+)$");
		if (splice != null) {
			var newMsg:String = "/tell " + splice[1] + " " + lastTell;
			hudModel.gameSprite.gsc_.playerText(newMsg);
			lastTellTo = splice[1];
			lastMsg = newMsg;
			return true;
		}
		splice = data.match("/name (.+)$");
		if (splice != null) {
			Parameters.data_.fakeName = splice[1];
			Parameters.save();
			hudModel.gameSprite.hudView.characterDetails.setName("");
			return true;
		}
		splice = data.match("/timer (\\d+) (\\d+)$");
		if (splice != null) {
			hudModel.gameSprite.map.player_.startTimer(splice[1], splice[2]);
			return true;
		}
		splice = data.match("/autopot (\\d+)$");
		if (splice != null) {
			Parameters.data_.autoPot = splice[1];
			Parameters.save();
            addTextLine.dispatch(ChatMessage.make("*Help*","Auto pot percentage set to "+splice[1]));
			return true;
		}
		splice = data.match("/autonex (\\d+)$");
		if (splice != null) {
			Parameters.data_.AutoNexus = splice[1];
			Parameters.save();
            addTextLine.dispatch(ChatMessage.make("*Help*","Auto nexus percentage set to "+splice[1]));
			return true;
		}
		splice = data.match("/autoheal (\\d+)$");
		if (splice != null) {
			Parameters.data_.autoHealP = splice[1];
			Parameters.save();
            addTextLine.dispatch(ChatMessage.make("*Help*","Auto heal percentage set to "+splice[1]));
			return true;
		}
		splice = data.match("/give (\\w+) (\\d{1,8})$");
		//splice = data.match("/give (\\w+) ([0-1])?([0-1])?([0-1])?([0-1])?([0-1])?([0-1])?([0-1])?([0-1])$"); //such efficiency
		if (splice != null) {
			hudModel.gameSprite.gsc_.playerText("/tell "+splice[1]+" g="+splice[2]);
			hudModel.gameSprite.gsc_.requestTrade(splice[1]);
			var result:Vector.<Boolean> = new <Boolean>[false,false,false,false,false,false,false,false,false,false,false,false];
			for (i = 4; i < 12; i++) {
				//trace("PARSECOMMAND",splice[2].substr(i-4, 1));
				if (splice[2].substr(i-4, 1) == "1") {
				//trace("PARSECOMMAND",splice[i+1]);
				//if (splice[i-2] == "1") {
					result[i] = true;
				}
			}
			GameServerConnectionConcrete.sendingGift = result;
			return true;
		}
		/*splice = data.match("/find (\\d+)$");
		if (splice != null) {
			findItem(parseInt(splice[1]));
			return true;
		}*/
		splice = data.match("/find (.+)$");
		if (splice != null) {
			var input:String = splice[1];
			//findItem(ObjectLibrary.idToType_[splice[1]]); //simple way
			//findItem(findMatch(splice[1])); //levenshtein
			var hardcode:Vector.<String> = new <String> ["def", "att", "spd", "dex", "vit", "wis", "ubhp"];
			var hardval:Vector.<int> = new <int>[0xa20, 0xa1f, 0xa21, 0xa4c, 0xa34, 0xa35, 0xba9];
			for (i = 0; i < hardcode.length; i++) {
				if (splice[1] == hardcode[i]) {
					//addTextLine.dispatch(ChatMessage.make("*Help*", "Finding players with " + ObjectLibrary.getIdFromType(hardval[i])));
					findItem(hardval[i]);
					return true;
				}
			}
			findItem(findMatch2(splice[1])); //length-match
			return true;
		}
		/*splice = data.match("/dc (\\w+)$");
		if (splice != null) {
			hudModel.gameSprite.gsc_.playerText("/tell "+splice[1]+" whats that name dude?");
			return true;
		}*/
		splice = data.match("/take (.+)$");
		if (splice != null) {
			hudModel.gameSprite.map.player_.collect = findMatch2(splice[1]);
            addTextLine.dispatch(ChatMessage.make("*Help*","Taking "+ObjectLibrary.getIdFromType(hudModel.gameSprite.map.player_.collect)+"s from vault chests"));
			return true;
		}
		/*splice = data.match("/spam (.+)$");
		if (splice != null) {
			return true;
		}*/
		/*splice = data.match("/b (.+)");
		if (splice != null) {
			ExternalInterface.call("SendFromFlash", "Message", "", splice[1]);
			return true;
		}*/
        return false;
    }
	
	private function findMatch2(input:String):int {
		var splice:Array = input.split(' ');
		var splice2:Array;
		var curStr:String;
		
		var dist2:int = int.MAX_VALUE;
		var temp:int;
		var itemname:String;
		for each(curStr in ObjectLibrary.itemLib) {
			splice2 = curStr.toLowerCase().split(' ');
			temp = scoredMatch(curStr.length, splice, splice2);
			if (temp < dist2) {
				//addTextLine.dispatch(ChatMessage.make("*Help*",temp+" < "+dist2+", so item = "+curStr));
				dist2 = temp;
				itemname = curStr;
			}
		}
        //addTextLine.dispatch(ChatMessage.make("*Help*", "Finding players with " + itemname));
		return ObjectLibrary.idToType_[itemname];
	}
	
	private function scoredMatch(init:int, inpu:Array, comp:Array):int {
		var outer:String;
		var inner:String;
		for each(outer in comp) {
			for each(inner in inpu) {
				if (outer.substr(0,inner.length) == inner) {
					init -= inner.length * 10;
				}
			}
		}
		return init;
	}
	
	/*private function findMatch(input:String):int {
		var dist2:int = int.MAX_VALUE;
		var temp:int;
		var curStr:String;
		var itemname:String;
		for each(curStr in ObjectLibrary.itemLib) {
			temp = levenshtein(input, curStr.toLowerCase());
			if (temp < dist2) {
				addTextLine.dispatch(ChatMessage.make("*Help*",temp+" < "+dist2+", so item = "+curStr));
				dist2 = temp;
				itemname = curStr;
			}
			if (dist2 == 0) {
				break;
			}
		}
        addTextLine.dispatch(ChatMessage.make("*Help*", "Desired item: " + itemname));
		return ObjectLibrary.idToType_[itemname];
	}
	
	private function levenshtein(string_1:String, string_2:String):int {
		var matrix:Array=new Array();
		var dist:int;
		for (var i:int=0; i<=string_1.length; i++) {
			matrix[i]=new Array();
			for (var j:int=0; j<=string_2.length; j++) {
				if (i!=0) {
					matrix[i].push(0);
				} else {
					matrix[i].push(j);
				}
			}
			matrix[i][0]=i;
		}
		for (i=1; i<=string_1.length; i++) {
			for (j=1; j<=string_2.length; j++) {
				if (string_1.charAt(i-1)==string_2.charAt(j-1)) {
					dist=0;
				} else {
					dist=1;
				}
				matrix[i][j]=Math.min(matrix[i-1][j]+1,matrix[i][j-1]+1,matrix[i-1][j-1]+dist);
			}
		}
		return matrix[string_1.length][string_2.length];
	}*/
	
	private function findItem(id:int):void { //TODO show amounts
		var holders:Vector.<Player> = new <Player>[];
		var inv:Vector.<int>;
		var obj:GameObject;
		var i:int;
		var p:Player;
		var map_:AbstractMap = hudModel.gameSprite.map;
		//var h:int = 0;
		var a:int = 0;
		for each(obj in map_.goDict_) {
			if (obj is Player) {
				p = (obj as Player);
				if (p == map_.player_ || !p.nameChosen_) {
					continue;
				}
				inv = p.equipment_;
				//for (i = 4; i < inv.length; i++) {
				for (i = 4; i < 12; i++) {
					if (inv[i] == id) {
						a++;
						//addTextLine.dispatch(ChatMessage.make("*Help*", p.name_ +" has the item."));
					}
				}
				if (a > 0) {
					holders.push(p);
					p.lastAltAttack_ = a;
					a = 0;
					//holders[h] = p;
					//h++;
				}
			}
		}
		if (holders.length > 0) {
			openDialog.dispatch(new FindMenu(hudModel.gameSprite, holders, ObjectLibrary.getIdFromType(id)));
		}
		else {
			addTextLine.dispatch(ChatMessage.make("*Help*", "No one has the item"));
		}
		//addTextLine.dispatch(ChatMessage.make("*Help*", holders.length+" players have the item"));
	}
    
    private function custMessages() : Boolean {
		var splice2:Array = data.match("/setmsg (\\d) (.+)$")
		if (splice2 == null) {
			return false;
		}
		if (splice2[1] == "1") {
			Parameters.data_.msg1 = splice2[2];
		}
		else if (splice2[1] == "2") {
			Parameters.data_.msg2 = splice2[2];
		}
		else if (splice2[1] == "3") {
			Parameters.data_.msg3 = splice2[2];
		}
		addTextLine.dispatch(ChatMessage.make("*Help*","Message #"+splice2[1]+" set to \""+splice2[2]+"\""));
		Parameters.save();
		return true;
	}
    
    private function effCom() : Boolean {
		var splice2:Array = data.match("/eff (\\d) (\\d+) (.+)$")
		if (splice2 == null) {
			return false;
		}
		if (splice2[1] == "1") {
			Parameters.data_.dbPre1[0] = splice2[3];
			Parameters.data_.dbPre1[1] = parseInt(splice2[2]);
			Parameters.data_.dbPre1[2] = false;
		}
		else if (splice2[1] == "2") {
			Parameters.data_.dbPre2[0] = splice2[3];
			Parameters.data_.dbPre2[1] = parseInt(splice2[2]);
			Parameters.data_.dbPre2[2] = false;
		}
		else if (splice2[1] == "3") {
			Parameters.data_.dbPre2[0] = splice2[3];
			Parameters.data_.dbPre2[1] = parseInt(splice2[2]);
			Parameters.data_.dbPre3[2] = false;
		}
		addTextLine.dispatch(ChatMessage.make("*Help*","A new preset was created for effect ID "+splice2[2]));
		Parameters.save();
		return true;
	}

    public function execute():void {
	
        if(aimAssistCommands())
        {
            return;
        }
        else if(cjCommands())
        {
            return;
        }
        else if(custMessages())
        {
            return;
        }
        else if(effCom())
        {
            return;
        }
        else if(this.fsCommands(this.data))
        {
            return;
        }
        else if (this.data == "/help") {
            this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, TextKey.HELP_COMMAND));
        }
        else {
			var splice:Array = data.match("/tell (\\w+) (.+)");
			if (splice != null) {
				lastTellTo = splice[1];
				lastTell = splice[2];
			} //send message even if it matches above
			lastMsg = data;
			this.hudModel.gameSprite.gsc_.playerText(data); //send message as normal
        }
        /*else {
			lastMsg = data;
            this.hudModel.gameSprite.gsc_.playerText(data);
        }*/
        /*switch(this.data)
        {
			case aimAssistCommands():
				break;
            case "/help":
                this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME,TextKey.HELP_COMMAND));
                break;
            default:
                this.hudModel.gameSprite.gsc_.playerText(this.data);
		}*/
    }
}
}//package kabam.rotmg.chat.control
