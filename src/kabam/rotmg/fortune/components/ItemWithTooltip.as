package kabam.rotmg.fortune.components {
import com.company.assembleegameclient.constants.InventoryOwnerTypes;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;

import org.osflash.signals.Signal;

public class ItemWithTooltip extends Sprite implements TooltipAble {

    private var itemId:int;
    public var hoverTooltipDelegate:HoverTooltipDelegate;
    private var tooltip:ToolTip;
    public var onMouseOver:Signal;
    public var onMouseOut:Signal;
    public var itemBitmap:Bitmap;

    public function ItemWithTooltip(_arg_1:int, _arg_2:int = 100, _arg_3:Boolean = false) {
        this.hoverTooltipDelegate = new HoverTooltipDelegate();
        this.onMouseOver = new Signal();
        this.onMouseOut = new Signal();
        super();
        this.itemId = _arg_1;
        var _local_4:BitmapData = ObjectLibrary.getRedrawnTextureFromType(_arg_1, _arg_2, true, false);
        var _local_5:BitmapData = ObjectLibrary.getRedrawnTextureFromType(_arg_1, _arg_2, true, false);
        this.itemBitmap = new Bitmap(_local_5);
        addChild(this.itemBitmap);
        this.hoverTooltipDelegate.setDisplayObject(this);
        this.tooltip = new EquipmentToolTip(_arg_1, null, -1, InventoryOwnerTypes.NPC);
        this.tooltip.forcePostionLeft();
        this.hoverTooltipDelegate.tooltip = this.tooltip;
        if (_arg_3) {
            addEventListener(Event.REMOVED_FROM_STAGE, this.onDestruct);
            addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
        }
    }

    public function disableTooltip():void {
        this.hoverTooltipDelegate.removeDisplayObject();
    }

    public function enableTooltip():void {
        this.hoverTooltipDelegate.setDisplayObject(this);
    }

    private function onDestruct(_arg_1:Event):void {
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onDestruct);
        removeEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
        removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
        this.onMouseOver.removeAll();
        this.onMouseOut.removeAll();
    }

    private function onRollOver(_arg_1:MouseEvent):void {
        this.onMouseOver.dispatch();
    }

    private function onRollOut(_arg_1:MouseEvent):void {
        this.onMouseOut.dispatch();
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

    public function setXPos(_arg_1:Number):void {
        this.x = (_arg_1 - (this.width / 2));
    }

    public function setYPos(_arg_1:Number):void {
        this.y = (_arg_1 - (this.height / 2));
    }

    public function getCenterX():Number {
        return ((this.x + (this.width / 2)));
    }

    public function getCenterY():Number {
        return ((this.y + (this.height / 2)));
    }


}
}//package kabam.rotmg.fortune.components
