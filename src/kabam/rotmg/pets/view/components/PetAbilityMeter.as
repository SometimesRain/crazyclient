package kabam.rotmg.pets.view.components {
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.pets.data.AbilityVO;
import kabam.rotmg.pets.util.PetsAbilityLevelHelper;
import kabam.rotmg.pets.util.PetsConstants;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.Signal;

public class PetAbilityMeter extends Sprite implements TooltipAble {

    public const animating:Signal = new Signal(PetAbilityMeter, Boolean);
    private const labelTextfield:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTopAlignedTextfield(0xB3B3B3, 14, true, true);
    private const levelTextfield:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTopAlignedTextfield(0xB3B3B3, 14, true, true);
    private const abilityBar:AnimatedAbilityBar = new AnimatedAbilityBar(PetsConstants.PET_ABILITY_BAR_WIDTH, PetsConstants.PET_ABILITY_BAR_HEIGHT);

    private var unlocked:Boolean = true;
    private var pointsShown:int = 0;
    private var levelShown:int = 0;
    private var pointsLeftToAdd:Number = 0;
    public var positioned:Signal;
    public var max:int;
    public var index:int;
    private var tooltipDelegate:HoverTooltipDelegate;

    public function PetAbilityMeter() {
        this.positioned = new Signal();
        this.tooltipDelegate = new HoverTooltipDelegate();
        super();
        this.abilityBar.animating.add(this.onAnimatingBar);
        this.waitForTextChanged();
        this.addChildren();
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.tooltipDelegate.setDisplayObject(this);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        this.abilityBar.animating.remove(this.onAnimatingBar);
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    public function initializeData(_arg_1:AbilityVO):void {
        var _local_2:int;
        var _local_3:int;
        this.pointsShown = _arg_1.points;
        this.levelShown = _arg_1.level;
        this.setAbilityLabel(_arg_1.name);
        this.setUnlocked(_arg_1.getUnlocked());
        this.setLevelLabel(((this.unlocked) ? _arg_1.level : 0));
        this.onAnimatingBar(false);
        this.tooltipDelegate.tooltip = new PetAbilityTooltip(_arg_1);
        if (this.unlocked) {
            _local_2 = Math.max(0, PetsAbilityLevelHelper.getCurrentPointsForLevel(_arg_1.points, _arg_1.level));
            _local_3 = PetsAbilityLevelHelper.getAbilityPointsforLevel(_arg_1.level);
            _local_2 = (((_arg_1.level >= this.max)) ? _local_3 : _local_2);
            this.setAbilityBar(_local_2, _local_3);
        }
        _arg_1.updated.add(this.updateData);
    }

    private function updateData(_arg_1:AbilityVO):void {
        var _local_2:Number;
        this.setUnlocked(_arg_1.getUnlocked());
        if ((((_arg_1.points > this.pointsShown)) && (this.unlocked))) {
            this.pointsShown = _arg_1.points;
            this.pointsLeftToAdd = PetsAbilityLevelHelper.getCurrentPointsForLevel(_arg_1.points, this.levelShown);
            _local_2 = PetsAbilityLevelHelper.getAbilityPointsforLevel(this.levelShown);
            if (((!((_local_2 == 0))) && ((this.pointsLeftToAdd > _local_2)))) {
                this.pointsLeftToAdd = (this.pointsLeftToAdd - _local_2);
                this.abilityBar.filledUp.add(this.onChainedFill);
                this.abilityBar.fill();
                this.onAnimatingBar(true);
            }
            else {
                this.setAbilityBar(this.pointsLeftToAdd, _local_2);
            }
        }
    }

    private function onChainedFill():void {
        var _local_2:Number;
        this.levelShown++;
        this.setLevelLabel(this.levelShown, true);
        _local_2 = PetsAbilityLevelHelper.getAbilityPointsforLevel(this.levelShown);
        if (this.pointsLeftToAdd > _local_2) {
            this.abilityBar.reset();
            this.pointsLeftToAdd = (this.pointsLeftToAdd - _local_2);
            this.abilityBar.fill();
        }
        else {
            this.abilityBar.filledUp.remove(this.onChainedFill);
            if (this.levelShown >= this.max) {
                this.abilityBar.handleTweenComplete(null);
                this.pointsLeftToAdd = 0;
            }
            else {
                this.abilityBar.reset();
                this.setAbilityBar(this.pointsLeftToAdd, _local_2);
            }
        }
    }

    public function setAbilityLabel(_arg_1:String):void {
        this.levelTextfield.setStringBuilder(new LineBuilder().setParams(_arg_1));
    }

    public function setLevelLabel(_arg_1:int, _arg_2:Boolean = false):void {
        var _local_3:String = (((_arg_1 >= this.max)) ? TextKey.PET_ABILITY_LEVEL_MAX : TextKey.ABILITY_BAR_LEVEL_LABEL);
        this.labelTextfield.setColor(((_arg_2) ? 1572859 : (((_arg_1 >= this.max)) ? PetsConstants.COLOR_GREEN_TEXT_HIGHLIGHT : 0xB3B3B3)));
        this.labelTextfield.setStringBuilder(new LineBuilder().setParams(_local_3, {"level": _arg_1.toString()}));
        this.labelTextfield.textChanged.addOnce(this.positionLabelText);
    }

    public function setAbilityBar(_arg_1:int, _arg_2:int):void {
        this.abilityBar.setMaxPointValue(_arg_2);
        this.abilityBar.setCurrentPointValue(_arg_1);
    }

    public function setUnlocked(_arg_1:Boolean):void {
        var _local_2:int;
        var _local_3:Array;
        if (this.unlocked != _arg_1) {
            this.unlocked = _arg_1;
            _local_2 = ((_arg_1) ? 0xB3B3B3 : 0x565656);
            _local_3 = ((_arg_1) ? [new DropShadowFilter(0, 0, 0)] : []);
            this.levelTextfield.setColor(_local_2);
            this.levelTextfield.filters = _local_3;
            this.labelTextfield.visible = _arg_1;
        }
    }

    private function addChildren():void {
        addChild(this.levelTextfield);
        addChild(this.labelTextfield);
        addChild(this.abilityBar);
    }

    private function waitForTextChanged():void {
        var _local_1:SignalWaiter = new SignalWaiter();
        _local_1.push(this.labelTextfield.textChanged);
        _local_1.push(this.levelTextfield.textChanged);
        _local_1.complete.addOnce(this.positionTextField);
    }

    private function positionLabelText():void {
        this.abilityBar.y = 21;
        this.labelTextfield.x = (PetsConstants.PET_ABILITY_BAR_WIDTH - this.labelTextfield.width);
    }

    private function positionTextField():void {
        this.positionLabelText();
        this.positioned.dispatch();
    }

    private function onAnimatingBar(_arg_1:Boolean):void {
        this.labelTextfield.setColor(((_arg_1) ? 1572859 : (((this.levelShown >= this.max)) ? PetsConstants.COLOR_GREEN_TEXT_HIGHLIGHT : 0xB3B3B3)));
        this.levelTextfield.setColor(((_arg_1) ? 1572859 : (((this.levelShown >= 100)) ? PetsConstants.COLOR_GREEN_TEXT_HIGHLIGHT : 0xB3B3B3)));
        if (((!(_arg_1)) && ((this.levelShown >= 100)))) {
            this.abilityBar.setBarColor(PetsConstants.COLOR_GREEN_TEXT_HIGHLIGHT);
        }
        this.animating.dispatch(this, _arg_1);
    }

    public function setShowToolTipSignal(_arg_1:ShowTooltipSignal):void {
        this.tooltipDelegate.setShowToolTipSignal(_arg_1);
    }

    public function getShowToolTip():ShowTooltipSignal {
        return (this.tooltipDelegate.getShowToolTip());
    }

    public function setHideToolTipsSignal(_arg_1:HideTooltipsSignal):void {
        this.tooltipDelegate.setHideToolTipsSignal(_arg_1);
    }

    public function getHideToolTips():HideTooltipsSignal {
        return (this.tooltipDelegate.getHideToolTips());
    }


}
}//package kabam.rotmg.pets.view.components
