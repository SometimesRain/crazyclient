package kabam.rotmg.game.model {
import flash.utils.ByteArray;

import kabam.rotmg.servers.api.Server;

public class GameInitData {

    public var server:Server;
    public var gameId:int;
    public var createCharacter:Boolean;
    public var charId:int;
    public var keyTime:int;
    public var key:ByteArray;
    public var isNewGame:Boolean;
    public var isFromArena:Boolean;


}
}//package kabam.rotmg.game.model
