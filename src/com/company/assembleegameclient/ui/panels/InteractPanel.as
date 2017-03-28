package com.company.assembleegameclient.ui.panels {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.IInteractiveObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;

import flash.display.Sprite;
import flash.events.Event;

public class InteractPanel extends Sprite {

    public static const MAX_DIST:Number = 1;

    public var gs_:GameSprite;
    public var player_:Player;
    public var w_:int;
    public var h_:int;
    public var currentPanel:Panel = null;
    public var currObj_:IInteractiveObject = null;
    public var partyPanel_:PartyPanel;
    private var overridePanel_:Panel;
    public var requestInteractive:Function;

    public function InteractPanel(_arg_1:GameSprite, _arg_2:Player, _arg_3:int, _arg_4:int) {
        this.gs_ = _arg_1;
        this.player_ = _arg_2;
        this.w_ = _arg_3;
        this.h_ = _arg_4;
        this.partyPanel_ = new PartyPanel(_arg_1);
    }

    public function setOverride(_arg_1:Panel):void {
        if (this.overridePanel_ != null) {
            this.overridePanel_.removeEventListener(Event.COMPLETE, this.onComplete);
        }
        this.overridePanel_ = _arg_1;
        this.overridePanel_.addEventListener(Event.COMPLETE, this.onComplete);
    }

    public function redraw():void {
		if (currentPanel != null) {
			this.currentPanel.draw();
		}
    }

    public function draw():void {
        var _local_1:IInteractiveObject;
        var _local_2:Panel;
        if (this.overridePanel_ != null) {
            this.setPanel(this.overridePanel_);
            this.currentPanel.draw();
            return;
        }
        _local_1 = this.requestInteractive();
        if ((((this.currentPanel == null)) || (!((_local_1 == this.currObj_))))) {
            this.currObj_ = _local_1;
            this.partyPanel_ = new PartyPanel(this.gs_);
            if (this.currObj_ != null) {
                _local_2 = this.currObj_.getPanel(this.gs_);
            }
            else {
                _local_2 = this.partyPanel_;
            }
            this.setPanel(_local_2);
        }
        if (this.currentPanel) {
            this.currentPanel.draw();
        }
    }

    private function onComplete(_arg_1:Event):void {
        if (this.overridePanel_ != null) {
            this.overridePanel_.removeEventListener(Event.COMPLETE, this.onComplete);
            this.overridePanel_ = null;
        }
        this.setPanel(null);
        this.draw();
    }

    public function setPanel(_arg_1:Panel):void {
        if (_arg_1 != this.currentPanel) {
            ((this.currentPanel) && (removeChild(this.currentPanel)));
            this.currentPanel = _arg_1;
            ((this.currentPanel) && (this.positionPanelAndAdd()));
        }
    }

    private function positionPanelAndAdd():void {
        if ((this.currentPanel is ItemGrid)) {
            this.currentPanel.x = 14; //((this.w_ - this.currentPanel.width) * 0.5);
            this.currentPanel.y = 8;
        }
        else {
            this.currentPanel.x = 6;
            this.currentPanel.y = 8;
        }
        addChild(this.currentPanel);
    }


}
}//package com.company.assembleegameclient.ui.panels
