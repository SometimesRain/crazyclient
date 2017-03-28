package kabam.rotmg.pets.view {
import com.company.assembleegameclient.ui.DeprecatedTextButton;
import com.company.assembleegameclient.ui.dialogs.DialogCloser;

import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.lib.ui.api.Size;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.data.ReskinViewState;
import kabam.rotmg.pets.util.PetsConstants;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.pets.view.dialogs.PetPicker;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeSignal;

public class PetFormView extends PetInteractionView implements DialogCloser {

    private static const closeDialogSignal:Signal = new Signal();

    private const background:PopupWindowBackground = PetsViewAssetFactory.returnFuserWindowBackground();
    private const titleTextfield:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTopAlignedTextfield(0xB3B3B3, 18, true);
    private const closeButton:DialogCloseButton = PetsViewAssetFactory.returnCloseButton(PetsConstants.WINDOW_BACKGROUND_WIDTH);
    private const NUM_CATEGORIES:int = 3;
    public const closed:Signal = new Signal();
    public const skinGroupsInitialized:Signal = new Signal();
    public const reskinRequest:Signal = new Signal();

    private var petPickerContainer:Sprite;
    private var reskinContainer:Sprite;
    private var skinGroups:Vector.<PetSkinGroup>;
    private var posY:uint = 60;
    public var reskinButton:DeprecatedTextButton;
    public var reskinButtonClick:NativeSignal;
    public var skinGroupInitCount:uint = 0;

    public function PetFormView() {
        this.petPickerContainer = new Sprite();
        this.reskinContainer = new Sprite();
        this.reskinButton = new DeprecatedTextButton(14, TextKey.PET_RESKIN_BUTTON_CHOOSE);
        this.reskinButtonClick = new NativeSignal(this.reskinButton, MouseEvent.CLICK);
        super();
    }

    public function init():void {
        this.titleTextfield.setStringBuilder(new LineBuilder().setParams(TextKey.PET_RESKIN_TITLE));
        this.closeButton.clicked.add(this.onClose);
        this.reskinButtonClick.add(this.onReskinClick);
        this.reskinButton.textChanged.add(this.positionReskinButton);
        this.waitForTextChanged();
        this.addChildren();
        this.positionAssets();
    }

    private function onReskinClick(_arg_1:MouseEvent):void {
        this.reskinRequest.dispatch();
    }

    public function createSkinGroups(_arg_1:Vector.<PetSkinGroup>):void {
        var _local_2:PetSkinGroup;
        var _local_3:uint;
        while (_local_3 < this.NUM_CATEGORIES) {
            _local_2 = _arg_1[_local_3];
            this.skinGroups = _arg_1;
            _arg_1[_local_3].initComplete.add(this.onSkinGroupInit);
            this.reskinContainer.addChild(_arg_1[_local_3]);
            _local_3++;
        }
    }

    public function onSkinGroupInit():void {
        this.skinGroupInitCount++;
        if (this.skinGroupInitCount == this.NUM_CATEGORIES) {
            this.positionSkinGroups();
            this.skinGroupsInitialized.dispatch();
        }
    }

    private function positionSkinGroups():void {
        var _local_1:uint;
        _local_1 = 0;
        while (_local_1 < this.NUM_CATEGORIES) {
            this.skinGroups[_local_1].x = 0;
            this.skinGroups[_local_1].y = this.posY;
            this.posY = (this.posY + this.skinGroups[_local_1].height);
            _local_1++;
        }
        this.reskinButton.y = (this.posY + 10);
        this.background.height = (this.posY + 50);
    }

    public function createPetPicker(_arg_1:PetPicker, _arg_2:Vector.<PetVO>):void {
        _arg_1.setSize(new Size((this.background.width - 10), 240));
        _arg_1.setPadding(5);
        _arg_1.setPetSize(52);
        _arg_1.doDisableUsed = false;
        this.petPickerContainer.addChild(_arg_1);
        this.petPickerContainer.x = 4;
        this.petPickerContainer.y = 35;
    }

    private function onFameOrGoldClicked():void {
        closeDialogSignal.dispatch();
    }

    private function addChildren():void {
        addChild(this.background);
        addChild(this.titleTextfield);
        addChild(this.closeButton);
        this.reskinContainer.addChild(this.reskinButton);
    }

    private function positionAssets():void {
        positionThis();
    }

    private function positionReskinButton():void {
        this.reskinButton.x = ((this.background.width - this.reskinButton.width) / 2);
        this.reskinButton.y = (this.background.height - (this.reskinButton.height + 10));
    }

    private function waitForTextChanged():void {
        var _local_1:SignalWaiter = new SignalWaiter();
        _local_1.push(this.titleTextfield.textChanged);
        _local_1.complete.addOnce(this.positionTextField);
    }

    private function positionTextField():void {
        this.titleTextfield.y = 5;
        this.titleTextfield.x = ((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.titleTextfield.width) * 0.5);
    }

    private function onClose():void {
        this.closed.dispatch();
    }

    public function getCloseSignal():Signal {
        return (closeDialogSignal);
    }

    public function setState(_arg_1:String):void {
        if (_arg_1 == ReskinViewState.PETPICKER) {
            addChild(this.petPickerContainer);
            if (contains(this.reskinContainer)) {
                removeChild(this.reskinContainer);
            }
        }
        else {
            if (_arg_1 == ReskinViewState.SKINPICKER) {
                addChild(this.reskinContainer);
                if (contains(this.petPickerContainer)) {
                    removeChild(this.petPickerContainer);
                }
            }
        }
    }


}
}//package kabam.rotmg.pets.view
