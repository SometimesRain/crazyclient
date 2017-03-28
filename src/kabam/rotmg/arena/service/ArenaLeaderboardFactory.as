package kabam.rotmg.arena.service {
import com.company.util.ConversionUtil;

import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
import kabam.rotmg.arena.model.CurrentArenaRunModel;
import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.pets.data.PetVO;

public class ArenaLeaderboardFactory {

    [Inject]
    public var classesModel:ClassesModel;
    [Inject]
    public var factory:CharacterFactory;
    [Inject]
    public var currentRunModel:CurrentArenaRunModel;


    public function makeEntries(_arg_1:XMLList):Vector.<ArenaLeaderboardEntry> {
        var _local_4:XML;
        var _local_2:Vector.<ArenaLeaderboardEntry> = new Vector.<ArenaLeaderboardEntry>();
        var _local_3:int = 1;
        for each (_local_4 in _arg_1) {
            _local_2.push(this.makeArenaEntry(_local_4, _local_3));
            _local_3++;
        }
        _local_2 = this.removeDuplicateUser(_local_2);
        return (this.addCurrentRun(_local_2));
    }

    private function addCurrentRun(_arg_1:Vector.<ArenaLeaderboardEntry>):Vector.<ArenaLeaderboardEntry> {
        var _local_3:Boolean;
        var _local_4:Boolean;
        var _local_5:ArenaLeaderboardEntry;
        var _local_2:Vector.<ArenaLeaderboardEntry> = new Vector.<ArenaLeaderboardEntry>();
        if (this.currentRunModel.hasEntry()) {
            _local_3 = false;
            _local_4 = false;
            for each (_local_5 in _arg_1) {
                if (((!(_local_3)) && (this.currentRunModel.entry.isBetterThan(_local_5)))) {
                    this.currentRunModel.entry.rank = _local_5.rank;
                    _local_2.push(this.currentRunModel.entry);
                    _local_3 = true;
                }
                if (_local_5.isPersonalRecord) {
                    _local_4 = true;
                }
                if (_local_3) {
                    _local_5.rank++;
                }
                _local_2.push(_local_5);
            }
            if ((((((_local_2.length < 20)) && (!(_local_3)))) && (!(_local_4)))) {
                this.currentRunModel.entry.rank = (_local_2.length + 1);
                _local_2.push(this.currentRunModel.entry);
            }
        }
        return ((((_local_2.length > 0)) ? _local_2 : _arg_1));
    }

    private function removeDuplicateUser(_arg_1:Vector.<ArenaLeaderboardEntry>):Vector.<ArenaLeaderboardEntry> {
        var _local_3:Boolean;
        var _local_4:ArenaLeaderboardEntry;
        var _local_5:ArenaLeaderboardEntry;
        var _local_2:int = -1;
        if (this.currentRunModel.hasEntry()) {
            _local_3 = false;
            _local_4 = this.currentRunModel.entry;
            for each (_local_5 in _arg_1) {
                if (((_local_5.isPersonalRecord) && (_local_4.isBetterThan(_local_5)))) {
                    _local_2 = (_local_5.rank - 1);
                    _local_3 = true;
                }
                else {
                    if (_local_3) {
                        _local_5.rank--;
                    }
                }
            }
        }
        if (_local_2 != -1) {
            _arg_1.splice(_local_2, 1);
        }
        return (_arg_1);
    }

    private function makeArenaEntry(_arg_1:XML, _arg_2:int):ArenaLeaderboardEntry {
        var _local_10:PetVO;
        var _local_11:XML;
        var _local_3:ArenaLeaderboardEntry = new ArenaLeaderboardEntry();
        _local_3.isPersonalRecord = _arg_1.hasOwnProperty("IsPersonalRecord");
        _local_3.runtime = _arg_1.Time;
        _local_3.name = _arg_1.PlayData.CharacterData.Name;
        _local_3.rank = ((_arg_1.hasOwnProperty("Rank")) ? _arg_1.Rank : _arg_2);
        var _local_4:int = _arg_1.PlayData.CharacterData.Texture;
        var _local_5:int = _arg_1.PlayData.CharacterData.Class;
        var _local_6:CharacterClass = this.classesModel.getCharacterClass(_local_5);
        var _local_7:CharacterSkin = _local_6.skins.getSkin(_local_4);
        var _local_8:int = ((_arg_1.PlayData.CharacterData.hasOwnProperty("Tex1")) ? _arg_1.PlayData.CharacterData.Tex1 : 0);
        var _local_9:int = ((_arg_1.PlayData.CharacterData.hasOwnProperty("Tex2")) ? _arg_1.PlayData.CharacterData.Tex2 : 0);
        _local_3.playerBitmap = this.factory.makeIcon(_local_7.template, _local_7.is16x16 ? 50: 100, _local_8, _local_9);
        _local_3.equipment = ConversionUtil.toIntVector(_arg_1.PlayData.CharacterData.Inventory);
        _local_3.slotTypes = _local_6.slotTypes;
        _local_3.guildName = _arg_1.PlayData.CharacterData.GuildName;
        _local_3.guildRank = _arg_1.PlayData.CharacterData.GuildRank;
        _local_3.currentWave = _arg_1.WaveNumber;
        if (_arg_1.PlayData.hasOwnProperty("Pet")) {
            _local_10 = new PetVO();
            _local_11 = new XML(_arg_1.PlayData.Pet);
            _local_10.apply(_local_11);
            _local_3.pet = _local_10;
        }
        return (_local_3);
    }


}
}//package kabam.rotmg.arena.service
