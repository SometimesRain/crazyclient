package com.company.assembleegameclient.game.events {
import flash.events.Event;
import flash.utils.ByteArray;

import kabam.rotmg.servers.api.Server;

public class ReconnectEvent extends Event {

    public static const RECONNECT:String = "RECONNECT_EVENT";

    public var server_:Server;
    public var gameId_:int;
    public var createCharacter_:Boolean;
    public var charId_:int;
    public var keyTime_:int;
    public var key_:ByteArray;
    public var isFromArena_:Boolean;

    public function ReconnectEvent(_arg_1:Server, _arg_2:int, _arg_3:Boolean, _arg_4:int, _arg_5:int, _arg_6:ByteArray, _arg_7:Boolean) {
        super(RECONNECT);
        this.server_ = _arg_1;
        this.gameId_ = _arg_2;
        this.createCharacter_ = _arg_3;
        this.charId_ = _arg_4;
        this.keyTime_ = _arg_5;
        this.key_ = _arg_6;
        this.isFromArena_ = _arg_7;
    }

    override public function clone():Event {
        return (new ReconnectEvent(this.server_, this.gameId_, this.createCharacter_, this.charId_, this.keyTime_, this.key_, this.isFromArena_));
    }

    override public function toString():String {
        return (formatToString(RECONNECT, "server_", "gameId_", "charId_", "keyTime_", "key_", "isFromArena_"));
    }


}
}//package com.company.assembleegameclient.game.events
