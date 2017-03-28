package kabam.rotmg.friends.model {
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.FameUtil;

import flash.utils.Dictionary;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.friends.service.FriendDataRequestTask;
import kabam.rotmg.servers.api.Server;
import kabam.rotmg.servers.api.ServerModel;

import org.osflash.signals.Signal;
import org.swiftsuspenders.Injector;

public class FriendModel {

    [Inject]
    public var serverModel:ServerModel;
    public var friendsTask:FriendDataRequestTask;
    public var invitationsTask:FriendDataRequestTask;
    private var _onlineFriends:Vector.<FriendVO>;
    private var _offlineFriends:Vector.<FriendVO>;
    private var _friends:Dictionary;
    private var _invitations:Dictionary;
    private var _friendsLoadInProcess:Boolean;
    private var _invitationsLoadInProgress:Boolean;
    private var _friendTotal:int;
    private var _invitationTotal:int;
    private var _isFriDataOK:Boolean;
    private var _isInvDataOK:Boolean;
    private var _serverDict:Dictionary;
    private var _currentServer:Server;
    public var errorStr:String;
    public var dataSignal:Signal;

    public function FriendModel() {
        this.dataSignal = new Signal(Boolean);
        super();
        this._friendTotal = 0;
        this._invitationTotal = 0;
        this._invitationTotal = 0;
        this._friends = new Dictionary(true);
        this._onlineFriends = new Vector.<FriendVO>();
        this._offlineFriends = new Vector.<FriendVO>();
        this._friendsLoadInProcess = false;
        this._invitationsLoadInProgress = false;
        this.loadData();
    }

    public function setCurrentServer(_arg_1:Server):void {
        this._currentServer = _arg_1;
    }

    public function getCurrentServerName():String {
        return (((this._currentServer) ? this._currentServer.name : ""));
    }

    public function loadData():void {
        if(this._friendsLoadInProcess || this._invitationsLoadInProgress)  {
            return;
        }
        var _local_1:Injector = StaticInjectorContext.getInjector();
        this._friendsLoadInProcess = true;
        this.friendsTask = _local_1.getInstance(FriendDataRequestTask);
        this.loadList(this.friendsTask, FriendConstant.getURL(FriendConstant.FRIEND_LIST), this.onFriendListResponse);
        this._invitationsLoadInProgress = true;
        this.invitationsTask = _local_1.getInstance(FriendDataRequestTask);
        this.loadList(this.invitationsTask, FriendConstant.getURL(FriendConstant.INVITE_LIST), this.onInvitationListResponse);

    }

    private function loadList(_arg_1:FriendDataRequestTask, _arg_2:String, _arg_3:Function):void {
        _arg_1.requestURL = _arg_2;
        _arg_1.finished.addOnce(_arg_3);
        _arg_1.start();
    }

    private function onFriendListResponse(_arg_1:FriendDataRequestTask, _arg_2:Boolean, _arg_3:String = ""):void {
        if (_arg_2) {
            this.seedFriends(_arg_1.xml);
        }
        this._isFriDataOK = _arg_2;
        this.errorStr = _arg_3;
        _arg_1.reset();
        this._friendsLoadInProcess = false;
        this.reportTasksComplete();
    }

    private function onInvitationListResponse(_arg_1:FriendDataRequestTask, _arg_2:Boolean, _arg_3:String = ""):void {
        if (_arg_2) {
            this.seedInvitations(_arg_1.xml);
        }
        this._isInvDataOK = _arg_2;
        this.errorStr = _arg_3;
        _arg_1.reset();
        this._invitationsLoadInProgress = false;
        this.reportTasksComplete();
    }

    private function reportTasksComplete():void
    {
        if(this._friendsLoadInProcess == false && this._invitationsLoadInProgress == false)
        {
            this.dataSignal.dispatch(this._isFriDataOK && this._isInvDataOK);
        }
    }

    public function seedFriends(_arg_1:XML):void {
        var _local_2:String;
        var _local_3:String;
        var _local_4:String;
        var _local_5:FriendVO;
        var _local_6:XML;
        this._onlineFriends.length = 0;
        this._offlineFriends.length = 0;
        for each (_local_6 in _arg_1.Account) {
            _local_2 = _local_6.Name;
            _local_5 = (((this._friends[_local_2]) != null) ? (this._friends[_local_2].vo as FriendVO) : new FriendVO(Player.fromPlayerXML(_local_2, _local_6.Character[0])));
            if (_local_6.hasOwnProperty("Online")) {
                _local_4 = String(_local_6.Online);
                _local_3 = this.serverNameDictionary()[_local_4];
                _local_5.online(_local_3, _local_4);
                this._onlineFriends.push(_local_5);
                this._friends[_local_5.getName()] = {
                    "vo": _local_5,
                    "list": this._onlineFriends
                };
            }
            else {
                _local_5.offline();
                this._offlineFriends.push(_local_5);
                this._friends[_local_5.getName()] = {
                    "vo": _local_5,
                    "list": this._offlineFriends
                };
            }
        }
        this._onlineFriends.sort(this.sortFriend);
        this._offlineFriends.sort(this.sortFriend);
        this._friendTotal = (this._onlineFriends.length + this._offlineFriends.length);
    }

    public function seedInvitations(_arg_1:XML):void {
        var _local_2:String;
        var _local_3:XML;
        var _local_4:Player;
        this._invitations = new Dictionary(true);
        this._invitationTotal = 0;
        for each (_local_3 in _arg_1.Account) {
            if (this.starFilter(int(_local_3.Character[0].ObjectType), int(_local_3.Character[0].CurrentFame), _local_3.Stats[0])) {
                _local_2 = _local_3.Name;
                _local_4 = Player.fromPlayerXML(_local_2, _local_3.Character[0]);
                this._invitations[_local_2] = new FriendVO(_local_4);
                this._invitationTotal++;
            }
        }
    }

    public function isMyFriend(_arg_1:String):Boolean {
        return (!((this._friends[_arg_1] == null)));
    }

    public function updateFriendVO(_arg_1:String, _arg_2:Player):void {
        var _local_3:Object;
        var _local_4:FriendVO;
        if (this.isMyFriend(_arg_1)) {
            _local_3 = this._friends[_arg_1];
            _local_4 = (_local_3.vo as FriendVO);
            _local_4.updatePlayer(_arg_2);
        }
    }

    public function getFilterFriends(_arg_1:String):Vector.<FriendVO> {
        var _local_3:FriendVO;
        var _local_2:RegExp = new RegExp(_arg_1, "gix");
        var _local_4:Vector.<FriendVO> = new Vector.<FriendVO>();
        var _local_5:int = 0;
        while (_local_5 < this._onlineFriends.length) {
            _local_3 = this._onlineFriends[_local_5];
            if (_local_3.getName().search(_local_2) >= 0) {
                _local_4.push(_local_3);
            }
            _local_5++;
        }
        _local_5 = 0;
        while (_local_5 < this._offlineFriends.length) {
            _local_3 = this._offlineFriends[_local_5];
            if (_local_3.getName().search(_local_2) >= 0) {
                _local_4.push(_local_3);
            }
            _local_5++;
        }
        return (_local_4);
    }

    public function ifReachMax():Boolean {
        return ((this._friendTotal >= FriendConstant.FRIEMD_MAX_CAP));
    }

    public function getAllFriends():Vector.<FriendVO> {
        return (this._onlineFriends.concat(this._offlineFriends));
    }

    public function getAllInvitations():Vector.<FriendVO> {
        var _local_2:FriendVO;
        var _local_1:* = new Vector.<FriendVO>();
        for each (_local_2 in this._invitations) {
            _local_1.push(_local_2);
        }
        _local_1.sort(this.sortFriend);
        return (_local_1);
    }

    public function removeFriend(_arg_1:String):Boolean {
        var _local_2:Object = this._friends[_arg_1];
        if (_local_2) {
            this.removeFromList(_local_2.list, _arg_1);
            this._friends[_arg_1] = null;
            delete this._friends[_arg_1];
            return (true);
        }
        return (false);
    }

    public function removeInvitation(_arg_1:String):Boolean {
        if (this._invitations[_arg_1] != null) {
            this._invitations[_arg_1] = null;
            delete this._invitations[_arg_1];
            return (true);
        }
        return (false);
    }

    private function removeFromList(_arg_1:Vector.<FriendVO>, _arg_2:String):void {
        var _local_3:FriendVO;
        var _local_4:int = 0;
        while (_local_4 < _arg_1.length) {
            _local_3 = _arg_1[_local_4];
            if (_local_3.getName() == _arg_2) {
                _arg_1.slice(_local_4, 1);
                return;
            }
            _local_4++;
        }
    }

    private function sortFriend(_arg_1:FriendVO, _arg_2:FriendVO):Number {
        if (_arg_1.getName() < _arg_2.getName()) {
            return (-1);
        }
        if (_arg_1.getName() > _arg_2.getName()) {
            return (1);
        }
        return (0);
    }

    private function serverNameDictionary():Dictionary {
        var _local_2:Server;
        if (this._serverDict) {
            return (this._serverDict);
        }
        var _local_1:Vector.<Server> = this.serverModel.getServers();
        this._serverDict = new Dictionary(true);
        for each (_local_2 in _local_1) {
            this._serverDict[_local_2.address] = _local_2.name;
        }
        return (this._serverDict);
    }

    private function starFilter(_arg_1:int, _arg_2:int, _arg_3:XML):Boolean {
        return ((FameUtil.numAllTimeStars(_arg_1, _arg_2, _arg_3) >= Parameters.data_.friendStarRequirement));
    }


}
}//package kabam.rotmg.friends.model
