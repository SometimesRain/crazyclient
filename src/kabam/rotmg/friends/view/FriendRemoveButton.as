package kabam.rotmg.friends.view {
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.rotmg.graphics.DeleteXGraphic;
import com.company.util.MoreColorUtil;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;

public class FriendRemoveButton extends Sprite implements TooltipAble {

    protected static const mouseOverCT:ColorTransform = new ColorTransform(1, (220 / 0xFF), (133 / 0xFF));

    public var hoverTooltipDelegate:HoverTooltipDelegate;
    private var toolTip_:TextToolTip = null;

    public function FriendRemoveButton(_arg_1:String = "", _arg_2:String = "", _arg_3:Object = null) {
        this.hoverTooltipDelegate = new HoverTooltipDelegate();
        super();
        addChild(new DeleteXGraphic());
        if (_arg_1 != "") {
            this.setToolTipTitle(_arg_1, _arg_2, _arg_3);
        }
    }

    public function destroy():void {
        while (numChildren > 0) {
            this.removeChildAt((numChildren - 1));
        }
        this.toolTip_ = null;
        this.hoverTooltipDelegate.removeDisplayObject();
        this.hoverTooltipDelegate = null;
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
    }

    private function setToolTipTitle(_arg_1:String, _arg_2:String, _arg_3:Object):void {
        this.toolTip_ = new TextToolTip(0x363636, 0x9B9B9B, _arg_1, _arg_2, 200, _arg_3);
        this.hoverTooltipDelegate.setDisplayObject(this);
        this.hoverTooltipDelegate.tooltip = this.toolTip_;
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
    }

    protected function onMouseOver(_arg_1:MouseEvent):void {
        transform.colorTransform = mouseOverCT;
    }

    protected function onMouseOut(_arg_1:MouseEvent):void {
        transform.colorTransform = MoreColorUtil.identity;
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


}
}//package kabam.rotmg.friends.view
