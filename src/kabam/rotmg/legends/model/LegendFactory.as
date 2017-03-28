package kabam.rotmg.legends.model {
import com.company.util.ConversionUtil;

import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.core.model.PlayerModel;

public class LegendFactory {

    [Inject]
    public var playerModel:PlayerModel;
    [Inject]
    public var classesModel:ClassesModel;
    [Inject]
    public var factory:CharacterFactory;
    private var ownAccountId:String;
    private var legends:Vector.<Legend>;


    public function makeLegends(_arg_1:XML):Vector.<Legend> {
        this.ownAccountId = this.playerModel.getAccountId();
        this.legends = new Vector.<Legend>(0);
        this.makeLegendsFromList(_arg_1.FameListElem, false);
        this.makeLegendsFromList(_arg_1.MyFameListElem, true);
        return (this.legends);
    }

    private function makeLegendsFromList(_arg_1:XMLList, _arg_2:Boolean):void {
        var _local_3:XML;
        var _local_4:Legend;
        for each (_local_3 in _arg_1) {
            if (!this.legendsContains(_local_3)) {
                _local_4 = this.makeLegend(_local_3);
                _local_4.isOwnLegend = (_local_3.@accountId == this.ownAccountId);
                _local_4.isFocus = _arg_2;
                this.legends.push(_local_4);
            }
        }
    }

    private function legendsContains(_arg_1:XML):Boolean {
        var _local_2:Legend;
        for each (_local_2 in this.legends) {
            if ((((_local_2.accountId == _arg_1.@accountId)) && ((_local_2.charId == _arg_1.@charId)))) {
                return (true);
            }
        }
        return (false);
    }

    public function makeLegend(_arg_1:XML):Legend {
        var _local_2:int = _arg_1.ObjectType;
        var _local_3:int = _arg_1.Texture;
        var _local_4:CharacterClass = this.classesModel.getCharacterClass(_local_2);
        var _local_5:CharacterSkin = _local_4.skins.getSkin(_local_3);
        var _local_6:int = ((_arg_1.hasOwnProperty("Tex1")) ? _arg_1.Tex1 : 0);
        var _local_7:int = ((_arg_1.hasOwnProperty("Tex2")) ? _arg_1.Tex2 : 0);
        var _local_8:int = _local_5.is16x16 ? 50 : 100;
        var _local_9:Legend = new Legend();
        _local_9.accountId = _arg_1.@accountId;
        _local_9.charId = _arg_1.@charId;
        _local_9.name = _arg_1.Name;
        _local_9.totalFame = _arg_1.TotalFame;
        _local_9.character = this.factory.makeIcon(_local_5.template, _local_8, _local_6, _local_7);
        _local_9.equipmentSlots = _local_4.slotTypes;
        _local_9.equipment = ConversionUtil.toIntVector(_arg_1.Equipment);
        return _local_9;
    }


}
}//package kabam.rotmg.legends.model
