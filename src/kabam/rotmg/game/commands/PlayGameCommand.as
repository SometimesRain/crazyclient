package kabam.rotmg.game.commands {
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.parameters.Parameters;

import flash.utils.ByteArray;

import kabam.lib.net.impl.SocketServerModel;
import kabam.lib.tasks.TaskMonitor;
import kabam.rotmg.account.core.services.GetCharListTask;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.game.model.GameInitData;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.servers.api.Server;
import kabam.rotmg.servers.api.ServerModel;
import flash.utils.getTimer;

public class PlayGameCommand {

    public static const RECONNECT_DELAY:int = 250; //changed from 2000
    public static var startTime:int = -1;

    [Inject]
    public var setScreen:SetScreenSignal;
    [Inject]
    public var data:GameInitData;
    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var petsModel:PetsModel;
    [Inject]
    public var servers:ServerModel;
    [Inject]
    public var task:GetCharListTask;
    [Inject]
    public var monitor:TaskMonitor;
    [Inject]
    public var socketServerModel:SocketServerModel;
	
	public static var visited:Array = new Array();
	private static var loaded:Boolean = false;
	public static var currealm:String = "Nexus";
	public static var curloc:String = "Nexus";
	public static var curip:String = "0.0.0.0";

    public function execute():void {
        if (!this.data.isNewGame) {
            this.socketServerModel.connectDelayMS = PlayGameCommand.RECONNECT_DELAY;
        }
        this.recordCharacterUseInSharedObject();
        this.makeGameView();
        this.updatePet();
    }

    private function updatePet():void {
        var _local_1:SavedCharacter = this.model.getCharacterById(this.model.currentCharId);
        if (_local_1) {
            this.petsModel.setActivePet(_local_1.getPetVO());
        }
        else {
            if (((((this.model.currentCharId) && (this.petsModel.getActivePet()))) && (!(this.data.isNewGame)))) {
                return;
            }
            this.petsModel.setActivePet(null);
        }
    }

    private function recordCharacterUseInSharedObject():void {
        Parameters.data_.charIdUseMap[this.data.charId] = new Date().getTime();
        Parameters.save();
    }

    private function makeGameView():void { //hackhere
		if (!model.account.isRegistered())
			return;
		var _local_1:Server; 
		_local_1 = ((this.data.server) || (this.servers.getServer()));
		var named:Boolean = namedConnection(_local_1);
		if (Parameters.data_.preferredServer == null && Parameters.data_.bestServ != "Default" && named) {
			_local_1 = getServerByName(Parameters.data_.bestServ);
		}
		var prefserv:String = Parameters.data_.preferredServer;
		if (prefserv != null && _local_1.name.substring(0,prefserv.length) != prefserv) {
			if (_local_1.name.substr(0, 12) == "NexusPortal.") {
				currealm = _local_1.name.substr(12);
				_local_1.name = "";
			}
			else if (_local_1.name == "Nexus") {
				currealm = _local_1.name;
			}
			else if (_local_1.name.substr(0, 1) == "{") {
				switch (_local_1.name) {
					case "{\"text\":\"server.vault\"}": 
						_local_1.name = "";
						currealm = "Vault";
						break;
					case "{objects.Cloth_Bazaar_Portal}": 
						_local_1.name = "";
						currealm = "Cloth Bazaar";
						break;
					case "{objects.Glowing_Portal}": 
						_local_1.name = "Sprite World";
						break;
					case "{objects.Ocean_Trench_Portal}": 
						_local_1.name = "Ocean Trench";
						break;
					case "{objects.Abyss_of_Demons_Portal}": 
						_local_1.name = "Abyss of Demons";
						break;
					case "{objects.Tomb_of_the_Ancients_Portal}": 
						_local_1.name = "Tomb of the Ancients";
						break;
					case "{objects.Toxic_Sewers_Portal}": 
						_local_1.name = "Toxic Sewers";
						break;
					case "{madLab.Mad_Lab_Portal}": 
						_local_1.name = "Mad Lab";
						break;
					case "{shatters.The_Shatters}": 
						_local_1.name = "The Shatters";
						break;
					case "{objects.Undead_Lair_Portal}": 
						_local_1.name = "Undead Lair";
						break;
					case "{objects.Snake_Pit_Portal}": 
						_local_1.name = "Snake Pit";
						break;
					case "{\"text\":\"server.enter_the_portal\"}": 
						_local_1.name = "Oryx's Kitchen";
						break;
					case "{objects.Court_of_Oryx_Portal}": 
						_local_1.name = "Court of Oryx";
						break;
					case "{objects.Manor_of_the_Immortals_Portal}": 
						_local_1.name = "Manor of the Immortals";
						break;
					case "{objects.Davy_JonesAPOS_Locker_Portal}": 
						_local_1.name = "Davy Jones' Locker";
						break;
					case "{objects.Puppet_Theatre_Portal}": 
						_local_1.name = "Pupper Master's Theatre";
						break;
					case "{objects.Puppet_Encore_Portal}":
						_local_1.name = "Pupper Master's Encore";
						break;
					case "{lairOfDraconis.Lair_of_Draconis_Portal}":
						_local_1.name = "Lair of Draconis";
						break;
					case "{lairOfDraconis.Ivory_Wyvern_Portal}":
						_local_1.name = "The Ivory Wyvern";
						break;
					case "{oryxCastle.OryxAPOSs_Chamber_Portal}":
						_local_1.name = "Oryx's Chamber";
						break;
					case "{epicpirateCave.Deadwater_Docks}":
						_local_1.name = "Deadwater Docks";
						break;
					case "{epicforestMaze.Woodland_Labyrinth}":
						_local_1.name = "Woodland Labyrinth";
						break;
					case "{epicspiderDen.The_Crawling_Depths}":
						_local_1.name = "The Crawling Depths";
						break;
					case "{oryx.Wine_Cellar}":
						_local_1.name = "Wine Cellar";
						break;
				}
			}
			_local_1.name = prefserv + " "+currealm+" " + _local_1.name;
		}
		else if (_local_1.name == Parameters.data_.preferredServer) {
			currealm = "Nexus";
		}
		else if (_local_1.name == "Realm") {
			_local_1.name = "";
		}
        var _local_2:int = ((this.data.isNewGame) ? this.getInitialGameId() : this.data.gameId);
        var _local_3:Boolean = this.data.createCharacter;
        var _local_4:int = this.data.charId;
        var _local_5:int = ((this.data.isNewGame) ? -1 : this.data.keyTime);
        var _local_6:ByteArray = this.data.key;
        this.model.currentCharId = _local_4;
		if (startTime == -1) {
			startTime = getTimer();
		}
		if (_local_2 == 0) {
			var nadd:String = _local_1.address + " " + _local_1.name;
			var add:Boolean = true;
			for each (var str:String in visited) {
				if (nadd == str) {
					add = false;
					break;
				}
			}
			if (add)
				visited.push(nadd);
		}
		/*Parameters.data_.visRealms = visited;
		Parameters.save();*/
		curloc = _local_1.name;
		curip = _local_1.address;
		/*trace("trace");
		trace("loc1 "+_local_1); //server
		trace("loc2 "+_local_2); //gameid
		trace("loc3 "+_local_3); //createnewchar bool
		trace("loc4 "+_local_4); //charid
		trace("loc5 "+_local_5); //keytime = -1
		trace("loc6 " + _local_6); //key = null
		trace("model "+model.account.getUserName()) //acc*/
        this.setScreen.dispatch(new GameSprite(_local_1, _local_2, _local_3, _local_4, _local_5, _local_6, this.model, null, this.data.isFromArena));
	}

    private function namedConnection(s:Server):Boolean { //connects to a server name (e.g. USSouth2) not Nexus or NexusPortal.Medusa
		var srvList:Vector.<Server> = this.servers.getServers();
        for each (var _local_2:Server in srvList) {
            if (_local_2.name == s.name) {
                return true;
            }
        }
        return false;
	}

    private function getServerByName(_arg_1:String):Server {
		var srvList:Vector.<Server> = this.servers.getServers();
		//trace("LIST "+srvList.length+" "+srvList[0].name+" "+_arg_1);
        for each (var _local_2:Server in srvList) {
            if (_local_2.name == _arg_1) {
                return _local_2;
            }
        }
        return null;
    }

    private function getInitialGameId():int {
        var _local_1:int;
        /*if (Parameters.data_.needsTutorial) {
            _local_1 = Parameters.TUTORIAL_GAMEID;
        }
        else {*/
            if (Parameters.data_.needsRandomRealm) {
                _local_1 = Parameters.RANDOM_REALM_GAMEID;
            }
            else {
                _local_1 = Parameters.NEXUS_GAMEID;
            }
        //}
        return (_local_1);
    }


}
}//package kabam.rotmg.game.commands
