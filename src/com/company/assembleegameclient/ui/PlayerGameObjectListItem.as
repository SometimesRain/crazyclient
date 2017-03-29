package com.company.assembleegameclient.ui {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.tooltip.PlayerToolTip;
import com.company.util.MoreColorUtil;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;

public class PlayerGameObjectListItem extends GameObjectListItem implements TooltipAble {

    public const hoverTooltipDelegate:HoverTooltipDelegate = new HoverTooltipDelegate();

    private var enabled:Boolean = true;
    private var starred:Boolean = false;
    private var hover:Boolean = true;

    public function PlayerGameObjectListItem(_arg_1:uint, _arg_2:Boolean, _arg_3:GameObject, hover_:Boolean = true, amount:int = 0) {
        super(_arg_1, _arg_2, _arg_3, false, amount);
        var _local_4:Player = (_arg_3 as Player);
        if (_local_4) {
            this.starred = _local_4.starred_;
        }
		hover = hover_;
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onAddedToStage(_arg_1:Event):void {
		if (hover) {
			addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
			this.hoverTooltipDelegate.setDisplayObject(this);
		}
		addEventListener(MouseEvent.RIGHT_CLICK, this.onRClick);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
		if (hover) {
			removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
		}
        removeEventListener(MouseEvent.RIGHT_CLICK, this.onRClick);
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onRClick(_arg_1:MouseEvent):void {
		go.map_.gs_.gsc_.teleport(go.objectId_);
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        this.hoverTooltipDelegate.tooltip = ((this.enabled) ? new PlayerToolTip(Player(go)) : null);
    }

    public function setEnabled(_arg_1:Boolean):void {
        if (this.enabled != _arg_1 && Player(go) != null) {
            this.enabled = _arg_1;
            this.hoverTooltipDelegate.tooltip = ((this.enabled) ? new PlayerToolTip(Player(go)) : null);
            if (!this.enabled) {
                this.hoverTooltipDelegate.getShowToolTip().dispatch(this.hoverTooltipDelegate.tooltip);
            }
        }
    }

    override public function draw(_arg_1:GameObject, _arg_2:ColorTransform = null):void {
        var _local_3:Player = (_arg_1 as Player);
        if (_local_3 && starred != _local_3.starred_) {
            transform.colorTransform = (_arg_2 || MoreColorUtil.identity);
            this.starred = _local_3.starred_;
        }
        super.draw(_arg_1, _arg_2);
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
}//package com.company.assembleegameclient.ui
