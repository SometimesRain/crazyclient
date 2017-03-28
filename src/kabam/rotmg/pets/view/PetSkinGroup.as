package kabam.rotmg.pets.view {
import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.pets.data.PetSkinGroupVO;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.util.PetsConstants;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.PetIcon;
import kabam.rotmg.pets.view.components.PetIconFactory;
import kabam.rotmg.pets.view.components.slot.FeedFuseSlot;
import kabam.rotmg.pets.view.dialogs.PetItem;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeSignal;

public class PetSkinGroup extends Sprite {

    private const SPACING:uint = 55;
    public const initComplete:Signal = new Signal();

    private var rarityTextField:TextFieldDisplayConcrete;
    private var upperContainer:Sprite;
    private var lowerContainer:Sprite;
    private var numUpper:uint = 0;
    private var numLower:uint = 0;
    private var petSkinGroupVO:PetSkinGroupVO;
    private var selectedSlot:FeedFuseSlot;
    private var slots:Vector.<FeedFuseSlot>;
    public var skinSelected:Signal;
    public var disabled:Boolean = false;
    public var index:uint;

    public function PetSkinGroup(_arg_1:uint) {
        this.rarityTextField = PetsViewAssetFactory.returnTextfield(0xFFFFFF, 18, true);
        this.upperContainer = new Sprite();
        this.lowerContainer = new Sprite();
        this.slots = new Vector.<FeedFuseSlot>();
        this.skinSelected = new Signal(PetVO);
        super();
        this.index = _arg_1;
    }

    public function init(_arg_1:PetSkinGroupVO):void {
        this.petSkinGroupVO = _arg_1;
        this.rarityTextField.setStringBuilder(new LineBuilder().setParams(_arg_1.textKey));
        this.createIconSquares();
        this.addChildren();
        this.positionChildren();
        this.initComplete.dispatch();
    }

    private function positionChildren():void {
        this.upperContainer.x = ((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.upperContainer.width) / 2);
        this.lowerContainer.x = ((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.lowerContainer.width) / 2);
        this.lowerContainer.y = 50;
    }

    private function addChildren():void {
        addChild(this.rarityTextField);
        addChild(this.upperContainer);
        addChild(this.lowerContainer);
    }

    private function createIconSquares():void {
        var _local_1:uint;
        var _local_3:PetIcon;
        var _local_4:PetItem;
        var _local_5:FeedFuseSlot;
        var _local_6:NativeSignal;
        var _local_2:uint = this.petSkinGroupVO.icons.length;
        _local_1 = 0;
        while (_local_1 < _local_2) {
            _local_3 = this.createPetIcon(this.petSkinGroupVO.icons[_local_1], 48);
            _local_4 = new PetItem();
            _local_4.setPetIcon(_local_3);
            _local_5 = new FeedFuseSlot();
            _local_5.mouseChildren = false;
            _local_5.setIcon(_local_4);
            _local_6 = new NativeSignal(_local_5, MouseEvent.CLICK, MouseEvent);
            _local_6.add(this.onSkinClicked);
            if ((_local_1 < 4)) {
                this.addToUpper(_local_5);
            }
            else {
                this.addToLower(_local_5);
            }
            this.slots.push(_local_5);
            if (this.disabled) {
                _local_4.disable();
                _local_5.mouseChildren = false;
                _local_5.mouseEnabled = false;
            }
            _local_1++;
        }
    }

    private function createPetIcon(_arg_1:PetVO, _arg_2:int):PetIcon {
        var _local_3:PetIconFactory = new PetIconFactory();
        var _local_4:PetIcon = _local_3.create(_arg_1, _arg_2);
        _local_4.setTooltipEnabled(false);
        return (_local_4);
    }

    private function onSkinClicked(_arg_1:MouseEvent):void {
        this.skinSelected.dispatch(PetItem(_arg_1.target.getIcon()).getPetVO());
    }

    private function addToUpper(_arg_1:Sprite):void {
        _arg_1.x = (this.SPACING * this.numUpper);
        this.upperContainer.addChild(_arg_1);
        this.numUpper++;
    }

    private function addToLower(_arg_1:Sprite):void {
        _arg_1.x = (this.SPACING * this.numLower);
        this.lowerContainer.addChild(_arg_1);
        this.numLower++;
    }

    public function onSlotSelected(_arg_1:int):void {
        var _local_2:FeedFuseSlot;
        var _local_3:int;
        var _local_4:uint;
        while (_local_4 < this.slots.length) {
            _local_2 = FeedFuseSlot(this.slots[_local_4]);
            _local_3 = PetItem(_local_2.getIcon()).getPetVO().getSkinID();
            _local_2.highlight((_local_3 == _arg_1));
            _local_4++;
        }
    }


}
}//package kabam.rotmg.pets.view
