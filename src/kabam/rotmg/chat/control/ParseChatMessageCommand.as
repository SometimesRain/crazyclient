package kabam.rotmg.chat.control {
import com.company.assembleegameclient.map.AbstractMap;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.menu.FindMenu;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.CJDateUtil;
import flash.events.TimerEvent;
import flash.external.ExternalInterface;
import flash.net.FileReference;
import flash.net.URLRequest;
import flash.utils.Dictionary;
import flash.utils.Timer;
import kabam.rotmg.assets.EmbeddedData;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.friends.view.FriendListView;
import kabam.rotmg.messaging.impl.GameServerConnection;
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
	
	private static var lastMsg:String = "";
	private static var lastTell:String = "";
	private static var lastTellTo:String = "";
	private static var slot:int = -1;
	
	private static var needed:String;
	public static var switch_:Boolean = false;
	
	private static var afkStart:CJDateUtil;

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
        var _loc3_:Array = param1.match("^/mscale (\\d*\\.*\\d+)$");
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
	
    private function listCommands():Boolean {
		var lower:String = data.toLowerCase();
		return addCommands(lower) || remCommands(lower) || lstCommands(lower) || defCommands(lower) || clrCommands(lower);
	}
	
    private function addCommands(lower:String):Boolean {
        var _loc1_:Array;
        var _loc2_:Boolean = false;
        var _loc3_:int = 0;
		var itid:int;
        _loc1_ = lower.match("^/aex (\\d+)$");
        if (_loc1_ != null) {
            _loc2_ = false;
            for each(_loc3_ in Parameters.data_.AAException) {
                if (_loc3_ == _loc1_[1]) {
                    _loc2_ = true;
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " (" + (ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined ? ObjectLibrary.xmlLibrary_[_loc1_[1]].@id:"") + ") already exists in exception list."));
                    break;
                }
            }
            if (_loc2_ == false) {
                if (ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined) {
                    Parameters.data_.AAException.push(_loc1_[1]);
                    addTextLine.dispatch(ChatMessage.make("*Help*","Added " + _loc1_[1] + " (" + ObjectLibrary.xmlLibrary_[_loc1_[1]].@id + ") to exception list."));
                }
                else {
                    addTextLine.dispatch(ChatMessage.make("*Help*","No mob has the type " + _loc1_[1] + "."));
                }
            }
            Parameters.save();
            return true;
        }
        _loc1_ = lower.match("^/aig (\\d+)$");
        if (_loc1_ != null) {
            _loc2_ = false;
            for each(_loc3_ in Parameters.data_.AAIgnore) {
                if (_loc3_ == _loc1_[1]) {
                    _loc2_ = true;
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " (" + (ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined?ObjectLibrary.xmlLibrary_[_loc1_[1]].@id:"") + ") already exists in ignore list."));
                    break;
                }
            }
            if (_loc2_ == false) {
                if (ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined) {
                    Parameters.data_.AAIgnore.push(_loc1_[1]);
                    addTextLine.dispatch(ChatMessage.make("*Help*","Added " + _loc1_[1] + " (" + ObjectLibrary.xmlLibrary_[_loc1_[1]].@id + ") to ignore list."));
                }
                else {
                    addTextLine.dispatch(ChatMessage.make("*Help*","No mob has the type " + _loc1_[1] + "."));
                }
            }
            Parameters.save();
            return true;
        }
        _loc1_ = lower.match("^/asp (.+)$");
        if (_loc1_ != null) {
            _loc2_ = false;
            for each(_loc3_ in Parameters.data_.spamFilter) {
                if (_loc3_ == _loc1_[1]) {
                    _loc2_ = true;
                    addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] +"\" already being filtered out."));
                    break;
                }
            }
            if (_loc2_ == false) {
                Parameters.data_.spamFilter.push(_loc1_[1]);
                addTextLine.dispatch(ChatMessage.make("*Help*","Added \"" + _loc1_[1] + "\" to spamfilter list."));
            }
            Parameters.save();
            return true;
        }
        _loc1_ = lower.match("^/afr (\\w+)$");
        if (_loc1_ != null) {
            _loc2_ = false;
            for each(_loc3_ in Parameters.data_.friendList2) {
                if (_loc3_ == _loc1_[1]) {
                    _loc2_ = true;
                    addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] +"\" already exists in friend list."));
                    break;
                }
            }
            if (_loc2_ == false) {
                Parameters.data_.friendList2.push(_loc1_[1]);
                addTextLine.dispatch(ChatMessage.make("*Help*","Added \"" + _loc1_[1] + "\" to friend list."));
            }
            Parameters.save();
            return true;
        }
        _loc1_ = lower.match("^/atp (\\w+)$");
        if (_loc1_ != null) {
            _loc2_ = false;
            for each(_loc3_ in Parameters.data_.tptoList) {
                if (_loc3_ == _loc1_[1]) {
                    _loc2_ = true;
                    addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] +"\" already exists in teleport keyword list."));
                    break;
                }
            }
            if (_loc2_ == false) {
                Parameters.data_.tptoList.push(_loc1_[1]);
                addTextLine.dispatch(ChatMessage.make("*Help*","Added \"" + _loc1_[1] + "\" to teleport keyword list."));
            }
            Parameters.save();
            return true;
        }
        _loc1_ = lower.match("^/apr (\\d+)$");
        if (_loc1_ != null) {
            _loc2_ = false;
            for each(_loc3_ in Parameters.data_.AAPriority) {
                if (_loc3_ == _loc1_[1]) {
                    _loc2_ = true;
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " (" + (ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined ? ObjectLibrary.xmlLibrary_[_loc1_[1]].@id:"") + ") already exists in auto aim priority list."));
                    break;
                }
            }
            if (_loc2_ == false) {
                if (ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined) {
                    Parameters.data_.AAPriority.push(_loc1_[1]);
                    addTextLine.dispatch(ChatMessage.make("*Help*","Added " + _loc1_[1] + " (" + ObjectLibrary.xmlLibrary_[_loc1_[1]].@id + ") to auto aim priority list."));
                }
                else {
                    addTextLine.dispatch(ChatMessage.make("*Help*","No mob has the type " + _loc1_[1] + "."));
                }
            }
            Parameters.save();
            return true;
        }
        _loc1_ = lower.match("^/ali (.+)$");
        if (_loc1_ != null) {
			itid = findMatch2(_loc1_[1]);
            for each(_loc3_ in Parameters.data_.lootIgnore) {
                if (_loc3_ == itid) {
                    addTextLine.dispatch(ChatMessage.make("*Help*",itid+" ("+ObjectLibrary.getIdFromType(itid) + ") already exists in loot ignore list."));
                    return true;
                }
            }
            if (itid != 0xa15) { //dirk
                Parameters.data_.lootIgnore.push(itid);
                addTextLine.dispatch(ChatMessage.make("*Help*","Added " + itid + " (" + ObjectLibrary.getIdFromType(itid) + ") to loot ignore list."));
            }
            else {
                addTextLine.dispatch(ChatMessage.make("*Help*","No item matched the query."));
            }
            Parameters.save();
            return true;
        }
        return false;
	}
	
    private function remCommands(lower:String):Boolean {
        var _loc1_:Array;
        var _loc2_:Boolean = false;
        var _loc4_:int = 0;
        var itid:int = 0;
        _loc1_ = lower.match("^/rig (\\d+)$");
        if (_loc1_ != null) {
            _loc2_ = false;
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.AAIgnore.length) {
                if (Parameters.data_.AAIgnore[_loc4_] == _loc1_[1]) {
                    _loc2_ = true;
                    Parameters.data_.AAIgnore.splice(_loc4_,1);
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " (" + (ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined?ObjectLibrary.xmlLibrary_[_loc1_[1]].@id:"") + ") removed from ignore list."));
                    break;
                }
                _loc4_++;
            }
            if (_loc2_ == false) {
                if (ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined) {
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " (" + ObjectLibrary.xmlLibrary_[_loc1_[1]].@id + ") not found in ignore list."));
                }
                else {
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " not found in ignore list."));
                }
            }
            Parameters.save();
            return true;
        }
        _loc1_ = lower.match("^/rex (\\d+)$");
        if (_loc1_ != null) {
            _loc2_ = false;
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.AAException.length) {
                if (Parameters.data_.AAException[_loc4_] == _loc1_[1]) {
                    _loc2_ = true;
                    Parameters.data_.AAException.splice(_loc4_,1);
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " (" + (ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined?ObjectLibrary.xmlLibrary_[_loc1_[1]].@id:"") + ") removed from exception list."));
                    break;
                }
                _loc4_++;
            }
            if (_loc2_ == false) {
                if (ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined) {
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " (" + ObjectLibrary.xmlLibrary_[_loc1_[1]].@id + ") not found in exception list."));
                }
                else {
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " not found in exception list."));
                }
            }
            Parameters.save();
            return true;
        }
        _loc1_ = lower.match("^/rsp (.+)$");
        if (_loc1_ != null) {
            _loc2_ = false;
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.spamFilter.length) {
                if (Parameters.data_.spamFilter[_loc4_] == _loc1_[1]) {
                    _loc2_ = true;
                    Parameters.data_.spamFilter.splice(_loc4_,1);
                    addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] + "\" removed from spamfilter list."));
                    break;
                }
                _loc4_++;
            }
            if (_loc2_ == false) {
                addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] + "\" not found in spamfilter list."));
            }
            Parameters.save();
            return true;
        }
        _loc1_ = lower.match("^/rfr (\\w+)$");
        if (_loc1_ != null) {
            _loc2_ = false;
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.friendList2.length) {
                if (Parameters.data_.friendList2[_loc4_] == _loc1_[1]) {
                    _loc2_ = true;
                    Parameters.data_.friendList2.splice(_loc4_,1);
                    addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] + "\" removed from friend list."));
                    break;
                }
                _loc4_++;
            }
            if (_loc2_ == false) {
                addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] + "\" not found in friend list."));
            }
            Parameters.save();
            return true;
        }
        _loc1_ = lower.match("^/rtp (\\w+)$");
        if (_loc1_ != null) {
            _loc2_ = false;
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.tptoList.length) {
                if (Parameters.data_.tptoList[_loc4_] == _loc1_[1]) {
                    _loc2_ = true;
                    Parameters.data_.tptoList.splice(_loc4_,1);
                    addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] + "\" removed from teleport keyword list."));
                    break;
                }
                _loc4_++;
            }
            if (_loc2_ == false) {
                addTextLine.dispatch(ChatMessage.make("*Help*","\""+_loc1_[1] + "\" not found in teleport keyword list."));
            }
            Parameters.save();
            return true;
        }
        _loc1_ = lower.match("^/rpr (\\d+)$");
        if (_loc1_ != null) {
            _loc2_ = false;
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.AAPriority.length) {
                if (Parameters.data_.AAPriority[_loc4_] == _loc1_[1]) {
                    _loc2_ = true;
                    Parameters.data_.AAPriority.splice(_loc4_,1);
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " (" + (ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined?ObjectLibrary.xmlLibrary_[_loc1_[1]].@id:"") + ") removed from auto aim priority list."));
                    break;
                }
                _loc4_++;
            }
            if (_loc2_ == false) {
                if (ObjectLibrary.xmlLibrary_[_loc1_[1]] != undefined) {
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " (" + ObjectLibrary.xmlLibrary_[_loc1_[1]].@id + ") not found in auto aim priority list."));
                }
                else {
                    addTextLine.dispatch(ChatMessage.make("*Help*",_loc1_[1] + " not found in auto aim priority list."));
                }
            }
            Parameters.save();
            return true;
        }
        _loc1_ = lower.match("^/rli (.+)$");
        if (_loc1_ != null) {
			itid = findMatch2(_loc1_[1]);
			//
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.lootIgnore.length) {
                if (Parameters.data_.lootIgnore[_loc4_] == itid) {
                    Parameters.data_.lootIgnore.splice(_loc4_,1);
                    addTextLine.dispatch(ChatMessage.make("*Help*",itid + " (" + ObjectLibrary.getIdFromType(itid) + ") removed from loot ignore list."));
                    return true;
                }
                _loc4_++;
            }
            if (itid != 0xa15) { //dirk
                addTextLine.dispatch(ChatMessage.make("*Help*",itid + " (" + ObjectLibrary.getIdFromType(itid) + ") not found in loot ignore list."));
            }
            else {
                addTextLine.dispatch(ChatMessage.make("*Help*","No item matched the query."));
            }
            Parameters.save();
            return true;
        }
        return false;
	}
	
    private function lstCommands(lower:String):Boolean {
        var _loc4_:int = 0;
        if (lower == "/exlist") {
            addTextLine.dispatch(ChatMessage.make("*Help*","Auto aim exception list (" + Parameters.data_.AAException.length + " mobs):"));
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.AAException.length) {
                addTextLine.dispatch(ChatMessage.make("*Help*",Parameters.data_.AAException[_loc4_] + " - " + (ObjectLibrary.xmlLibrary_[Parameters.data_.AAException[_loc4_]] != undefined?ObjectLibrary.xmlLibrary_[Parameters.data_.AAException[_loc4_]].@id:"")));
                _loc4_++;
            }
            return true;
        }
        if (lower == "/iglist") {
            addTextLine.dispatch(ChatMessage.make("*Help*","Auto aim ignore list (" + Parameters.data_.AAIgnore.length + " mobs):"));
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.AAIgnore.length) {
                addTextLine.dispatch(ChatMessage.make("*Help*",Parameters.data_.AAIgnore[_loc4_] + " - " + (ObjectLibrary.xmlLibrary_[Parameters.data_.AAIgnore[_loc4_]] != undefined?ObjectLibrary.xmlLibrary_[Parameters.data_.AAIgnore[_loc4_]].@id:"")));
                _loc4_++;
            }
            return true;
        }
        if (lower == "/splist") {
            addTextLine.dispatch(ChatMessage.make("*Help*","Spamfilter list (" + Parameters.data_.spamFilter.length + " filtered words):"));
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.spamFilter.length) {
                addTextLine.dispatch(ChatMessage.make("*Help*",Parameters.data_.spamFilter[_loc4_]));
                _loc4_++;
            }
            return true;
        }
        if (lower == "/frlist") {
            addTextLine.dispatch(ChatMessage.make("*Help*","Friend list (" + Parameters.data_.friendList2.length + " friends):"));
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.friendList2.length) {
                addTextLine.dispatch(ChatMessage.make("*Help*",Parameters.data_.friendList2[_loc4_]));
                _loc4_++;
            }
            return true;
        }
        if (lower == "/tplist") {
            addTextLine.dispatch(ChatMessage.make("*Help*","Teleport keyword list (" + Parameters.data_.tptoList.length + " keywords):"));
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.tptoList.length) {
                addTextLine.dispatch(ChatMessage.make("*Help*",Parameters.data_.tptoList[_loc4_]));
                _loc4_++;
            }
            return true;
        }
        if (lower == "/prlist") {
            addTextLine.dispatch(ChatMessage.make("*Help*","Auto aim priority list (" + Parameters.data_.AAPriority.length + " mobs):"));
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.AAPriority.length) {
                addTextLine.dispatch(ChatMessage.make("*Help*",Parameters.data_.AAPriority[_loc4_] + " - " + (ObjectLibrary.xmlLibrary_[Parameters.data_.AAPriority[_loc4_]] != undefined?ObjectLibrary.xmlLibrary_[Parameters.data_.AAPriority[_loc4_]].@id:"")));
                _loc4_++;
            }
            return true;
        }
        if (lower == "/lilist") {
            addTextLine.dispatch(ChatMessage.make("*Help*","Loot ignore list (" + Parameters.data_.lootIgnore.length + " items):"));
            _loc4_ = 0;
            while(_loc4_ < Parameters.data_.lootIgnore.length) {
                addTextLine.dispatch(ChatMessage.make("*Help*",Parameters.data_.lootIgnore[_loc4_] + " - " + ObjectLibrary.getIdFromType(Parameters.data_.lootIgnore[_loc4_])));
                _loc4_++;
            }
            return true;
        }
        return false;
	}
	
    private function clrCommands(lower:String):Boolean {
        if (lower == "/igclear") {
            Parameters.data_.AAIgnore = new Array();
            addTextLine.dispatch(ChatMessage.make("*Help*","Auto aim ignore list cleared."));
            Parameters.save();
            return true;
        }
        if (lower == "/exclear") {
            Parameters.data_.AAException = new Array();
            addTextLine.dispatch(ChatMessage.make("*Help*","Auto aim exception list cleared."));
            Parameters.save();
            return true;
        }
        if (lower == "/spclear") {
            Parameters.data_.spamFilter = new Array();
            addTextLine.dispatch(ChatMessage.make("*Help*","Spamfilter list cleared."));
            Parameters.save();
            return true;
        }
        if (lower == "/frclear") {
            Parameters.data_.friendList2 = new Array();
            addTextLine.dispatch(ChatMessage.make("*Help*","Friend list cleared."));
            Parameters.save();
            return true;
        }
        if (lower == "/tpclear") {
            Parameters.data_.tptoList = new Array();
            addTextLine.dispatch(ChatMessage.make("*Help*","Teleport keyword list cleared."));
            Parameters.save();
            return true;
        }
		if (lower == "/prclear") {
            Parameters.data_.AAPriority = new Array();
            addTextLine.dispatch(ChatMessage.make("*Help*","Auto aim priority list cleared."));
            Parameters.save();
            return true;
        }
		if (lower == "/liclear") {
            Parameters.data_.lootIgnore = new Array();
            addTextLine.dispatch(ChatMessage.make("*Help*","Loot ignore list cleared."));
            Parameters.save();
            return true;
        }
        return false;
	}
	
    private function defCommands(lower:String):Boolean {
        if (lower == "/igdefault") {
            Parameters.data_.AAIgnore = [1550,1551,1552,1619,1715,2309,2310,2311,2371,3441,2312,2313,2370,2392,2393,2400,2401,3335,3336,3337,3338,3413,3418,3419,3420,3421,3427,3454,3638,3645,6157,28715,28716,28717,28718,28719,28730,28731,28732,28733,28734,29306,29568,29594,29597,29710,29711,29742,29743,29746,29748,30001,29752,0xaab6,0xaabc,0xaabd,0xaabe,3389,3390,3391,24223,2304,2305,2306,1536,1537,1538,1539,1540];
            addTextLine.dispatch(ChatMessage.make("*Help*","Default ignore list restored."));
            Parameters.save();
            return true;
        }
        if (lower == "/exdefault") {
            Parameters.data_.AAException = [3414,3417,3448,3449,3472,3334,5952,2354,2369,3368,3366,3367,3391,3389,3390,5920,2314,3412,3639,3634,2327,1755,24582,24351,24363,24135,24133,24134,24132,24136,3356,3357,3358,3359,3360,3361,3362,3363,3364,2352,28780,28781,28795,28942,28957,28988,28938,29291,29018,29517,24338,29580,29712,6282,0x717e,0x727c,0x727d,0x736e,0x736f,0x724a,0x724b,0x724c,0x724d,0x724e];
            addTextLine.dispatch(ChatMessage.make("*Help*","Default exception list restored."));
            Parameters.save();
            return true;
        }
        if (lower == "/spdefault") {
            Parameters.data_.spamFilter = ["realmk!ngs", "oryx.ln", "realmpower.net", "oryxsh0p.net", "lifepot. org"];
            addTextLine.dispatch(ChatMessage.make("*Help*","Default spamfilter list restored."));
            Parameters.save();
            return true;
        }
        if (lower == "/tpdefault") {
            Parameters.data_.tptoList = ["lab","manor", "sew"];
            addTextLine.dispatch(ChatMessage.make("*Help*","Default teleport keyword list restored."));
            Parameters.save();
            return true;
        }
		if (lower == "/prdefault") {
            Parameters.data_.AAPriority = [0x717e,0x727c,0x727d,0x736e,0x736f,0x724a,0x724b,0x724c,0x724d,0x724e,6282,1646];
            addTextLine.dispatch(ChatMessage.make("*Help*","Default auto aim priority list restored."));
            Parameters.save();
            return true;
        }
		if (lower == "/lidefault") {
            Parameters.data_.lootIgnore = [0x233a,0x233b,0x233c,0x233d,0x233e,0x233f,0x2340,0x2341,0xf15,0xa4b];
            addTextLine.dispatch(ChatMessage.make("*Help*","Default loot ignore list restored."));
            Parameters.save();
            return true;
        }
        return false;
    }
	
    private function cjCommands():Boolean {
		var i:int;
		var player:Player = hudModel.gameSprite.map.player_;
		var gsc:GameServerConnection = hudModel.gameSprite.gsc_;
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
				gsc.playerText("/server");
				return true;
			case "/hide":
				gsc.playerText("/tell mreyeball hide me");
				return true;
			case "/friends":
			case "/fr":
				gsc.playerText("/tell mreyeball friends");
				return true;
			case "/l2m":
			case "/left2max":
			case "/lefttomax":
				needed = "You need ";
				var youre88:Boolean = true;
				var p:Player = player;
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
				gsc.playerText("/tell mreyeball stats");
				return true;
			case "/mates":
				gsc.playerText("/tell mreyeball mates");
				return true;
			case "/tut":
			//case "/tutorial":
				gsc.playerText("/nexustutorial");
				return true;
			case "/tr":
				gsc.playerText("/trade "+lastTellTo);
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
				player.notifyPlayer(GameServerConnectionConcrete.totalfamegain+" fame\n"+playTime+" minutes\n"+fpm+" fame/min", 0xE25F00, 3000);
				return true;
			case "/fameclear":
				PlayGameCommand.startTime = getTimer();
				GameServerConnectionConcrete.totalfamegain = 0;
				return true;
			case "/pos":
				addTextLine.dispatch(ChatMessage.make("*Help*", "X: " + player.x_ +" Y: " + player.y_));
				return true;
			case "/s":
			case "/switch":
			case "/swap":
				if (player.hasBackpack_) {
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
				hudModel.gameSprite.hudView.characterDetails.setName(player.name_);
				return true;
			case "/flist":
				openDialog.dispatch(new FriendListView());
				return true;
			case "/nexus":
				gsc.escapeUnsafe();
				return true;
			case "/follow":
				player.followTarget = null;
				player.notifyPlayer("Stopped following");
				return true;
			case "/afk":
				TextHandler.afk = !TextHandler.afk;
				if (!TextHandler.afk) {
					addTextLine.dispatch(ChatMessage.make("*Help*", TextHandler.afkTells.length+" messages since "+afkStart.getFormattedTime()));
					for each(var cm:ChatMessage in TextHandler.afkTells) {
						addTextLine.dispatch(cm);
					}
					TextHandler.afkTells.length = 0;
					TextHandler.sendBacks.length = 0;
				}
				else {
					afkStart = new CJDateUtil();
					addTextLine.dispatch(ChatMessage.make("*Help*", "Your messages will be saved, have fun."));
				}
				TextHandler.afkMsg = "";
				return true;
			case "/re":
				gsc.playerText(lastMsg);
				return true;
			case "/join":
				if (Parameters.data_.hackServ == null) {
					addTextLine.dispatch(ChatMessage.make("", "Server not selected. Use /addserv <join code> to select a server.", -1, 1, "*Hacker*"));
					return true;
				}
				gsc.playerText("/t "+Parameters.data_.hackServ+" £åè|join");
				return true;
			case "/leave":
				if (Parameters.data_.hackServ == null) {
					addTextLine.dispatch(ChatMessage.make("", "Server not selected. Use /addserv <join code> to select a server.", -1, 1, "*Hacker*"));
					return true;
				}
				gsc.playerText("/t "+Parameters.data_.hackServ+" £åè|leave");
				return true;
		}
		var splice:Array = data.toLowerCase().match("^/afk (.+)$")
		if (splice != null) {
			TextHandler.afk = true;
			TextHandler.afkMsg = splice[1];
			afkStart = new CJDateUtil();
			addTextLine.dispatch(ChatMessage.make("*Help*", "Your messages will be saved, have fun."));
			return true;
		}
		splice = data.toLowerCase().match("^/player (\\w+)$")
		if (splice != null) {
			navigateToURL(new URLRequest("https://www.realmeye.com/player/" + splice[1]), "_blank");
			return true;
		}
		splice = data.toLowerCase().match("^/sell (\\d{1,2})$"); //incl backpack
		if (splice != null) {
			var slot:int = int(splice[1]) + 3;
			navigateToURL(new URLRequest("https://www.realmeye.com/offers-to/buy/" + GameServerConnectionConcrete.PLAYER_.equipment_[slot] + "/2793"), "_blank");
			return true;
		}
		splice = data.toLowerCase().match("^/re (\\w+)$");
		if (splice != null) {
			var newMsg:String = "/tell " + splice[1] + " " + lastTell;
			gsc.playerText(newMsg);
			lastTellTo = splice[1];
			lastMsg = newMsg;
			return true;
		}
		splice = data.match("^/name (.+)$");
		if (splice != null) {
			Parameters.data_.fakeName = splice[1];
			Parameters.save();
			hudModel.gameSprite.hudView.characterDetails.setName("");
			return true;
		}
		splice = data.toLowerCase().match("^/timer (\\d+) ?(\\d*)$");
		if (splice != null) {
			if (splice[2] == "") {
				player.startTimer(splice[1], 1000);
			}
			else {
				player.startTimer(splice[1], splice[2]);
			}
			return true;
		}
		splice = data.toLowerCase().match("^/autopot (\\d+)$");
		if (splice != null) {
			Parameters.data_.autoPot = splice[1];
			Parameters.save();
            addTextLine.dispatch(ChatMessage.make("*Help*","Auto pot percentage set to "+splice[1]));
			return true;
		}
		splice = data.toLowerCase().match("^/autonex (\\d+)$");
		if (splice != null) {
			Parameters.data_.AutoNexus = splice[1];
			Parameters.save();
            addTextLine.dispatch(ChatMessage.make("*Help*","Auto nexus percentage set to "+splice[1]));
			return true;
		}
		splice = data.toLowerCase().match("^/autoheal (\\d+)$");
		if (splice != null) {
			Parameters.data_.autoHealP = splice[1];
			Parameters.save();
            addTextLine.dispatch(ChatMessage.make("*Help*","Auto heal percentage set to "+splice[1]));
			return true;
		}
		splice = data.toLowerCase().match("^/give (\\w+) (\\d{1,8})$");
		//splice = data.match("^/give (\\w+) ([0-1])?([0-1])?([0-1])?([0-1])?([0-1])?([0-1])?([0-1])?([0-1])$"); //such efficiency
		if (splice != null) {
			gsc.playerText("/tell "+splice[1]+" g="+splice[2]);
			gsc.requestTrade(splice[1]);
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
		/*splice = data.match("^/find (\\d+)$");
		if (splice != null) {
			findItem(parseInt(splice[1]));
			return true;
		}*/
		splice = data.toLowerCase().match("^/find (.+)$");
		if (splice != null) {
			findItem(findMatch2(splice[1])); //length-match
			return true;
		}
		/*splice = data.match("^/dc (\\w+)$");
		if (splice != null) {
			gsc.playerText("/tell "+splice[1]+" whats that name dude?");
			return true;
		}*/
		splice = data.toLowerCase().match("^/take (.+)$");
		if (splice != null) {
			if (hudModel.gameSprite.map.name_ != "Vault") {
				addTextLine.dispatch(ChatMessage.make("*Help*", "Use the command in vault and run over the chest you wish to interact with."));
				return true;
			}
			if (splice[1] == "pots") {
				player.collect = int.MAX_VALUE;
				addTextLine.dispatch(ChatMessage.make("*Help*", "Taking Potion(s) from vault chests"));
				return true;
			}
			player.collect = findMatch2(splice[1]);
            addTextLine.dispatch(ChatMessage.make("*Help*","Taking "+ObjectLibrary.getIdFromType(player.collect)+"(s) from vault chests"));
			return true;
		}
		splice = data.toLowerCase().match("^/put (.+)$");
		if (splice != null) {
			if (hudModel.gameSprite.map.name_ != "Vault") {
				addTextLine.dispatch(ChatMessage.make("*Help*", "Use the command in vault and run over the chest you wish to interact with."));
				return true;
			}
			if (splice[1] == "pots") {
				player.collect = int.MIN_VALUE;
				addTextLine.dispatch(ChatMessage.make("*Help*", "Putting Potion(s) to vault chests"));
				return true;
			}
			player.collect = 0 - findMatch2(splice[1]);
            addTextLine.dispatch(ChatMessage.make("*Help*","Putting "+ObjectLibrary.getIdFromType(0 - player.collect)+"(s) to vault chests"));
			return true;
		}
		splice = data.toLowerCase().match("^/buy (\\w+) ?(\\w*)$");
		if (splice != null) {
			//navigateToURL(new URLRequest("https://www.realmeye.com/offers-to/sell/" + findMatch2(splice[1]) + "/2793"), "_blank");
			if (splice[2] == "") {
				navigateToURL(new URLRequest("https://www.realmeye.com/offers-to/sell/" + findMatch2(splice[1]) + "/2793"), "_blank");
			}
			else {
				navigateToURL(new URLRequest("https://www.realmeye.com/offers-to/sell/" + findMatch2(splice[1]) + "/"+ findMatch2(splice[2])), "_blank");
			}
			return true;
		}
		splice = data.toLowerCase().match("^/sell (\\w+) ?(\\w*)$");
		if (splice != null) {
            //addTextLine.dispatch(ChatMessage.make("*Help*", splice[1]+" "+splice[2]));
			if (splice[2] == "") {
				navigateToURL(new URLRequest("https://www.realmeye.com/offers-to/buy/" + findMatch2(splice[1]) + "/2793"), "_blank");
			}
			else {
				navigateToURL(new URLRequest("https://www.realmeye.com/offers-to/buy/" + findMatch2(splice[1]) + "/"+ findMatch2(splice[2])), "_blank");
			}
			return true;
		}
		splice = data.toLowerCase().match("^/dye1 (.+)$");
		if (splice != null) {
			if (splice[1] == "none") {
				Parameters.data_.setTex1 = 0;
				Parameters.save();
				player.setTex1(0);
			}
			else {
				Parameters.data_.setTex1 = getTex1(findMatch2(splice[1]+" cloth"));
				Parameters.save();
				player.setTex1(Parameters.data_.setTex1);
			}
			return true;
		}
		splice = data.toLowerCase().match("^/dye2 (.+)$");
		if (splice != null) {
			if (splice[1] == "none") {
				Parameters.data_.setTex2 = 0;
				Parameters.save();
				player.setTex2(0);
			}
			else {
				Parameters.data_.setTex2 = getTex1(findMatch2(splice[1]+" cloth"));
				Parameters.save();
				player.setTex2(Parameters.data_.setTex2);
			}
			return true;
		}
		splice = data.toLowerCase().match("^/dye (.+)$");
		if (splice != null) {
			if (splice[1] == "none") {
				Parameters.data_.setTex1 = 0;
				Parameters.data_.setTex2 = 0;
				Parameters.save();
				player.setTex1(0);
				player.setTex2(0);
			}
			else {
				splice[1] = getTex1(findMatch2(splice[1] + " cloth"));
				Parameters.data_.setTex1 = splice[1];
				Parameters.data_.setTex2 = splice[1];
				Parameters.save();
				player.setTex1(Parameters.data_.setTex1);
				player.setTex2(Parameters.data_.setTex2);
			}
			return true;
		}
		splice = data.toLowerCase().match("^/skin (.+)$");
		if (splice != null) {
			if (splice[1] == "none") {
				Parameters.data_.nsetSkin[0] = "";
				Parameters.data_.nsetSkin[1] = -1;
				Parameters.save();
				player.size_ = 100;
				gsc.setPlayerSkinTemplate(player, 0); //requires skin to be for your class
			}
			else {
				Parameters.data_.nsetSkin = findSkinIndex(splice[1]);
				Parameters.save();
				//player.skin = AnimatedChars.getAnimatedChar("playerskins", Parameters.data_.setSkin); //not working
			}
			return true;
		}
		splice = data.toLowerCase().match("^/tp (\\w+)$");
		if (splice != null) {
			gsc.teleport(fixedName(splice[1]).name_);
			return true;
		}
		splice = data.toLowerCase().match("^/follow (\\w+)$");
		if (splice != null) {
			var target:GameObject = fixedName(splice[1]);
			player.notifyPlayer("Following "+target.name_);
			gsc.teleport(target.name_);
			player.followTarget = target;
			return true;
		}
		splice = data.toLowerCase().match("^/setspd (-?\\d+)$");
		if (splice != null) {
			player.speed_ = parseInt(splice[1]);
			return true;
		}
		splice = data.match("^/b (.+)");
		if (splice != null) {
			if (Parameters.data_.hackServ == null) {
				addTextLine.dispatch(ChatMessage.make("", "Server not selected. Use /addserv <join code> to select a server.", -1, 1, "*Hacker*"));
				return true;
			}
			gsc.playerText("/t "+Parameters.data_.hackServ+" £åè|say|"+splice[1]);
			return true;
		}
		splice = data.match("^/pm ([A-Za-z0-9]+) (.+)");
		if (splice != null) {
			if (Parameters.data_.hackServ == null) {
				addTextLine.dispatch(ChatMessage.make("", "Server not selected. Use /addserv <join code> to select a server.", -1, 1, "*Hacker*"));
				return true;
			}
			gsc.playerText("/t "+Parameters.data_.hackServ+" £åè|pm|"+splice[1]+"|"+splice[2]);
			return true;
		}
		splice = data.match("^/register ([A-Za-z0-9]+)");
		if (splice != null) {
			if (Parameters.data_.hackServ == null) {
				addTextLine.dispatch(ChatMessage.make("", "Server not selected. Use /addserv <join code> to select a server.", -1, 1, "*Hacker*"));
				return true;
			}
			gsc.playerText("/t "+Parameters.data_.hackServ+" £åè|register|"+splice[1]);
			return true;
		}
		splice = data.match("^/ban (.+)");
		if (splice != null) {
			if (Parameters.data_.hackServ == null) {
				addTextLine.dispatch(ChatMessage.make("", "Server not selected. Use /addserv <join code> to select a server.", -1, 1, "*Hacker*"));
				return true;
			}
			gsc.playerText("/t "+Parameters.data_.hackServ+" £åè|ban|"+splice[1]);
			return true;
		}
		splice = data.match("^/kick (.+)");
		if (splice != null) {
			if (Parameters.data_.hackServ == null) {
				addTextLine.dispatch(ChatMessage.make("", "Server not selected. Use /addserv <join code> to select a server.", -1, 1, "*Hacker*"));
				return true;
			}
			gsc.playerText("/t "+Parameters.data_.hackServ+" £åè|kick|"+splice[1]);
			return true;
		}
		splice = data.match("^/addserv ([0-9a-fA-F]+)");
		if (splice != null) {
			setServ(splice[1]);
			return true;
		}
		/*splice = data.match("^/spam (.+)$");
		if (splice != null) {
			return true;
		}*/
		/*splice = data.match("^/b (.+)");
		if (splice != null) {
			ExternalInterface.call("SendFromFlash", "Message", "", splice[1]);
			return true;
		}*/
        return false;
    }
	
	private function setServ(hex:String):void { //FFFFFF
		var arr:Array = hex.split('');
		var out:String = "";
		if (arr.length % 2 != 0)
			return;
		
		for (var i:int = 0; i < hex.length; i+=2) {
			out += String.fromCharCode(parseInt(arr[i] + arr[i + 1], 16));
		}
		Parameters.data_.hackServ = out;
		addTextLine.dispatch(ChatMessage.make("", "Server successfully selected. Use /register <username> to register onto the server.", -1, 1, "*Hacker*"));
	}
	
	private function findSkinIndex(input:String):Array {
		var splice:Array = input.split(' ');
		var splice2:Array;
		var curxml:XML;
		var dist2:int = int.MAX_VALUE;
		var temp:int;
		var skinfile:String;
		var skinid:String;
        var _local_1:XML;
        var _local_2:XMLList;
        _local_1 = EmbeddedData.skinsXML;
        _local_2 = _local_1.children();
		
        for each (curxml in _local_2) {
			splice2 = curxml.@id.toLowerCase().split(' ');
			temp = scoredMatch(curxml.@id.toString().length, splice, splice2);
			if (temp < dist2) {
				dist2 = temp;
				skinfile = curxml.AnimatedTexture.File;
				skinid = curxml.AnimatedTexture.Index;
			}
        }
		return new Array(skinfile, skinid);
	}
	
	/*private function findSkin(input:String):int {
		var splice:Array = input.split(' ');
		var splice2:Array;
		var curxml:XML;
		var dist2:int = int.MAX_VALUE;
		var temp:int;
		var skinid:String;
        var _local_1:XML;
        var _local_2:XMLList;
        _local_1 = EmbeddedData.skinsXML;
        _local_2 = _local_1.children();
		
        for each (curxml in _local_2) {
			splice2 = curxml.@id.toLowerCase().split(' ');
			temp = scoredMatch(curxml.@id.length, splice, splice2);
			if (temp < dist2) {
				dist2 = temp;
				skinid = curxml.@type;
			}
        }
		return parseInt(skinid);
	}*/
	
	private function getTex1(item:int):uint {
        var dye:XML = ObjectLibrary.xmlLibrary_[item];
		return dye.Tex1;
	}
	
	private function fixedName(input:String):GameObject {
		var dist2:int = int.MAX_VALUE;
		var temp:int;
		var go_:GameObject;
		var target:GameObject;
		for each(go_ in hudModel.gameSprite.map.goDict_) {
			if (!(go_ is Player)) {
				continue;
			}
			temp = levenshtein(input, go_.name_.toLowerCase().substr(0,input.length));
			if (temp < dist2) {
				//addTextLine.dispatch(ChatMessage.make("*Help*",temp+" < "+dist2+", so player = "+go_.name_));
				dist2 = temp;
				target = go_;
			}
			if (dist2 == 0) {
				break;
			}
		}
		return target;
	}
	
	private function findMatch2(input:String):int {
		var hardcode:Vector.<String> = new <String> ["def", "att", "spd", "dex", "vit", "wis", "ubhp"];
		var hardval:Vector.<int> = new <int>[0xa20, 0xa1f, 0xa21, 0xa4c, 0xa34, 0xa35, 0xba9];
		for (var i:int = 0; i < hardcode.length; i++) {
			if (input == hardcode[i]) {
				return hardval[i];
			}
		}
		
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
		return ObjectLibrary.idToType_[itemname];
	}
	
	private function scoredMatch(init:int, inpu:Array, comp:Array):int {
		//addTextLine.dispatch(ChatMessage.make("*Help*", "match for "+inpu[0]+"("+init+")"));
		var outer:String;
		var inner:String;
		for each(outer in comp) {
			for each(inner in inpu) {
				if (outer.substr(0,inner.length) == inner) {
					init -= inner.length * 10;
				}
			}
		}
		//addTextLine.dispatch(ChatMessage.make("*Help*", "match is "+init));
		return init;
	}
	
	private function levenshtein(string_1:String, string_2:String):int {
		var matrix:Array = new Array();
		var dist:int;
		for (var i:int=0; i<=string_1.length; i++) {
			matrix[i] = new Array();
			for (var j:int = 0; j <= string_2.length; j++) {
				if (i!=0) {
					matrix[i].push(0);
				} else {
					matrix[i].push(j);
				}
			}
			matrix[i][0]=i;
		}
		for (i = 1; i <= string_1.length; i++) {
			for (j = 1; j <= string_2.length; j++) {
				if (string_1.charAt(i-1) == string_2.charAt(j-1)) {
					dist = 0;
				} else {
					dist = 1;
				}
				matrix[i][j] = Math.min(matrix[i-1][j]+1,matrix[i][j-1]+1,matrix[i-1][j-1]+dist);
			}
		}
		return matrix[string_1.length][string_2.length];
	}
	
	private function findItem(id:int):void { //TODO show amounts
		if (id == 0xa15) { //dirk
			addTextLine.dispatch(ChatMessage.make("*Help*", "No item matched the query"));
		}
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
			addTextLine.dispatch(ChatMessage.make("*Help*", "No one has "+ObjectLibrary.getIdFromType(id)));
		}
		//addTextLine.dispatch(ChatMessage.make("*Help*", holders.length+" players have the item"));
	}
    
    private function custMessages() : Boolean {
		var splice2:Array = data.match("^/setmsg (\\d) (.+)$")
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
		var splice2:Array = data.match("^/eff (\\d) (\\d+) (.+)$")
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
			Parameters.data_.dbPre3[0] = splice2[3];
			Parameters.data_.dbPre3[1] = parseInt(splice2[2]);
			Parameters.data_.dbPre3[2] = false;
		}
		addTextLine.dispatch(ChatMessage.make("*Help*","A new preset was created for effect ID "+splice2[2]));
		Parameters.save();
		return true;
	}
	
	private function tellHandle():Boolean {
		var str:String = "";
		if (data.substr(0,3) == "/t " || data.substr(0,3) == "/w ") {
			str = data.substr(3)
		}
		else if (data.substr(0,6) == "/tell ") {
			str = data.substr(6)
		}
		else if (data.substr(0,9) == "/whisper ") {
			str = data.substr(9)
		}
		if (str != "") {
			var splice:Array = str.match("(\\w+) (.+)");
			if (splice != null) {
				lastTellTo = splice[1];
				lastTell = splice[2];
				lastMsg = data;
				this.hudModel.gameSprite.gsc_.playerText(data);
				return true;
			}
		}
		return false;
	}

    public function execute():void {
		if (tellHandle()) {
			return;
		}
        else if (listCommands()) {
            return;
        }
        else if (cjCommands()) {
            return;
        }
        else if (custMessages()) {
            return;
        }
        else if (effCom()) {
            return;
        }
        else if (this.fsCommands(this.data)) {
            return;
        }
        else if (this.data == "/help") {
            this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, TextKey.HELP_COMMAND));
        }
        else { //send message as normal
			lastMsg = data;
			hudModel.gameSprite.gsc_.playerText(data);
        }
    }
}
}//package kabam.rotmg.chat.control
