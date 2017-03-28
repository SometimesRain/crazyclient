package kabam.rotmg.pets.data {
import com.company.assembleegameclient.objects.ObjectLibrary;

import org.osflash.signals.Signal;

public class AbilityVO {

    public const updated:Signal = new Signal(AbilityVO);

    private var _type:uint;
    private var _staticData:XML;
    public var level:int;
    public var points:int;
    public var name:String;
    public var description:String;
    private var unlocked:Boolean;


    public function set type(_arg_1:uint):void {
        this._type = _arg_1;
        this._staticData = ObjectLibrary.getPetDataXMLByType(this._type);
		this.name = this._staticData.DisplayId == undefined ? this._staticData.@id : this._staticData.DisplayId;
        this.description = this._staticData.Description;
    }

    public function setUnlocked(_arg_1:Boolean):void {
        this.unlocked = _arg_1;
    }

    public function getUnlocked():Boolean {
        return (this.unlocked);
    }


}
}//package kabam.rotmg.pets.data
