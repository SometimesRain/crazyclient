package kabam.rotmg.arena.model {
import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.pets.data.PetsModel;

import org.osflash.signals.Signal;

public class CurrentArenaRunModel {

    public const waveUpdated:Signal = new Signal();

    [Inject]
    public var gameModel:GameModel;
    [Inject]
    public var petModel:PetsModel;
    [Inject]
    public var classesModel:ClassesModel;
    [Inject]
    public var factory:CharacterFactory;
    public var died:Boolean = false;
    public var entry:ArenaLeaderboardEntry;
    public var costOfContinue:int = 0;

    public function CurrentArenaRunModel() {
        this.entry = new ArenaLeaderboardEntry();
        super();
        this.clear();
    }

    public function clear():void {
        this.died = false;
        this.entry.currentWave = 0;
        this.entry.runtime = -1;
    }

    public function incrementWave():void {
        if (this.died) {
            this.died = false;
        }
        else {
            this.entry.currentWave++;
            this.waveUpdated.dispatch();
        }
    }

    public function hasEntry():Boolean {
        return (!((this.entry.runtime == -1)));
    }

    public function saveCurrentUserInfo():void {
        this.clear();
        this.entry.name = this.gameModel.player.name_;
        var _local_1:CharacterSkin = this.classesModel.getCharacterClass(this.gameModel.player.objectType_).skins.getSkin(this.gameModel.player.skinId);
        this.entry.playerBitmap = this.factory.makeIcon(_local_1.template, _local_1.is16x16 ? 50 : 100,this.gameModel.player.getTex1(), this.gameModel.player.getTex2());
        this.entry.pet = this.petModel.getActivePet();
        this.entry.guildName = this.gameModel.player.guildName_;
        this.entry.guildRank = this.gameModel.player.guildRank_;
        this.entry.slotTypes = this.gameModel.player.slotTypes_.concat();
        this.entry.equipment = this.gameModel.player.equipment_.concat();
        this.entry.isPersonalRecord = true;
    }


}
}//package kabam.rotmg.arena.model
