package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.constants.ScreenConstants;
import com.company.rotmg.graphics.KabamLogo;
import com.company.rotmg.graphics.ScreenGraphic;
import com.company.rotmg.graphics.StackedLogoR;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.components.ScreenBase;

import org.osflash.signals.Signal;

public class CreditsScreen extends Sprite {

    private static const WILD_SHADOW_URL:String = "http://www.wildshadow.com/";
    private static const KABAM_URL:String = "http://www.kabam.com/";

    public var close:Signal;
    private var creditsText:TextFieldDisplayConcrete;
    private var wildshadowLogo:StackedLogoR;
    private var kabamLogo:KabamLogo;
    private var closeButton:TitleMenuOption;

    public function CreditsScreen() {
        this.creditsText = this.makeCreditsText();
        this.wildshadowLogo = this.makeWildshadowLogo();
        this.kabamLogo = this.makeKabamLogo();
        this.closeButton = this.makeCloseButton();
        super();
        this.close = new Signal();
        addChild(new ScreenBase());
        addChild(new ScreenGraphic());
        addChild(this.creditsText);
        addChild(this.wildshadowLogo);
        addChild(this.kabamLogo);
        addChild(this.closeButton);
    }

    private function makeCloseButton():TitleMenuOption {
        this.closeButton = new TitleMenuOption("Close.text", 36, false);
        this.closeButton.setAutoSize(TextFieldAutoSize.CENTER);
        this.closeButton.addEventListener(MouseEvent.CLICK, this.onDoneClick);
        return (this.closeButton);
    }

    private function makeKabamLogo():KabamLogo {
        this.kabamLogo = new KabamLogo();
        this.kabamLogo.scaleX = (this.kabamLogo.scaleY = 1);
        this.kabamLogo.addEventListener(MouseEvent.CLICK, this.onKabamLogoClick);
        this.kabamLogo.buttonMode = true;
        this.kabamLogo.useHandCursor = true;
        return (this.kabamLogo);
    }

    private function makeWildshadowLogo():StackedLogoR {
        this.wildshadowLogo = new StackedLogoR();
        this.wildshadowLogo.scaleX = (this.wildshadowLogo.scaleY = 1.2);
        this.wildshadowLogo.addEventListener(MouseEvent.CLICK, this.onWSLogoClick);
        this.wildshadowLogo.buttonMode = true;
        this.wildshadowLogo.useHandCursor = true;
        return (this.wildshadowLogo);
    }

    private function makeCreditsText():TextFieldDisplayConcrete {
        this.creditsText = new TextFieldDisplayConcrete();
        this.creditsText.setColor(0xB3B3B3).setSize(16).setBold(true);
        this.creditsText.setStringBuilder(new LineBuilder().setParams(TextKey.CREDITS_DEVELOPED));
        this.creditsText.filters = [new DropShadowFilter(0, 0, 0)];
        this.creditsText.setAutoSize(TextFieldAutoSize.CENTER);
        return (this.creditsText);
    }

    public function initialize():void {
        this.creditsText.x = (stage.stageWidth / 2);
        this.creditsText.y = 10;
        this.wildshadowLogo.x = ((stage.stageWidth / 2) - (this.wildshadowLogo.width / 2));
        this.wildshadowLogo.y = 50;
        this.kabamLogo.x = ((stage.stageWidth / 2) - (this.kabamLogo.width / 2));
        this.kabamLogo.y = 325;
        this.closeButton.x = ((stage.stageWidth / 2) - (this.closeButton.width / 2));
        this.closeButton.y = ScreenConstants.CENTER_BUTTON_Y_POS;
    }

    protected function onWSLogoClick(_arg_1:Event):void {
        navigateToURL(new URLRequest(WILD_SHADOW_URL), "_blank");
    }

    protected function onKabamLogoClick(_arg_1:Event):void {
        navigateToURL(new URLRequest(KABAM_URL), "_blank");
    }

    private function onDoneClick(_arg_1:Event):void {
        this.close.dispatch();
    }


}
}//package com.company.assembleegameclient.screens
