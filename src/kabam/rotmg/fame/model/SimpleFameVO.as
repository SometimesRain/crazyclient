package kabam.rotmg.fame.model {
public class SimpleFameVO implements FameVO {

    private var accountId:String;
    private var characterId:int;

    public function SimpleFameVO(_arg_1:String, _arg_2:int) {
        this.accountId = _arg_1;
        this.characterId = _arg_2;
    }

    public function getAccountId():String {
        return (this.accountId);
    }

    public function getCharacterId():int {
        return (this.characterId);
    }


}
}//package kabam.rotmg.fame.model
