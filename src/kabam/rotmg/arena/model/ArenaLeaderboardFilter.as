package kabam.rotmg.arena.model {
public class ArenaLeaderboardFilter {

    private var name:String;
    private var key:String;
    private var entries:Vector.<ArenaLeaderboardEntry>;

    public function ArenaLeaderboardFilter(_arg_1:String, _arg_2:String) {
        this.name = _arg_1;
        this.key = _arg_2;
    }

    public function getName():String {
        return (this.name);
    }

    public function getKey():String {
        return (this.key);
    }

    public function getEntries():Vector.<ArenaLeaderboardEntry> {
        return (this.entries);
    }

    public function setEntries(_arg_1:Vector.<ArenaLeaderboardEntry>):void {
        this.entries = _arg_1;
    }

    public function hasEntries():Boolean {
        return (!((this.entries == null)));
    }

    public function clearEntries():void {
        this.entries = null;
    }


}
}//package kabam.rotmg.arena.model
