package kabam.rotmg.classes.model {
import org.osflash.signals.Signal;

public class CharacterClass {

    public const selected:Signal = new Signal(CharacterClass);
    public const unlocks:Vector.<CharacterClassUnlock> = new Vector.<CharacterClassUnlock>(0);
    public const skins:CharacterSkins = new CharacterSkins();

    public var id:int;
    public var name:String;
    public var description:String;
    public var hitSound:String;
    public var deathSound:String;
    public var bloodProb:Number;
    public var slotTypes:Vector.<int>;
    public var defaultEquipment:Vector.<int>;
    public var hp:CharacterClassStat;
    public var mp:CharacterClassStat;
    public var attack:CharacterClassStat;
    public var defense:CharacterClassStat;
    public var speed:CharacterClassStat;
    public var dexterity:CharacterClassStat;
    public var hpRegeneration:CharacterClassStat;
    public var mpRegeneration:CharacterClassStat;
    public var unlockCost:int;
    private var maxLevelAchieved:int;
    private var isSelected:Boolean;


    public function getIsSelected():Boolean {
        return (this.isSelected);
    }

    public function setIsSelected(_arg_1:Boolean):void {
        if (this.isSelected != _arg_1) {
            this.isSelected = _arg_1;
            ((this.isSelected) && (this.selected.dispatch(this)));
        }
    }

    public function getMaxLevelAchieved():int {
        return (this.maxLevelAchieved);
    }

    public function setMaxLevelAchieved(_arg_1:int):void {
        this.maxLevelAchieved = _arg_1;
        this.skins.updateSkins(this.maxLevelAchieved);
    }


}
}//package kabam.rotmg.classes.model
