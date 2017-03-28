package com.company.assembleegameclient.ui.language {
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.rotmg.graphics.ScreenGraphic;

import flash.display.Shape;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.components.ScreenBase;
import kabam.rotmg.ui.view.components.dropdown.LocalizedDropDown;

import org.osflash.signals.Signal;

public class LanguageOptionOverlay extends ScreenBase {

    public var languageSelected:Signal;
    public var back:Signal;
    private var title_:TextFieldDisplayConcrete;
    private var continueButton_:TitleMenuOption;
    private var languageDropDownLabel:TextFieldDisplayConcrete;
    private var languageDropDown:LocalizedDropDown;

    public function LanguageOptionOverlay() {
        this.languageSelected = new Signal(String);
        this.back = new Signal();
        this.title_ = this.makeTitle();
        this.continueButton_ = this.makeContinueButton();
        this.languageDropDownLabel = this.makeDropDownLabel();
        super();
        addChild(this.makeLine());
        addChild(this.title_);
        addChild(new ScreenGraphic());
        addChild(this.continueButton_);
    }

    private function onContinueClick(_arg_1:MouseEvent):void {
        this.back.dispatch();
    }

    public function setLanguageDropdown(_arg_1:Vector.<String>):void {
        this.languageDropDown = new LocalizedDropDown(_arg_1);
        this.languageDropDown.y = 100;
        this.languageDropDown.addEventListener(Event.CHANGE, this.onLanguageSelected);
        addChild(this.languageDropDown);
        this.languageDropDownLabel.textChanged.addOnce(this.positionDropdownLabel);
        addChild(this.languageDropDownLabel);
        this.languageDropDownLabel.y = (this.languageDropDown.y + (this.languageDropDown.getClosedHeight() / 2));
    }

    private function positionDropdownLabel():void {
        this.languageDropDown.x = ((800 / 2) - (((this.languageDropDown.width + this.languageDropDownLabel.width) + 10) / 2));
        this.languageDropDownLabel.x = ((this.languageDropDown.x + this.languageDropDown.width) + 10);
    }

    public function setSelected(_arg_1:String):void {
        ((this.languageDropDown) && (this.languageDropDown.setValue(_arg_1)));
    }

    private function onLanguageSelected(_arg_1:Event):void {
        this.languageSelected.dispatch(this.languageDropDown.getValue());
    }

    private function makeTitle():TextFieldDisplayConcrete {
        var _local_1:TextFieldDisplayConcrete;
        _local_1 = new TextFieldDisplayConcrete().setSize(36).setColor(0xFFFFFF);
        _local_1.setBold(true);
        _local_1.setStringBuilder(new LineBuilder().setParams(TextKey.LANGUAGES_SCREEN_TITLE));
        _local_1.setAutoSize(TextFieldAutoSize.CENTER);
        _local_1.filters = [new DropShadowFilter(0, 0, 0)];
        _local_1.x = ((800 / 2) - (_local_1.width / 2));
        _local_1.y = 16;
        return (_local_1);
    }

    private function makeContinueButton():TitleMenuOption {
        var _local_1:TitleMenuOption;
        _local_1 = new TitleMenuOption(TextKey.OPTIONS_CONTINUE_BUTTON, 36, false);
        _local_1.setAutoSize(TextFieldAutoSize.CENTER);
        _local_1.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        _local_1.addEventListener(MouseEvent.CLICK, this.onContinueClick);
        _local_1.x = 400;
        _local_1.y = 550;
        return (_local_1);
    }

    private function makeDropDownLabel():TextFieldDisplayConcrete {
        var _local_1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(0xB3B3B3).setBold(true);
        _local_1.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        _local_1.setStringBuilder(new LineBuilder().setParams(TextKey.CHOOSE_LANGUAGE));
        return (_local_1);
    }

    private function makeLine():Shape {
        var _local_1:Shape = new Shape();
        _local_1.graphics.lineStyle(1, 0x5E5E5E);
        _local_1.graphics.moveTo(0, 70);
        _local_1.graphics.lineTo(800, 70);
        _local_1.graphics.lineStyle();
        return (_local_1);
    }

    public function clear():void {
        if (((this.languageDropDown) && (contains(this.languageDropDown)))) {
            removeChild(this.languageDropDown);
        }
    }


}
}//package com.company.assembleegameclient.ui.language
