package kabam.rotmg.pets.view.components {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.ColorTransform;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.view.dialogs.Disableable;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;

public class PetIcon extends Sprite implements TooltipAble, Disableable {

    public static const DISABLE_COLOR:uint = 0x292929;

    public var hoverTooltipDelegate:HoverTooltipDelegate;
    private var bitmap:Bitmap;
    private var enabled:Boolean = true;
    private var petVO:PetVO;
    private var doShowTooltip:Boolean = false;

    public function PetIcon(_arg_1:PetVO) {
        this.hoverTooltipDelegate = new HoverTooltipDelegate();
        super();
        this.petVO = _arg_1;
        this.hoverTooltipDelegate.setDisplayObject(this);
        this.hoverTooltipDelegate.tooltip = new PetTooltip(_arg_1);
    }

    public function disable():void {
        var _local_1:ColorTransform = new ColorTransform();
        _local_1.color = DISABLE_COLOR;
        this.bitmap.transform.colorTransform = _local_1;
        this.enabled = false;
    }

    public function isEnabled():Boolean {
        return (this.enabled);
    }

    override public function dispatchEvent(_arg_1:Event):Boolean {
        if (this.enabled) {
            return (super.dispatchEvent(_arg_1));
        }
        return (false);
    }

    public function setBitmap(_arg_1:Bitmap):void {
        this.bitmap = _arg_1;
        addChild(_arg_1);
    }

    public function setShowToolTipSignal(_arg_1:ShowTooltipSignal):void {
        this.hoverTooltipDelegate.setShowToolTipSignal(_arg_1);
    }

    public function getShowToolTip():ShowTooltipSignal {
        return (this.hoverTooltipDelegate.getShowToolTip());
    }

    public function setHideToolTipsSignal(_arg_1:HideTooltipsSignal):void {
        this.hoverTooltipDelegate.setHideToolTipsSignal(_arg_1);
    }

    public function getHideToolTips():HideTooltipsSignal {
        return (this.hoverTooltipDelegate.getHideToolTips());
    }

    public function getPetVO():PetVO {
        return (this.petVO);
    }

    public function setTooltipEnabled(_arg_1:Boolean):void {
        this.doShowTooltip = _arg_1;
        if (!_arg_1) {
        }
    }


}
}//package kabam.rotmg.pets.view.components
