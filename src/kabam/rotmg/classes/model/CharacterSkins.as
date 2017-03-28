package kabam.rotmg.classes.model {
	import com.company.assembleegameclient.parameters.Parameters;
public class CharacterSkins {

    private const skins:Vector.<CharacterSkin> = new Vector.<CharacterSkin>(0);
    private const map:Object = {};

    private var defaultSkin:CharacterSkin;
    private var selectedSkin:CharacterSkin;
    private var maxLevelAchieved:int;


    public function getCount():int {
        return (this.skins.length);
    }

    public function getDefaultSkin():CharacterSkin {
        return (this.defaultSkin);
    }

    public function getSelectedSkin():CharacterSkin {
		if(!Parameters.data_["showSkins"]) {
			return (this.defaultSkin);
		}
		return (this.selectedSkin);
    }

    public function getSkinAt(_arg_1:int):CharacterSkin {
        return (this.skins[_arg_1]);
    }

    public function addSkin(_arg_1:CharacterSkin, _arg_2:Boolean = false):void {
        _arg_1.changed.add(this.onSkinChanged);
        this.skins.push(_arg_1);
        this.map[_arg_1.id] = _arg_1;
        this.updateSkinState(_arg_1);
        if (_arg_2) {
            this.defaultSkin = _arg_1;
            if (!this.selectedSkin) {
                this.selectedSkin = _arg_1;
                _arg_1.setIsSelected(true);
            }
        }
        else {
            if (_arg_1.getIsSelected()) {
                this.selectedSkin = _arg_1;
            }
        }
    }

    private function onSkinChanged(_arg_1:CharacterSkin):void {
        if (((_arg_1.getIsSelected()) && (!((this.selectedSkin == _arg_1))))) {
            ((this.selectedSkin) && (this.selectedSkin.setIsSelected(false)));
            this.selectedSkin = _arg_1;
        }
    }

    public function updateSkins(_arg_1:int):void {
        var _local_2:CharacterSkin;
        this.maxLevelAchieved = _arg_1;
        for each (_local_2 in this.skins) {
            this.updateSkinState(_local_2);
        }
    }

    private function updateSkinState(_arg_1:CharacterSkin):void {
        if (!_arg_1.skinSelectEnabled) {
            _arg_1.setState(CharacterSkinState.UNLISTED);
        }
        else {
            if (_arg_1.getState().isSkinStateDeterminedByLevel()) {
                _arg_1.setState(this.getSkinState(_arg_1));
            }
        }
    }

    private function getSkinState(_arg_1:CharacterSkin):CharacterSkinState {
        //return (CharacterSkinState.OWNED); //makes all skins available
        if (!_arg_1.skinSelectEnabled) {
            return (CharacterSkinState.UNLISTED);
        }
        if ((((this.maxLevelAchieved >= _arg_1.unlockLevel)) && ((_arg_1.unlockSpecial == null)))) {
            return (CharacterSkinState.PURCHASABLE);
        }
        return (CharacterSkinState.LOCKED);
    }

    public function getSkin(_arg_1:int):CharacterSkin {
        return (((this.map[_arg_1]) || (this.defaultSkin)));
    }

    public function getListedSkins():Vector.<CharacterSkin> {
        var _local_2:CharacterSkin;
        var _local_1:Vector.<CharacterSkin> = new Vector.<CharacterSkin>();
        for each (_local_2 in this.skins) {
            if (_local_2.getState() != CharacterSkinState.UNLISTED) {
                _local_1.push(_local_2);
            }
        }
        return (_local_1);
    }


}
}//package kabam.rotmg.classes.model
