package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.ui.tooltip.TextToolTip;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.utils.getTimer;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;

public class ScoreTextLine extends Sprite implements TooltipAble {

    public static var textTooltip_:TextToolTip = new TextToolTip(0x363636, 0x9B9B9B, null, "", 150);

    public var hoverTooltipDelegate:HoverTooltipDelegate;
    public var description:String;
    public var level:int;
    public var number_:int;
    public var numberPrefix_:String;
    public var unit_:String;
    private var startTime_:int = 0;
    private var nameText_:TextFieldDisplayConcrete;
    private var numberText_:TextFieldDisplayConcrete;
    private var unitIcon_:DisplayObject;

    public function ScoreTextLine(_arg_1:int, _arg_2:uint, _arg_3:uint, _arg_4:String, _arg_5:String, _arg_6:int, _arg_7:int, _arg_8:String, _arg_9:String, _arg_10:DisplayObject):void {
        this.hoverTooltipDelegate = new HoverTooltipDelegate();
        super();
        this.name = _arg_4;
        this.description = _arg_5;
        this.level = _arg_6;
        this.number_ = _arg_7;
        this.numberPrefix_ = _arg_8;
        this.unit_ = _arg_9;
        this.nameText_ = new TextFieldDisplayConcrete().setSize(_arg_1).setColor(_arg_2);
        this.nameText_.setBold(true);
        this.nameText_.setAutoSize(TextFieldAutoSize.RIGHT);
        this.nameText_.setStringBuilder(new LineBuilder().setParams(_arg_4));
        this.nameText_.x = 410;
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
        addChild(this.nameText_);
        if (this.number_ != -1) {
            this.numberText_ = new TextFieldDisplayConcrete().setSize(_arg_1).setColor(_arg_3);
            this.numberText_.setBold(true);
            this.numberText_.setStringBuilder(new StaticStringBuilder((((_arg_8 + "0") + " ") + _arg_9)));
            this.numberText_.x = 450;
            this.numberText_.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
            addChild(this.numberText_);
        }
        if (_arg_10 != null) {
            this.unitIcon_ = _arg_10;
            this.nameText_.textChanged.addOnce(this.onTextChanged);
            addChild(this.unitIcon_);
        }
        this.hoverTooltipDelegate.setDisplayObject(this);
        if (_arg_5) {
            this.hoverTooltipDelegate.tooltip = textTooltip_;
        }
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onTextChanged():void {
        if (this.numberText_ != null) {
            this.unitIcon_.x = ((this.numberText_.x + this.numberText_.width) - 4);
            this.unitIcon_.y = (((this.numberText_.height / 2) - (this.unitIcon_.height / 2)) + 2);
        }
        else {
            this.unitIcon_.x = 450;
            this.unitIcon_.y = (((this.nameText_.height / 2) - (this.unitIcon_.height / 2)) + 2);
        }
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

    public function skip():void {
        this.startTime_ = -1000000;
    }

    private function onAddedToStage(_arg_1:Event):void {
        if (this.startTime_ == 0) {
            this.startTime_ = getTimer();
        }
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
    }

    public function onEnterFrame(_arg_1:Event):void {
        var _local_3:int;
        var _local_2:Number = Math.min(1, ((getTimer() - this.startTime_) / 500));
        if (this.numberText_ != null) {
            _local_3 = (this.number_ * _local_2);
            this.numberText_.setStringBuilder(new StaticStringBuilder((((this.numberPrefix_ + _local_3.toString()) + " ") + this.unit_)));
            if (this.unitIcon_ != null) {
                this.unitIcon_.x = ((this.numberText_.x + this.numberText_.width) - 4);
                this.unitIcon_.y = (((this.numberText_.height / 2) - (this.unitIcon_.height / 2)) + 2);
            }
        }
        if (_local_2 == 1) {
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }
    }

    public function onMouseOver(_arg_1:Event):void {
        if (this.description != null) {
            textTooltip_.setText(this.makeDescription());
            stage.addChild(textTooltip_);
        }
    }

    private function makeDescription():StringBuilder {
        var _local_1:AppendingLineBuilder = new AppendingLineBuilder();
        _local_1.setDelimiter("");
        _local_1.pushParams(this.description);
        if (this.level > 1) {
            _local_1.pushParams(TextKey.BLANK, {"data": " ("});
            _local_1.pushParams("FameBonus.LevelRequirement", {"level": this.level});
            _local_1.pushParams(TextKey.BLANK, {"data": ")"});
        }
        return (_local_1);
    }


}
}//package com.company.assembleegameclient.screens
