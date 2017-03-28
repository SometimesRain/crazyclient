package com.company.assembleegameclient.ui.language {
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.core.view.Layers;
import kabam.rotmg.language.control.SetLanguageSignal;
import kabam.rotmg.language.model.LanguageModel;
import kabam.rotmg.ui.view.TitleView;

import robotlegs.bender.bundles.mvcs.Mediator;

public class LanguageOptionOverlayMediator extends Mediator {

    [Inject]
    public var layers:Layers;
    [Inject]
    public var languageModel:LanguageModel;
    [Inject]
    public var setLanguage:SetLanguageSignal;
    [Inject]
    public var view:LanguageOptionOverlay;
    [Inject]
    public var setScreen:SetScreenSignal;


    override public function initialize():void {
        this.view.setLanguageDropdown(this.languageModel.getLanguageNames());
        this.view.setSelected(this.languageModel.getNameForLanguageCode(this.languageModel.getLanguage()));
        this.view.languageSelected.add(this.onLanguageSelected);
        this.view.back.add(this.onBack);
    }

    override public function destroy():void {
        this.view.languageSelected.remove(this.onLanguageSelected);
        this.view.back.remove(this.onBack);
    }

    private function onBack():void {
        this.setScreen.dispatch(new TitleView());
    }

    private function onLanguageSelected(_arg_1:String):void {
        this.setLanguage.dispatch(this.languageModel.getLanguageCodeForName(_arg_1));
    }


}
}//package com.company.assembleegameclient.ui.language
