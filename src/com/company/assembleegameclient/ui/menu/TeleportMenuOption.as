package com.company.assembleegameclient.ui.menu {
import com.company.assembleegameclient.objects.Player;
import com.company.util.AssetLibrary;

import flash.display.Shape;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class TeleportMenuOption extends MenuOption {

    private static const inactiveCT:ColorTransform = new ColorTransform((84 / 0xFF), (84 / 0xFF), (84 / 0xFF));

    private var player_:Player;
    private var mouseOver_:Boolean = false;
    private var barText_:TextFieldDisplayConcrete;
    private var barTextOrigWidth_:int;
    private var barMask:Shape;

    public function TeleportMenuOption(_arg_1:Player) {
        this.barMask = new Shape();
        super(AssetLibrary.getImageFromSet("lofiInterface2", 3), 0xFFFFFF, TextKey.TELEPORTMENUOPTION_TITLE);
        this.player_ = _arg_1;
        this.barText_ = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF);
        this.barText_.setBold(true);
        this.barText_.setStringBuilder(new LineBuilder().setParams(TextKey.TELEPORTMENUOPTION_TITLE));
        this.barText_.x = (this.barMask.x = text_.x);
        this.barText_.y = (this.barMask.y = text_.y);
        this.barText_.textChanged.add(this.onTextChanged);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onTextChanged():void {
        this.barTextOrigWidth_ = this.barText_.textField.width;
        this.barMask.graphics.beginFill(0xFF00FF);
        this.barMask.graphics.drawRect(0, 0, this.barText_.textField.width, this.barText_.textField.height);
    }

    private function onAddedToStage(_arg_1:Event):void {
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onEnterFrame(_arg_1:Event):void {
        var _local_3:Number;
        var _local_2:int = this.player_.msUtilTeleport();
        if (_local_2 > 0) {
            if (!contains(this.barText_)) {
                addChild(this.barText_);
                addChild(this.barMask);
                this.barText_.mask = this.barMask;
            }
            _local_3 = (this.barTextOrigWidth_ * (1 - (_local_2 / Player.MS_BETWEEN_TELEPORT)));
            this.barMask.width = _local_3;
            setColorTransform(inactiveCT);
        }
        else {
            if (contains(this.barText_)) {
                removeChild(this.barText_);
            }
            if (this.mouseOver_) {
                setColorTransform(mouseOverCT);
            }
            else {
                setColorTransform(null);
            }
        }
    }

    override protected function onMouseOver(_arg_1:MouseEvent):void {
        this.mouseOver_ = true;
    }

    override protected function onMouseOut(_arg_1:MouseEvent):void {
        this.mouseOver_ = false;
    }


}
}//package com.company.assembleegameclient.ui.menu
