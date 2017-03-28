package kabam.rotmg.friends.model {
import com.company.assembleegameclient.objects.Player;

import flash.display.BitmapData;

public class FriendVO {

    public var playerName:String;
    private var _player:Player;
    private var _isOnline:Boolean;
    private var _serverName:String;
    private var _serverAddr:String;

    public function FriendVO(_arg_1:Player, _arg_2:Boolean = false, _arg_3:String = "", _arg_4:String = "") {
        this._player = _arg_1;
        this._isOnline = _arg_2;
        this._serverName = _arg_3;
        this._serverAddr = _arg_4;
        this.playerName = this._player.getName();
    }

    public function updatePlayer(_arg_1:Player):void {
        this._player = _arg_1;
        this.playerName = this._player.getName();
    }

    public function getServerName():String {
        return (this._serverName);
    }

    public function getName():String {
        return (this._player.getName());
    }

    public function getPortrait():BitmapData {
        return (this._player.getPortrait());
    }

    public function get isOnline():Boolean {
        return (this._isOnline);
    }

    public function online(_arg_1:String, _arg_2:String):void {
        this._isOnline = true;
        this._serverName = _arg_1;
        this._serverAddr = _arg_2;
    }

    public function offline():void {
        this._isOnline = false;
        this._serverName = "";
        this._serverAddr = "";
    }


}
}//package kabam.rotmg.friends.model
