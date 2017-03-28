package kabam.rotmg.text {
import com.company.ui.BaseSimpleText;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.language.DebugTextAndMapProvider;
import kabam.rotmg.text.controller.TextFieldDisplayMediator;
import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.text.model.TextAndMapProvider;
import kabam.rotmg.text.view.BaseSimpleTextMediator;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.TextFieldDisplay;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.framework.api.IConfig;

public class TextConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var applicationSetup:ApplicationSetup;


    public function configure():void {
        this.injector.map(FontModel).asSingleton();
        this.mapTextFieldProvider();
        this.mediatorMap.map(TextFieldDisplay).toMediator(TextFieldDisplayMediator);
        this.mediatorMap.map(BaseSimpleText).toMediator(BaseSimpleTextMediator);
        this.injector.map(BitmapTextFactory);
    }

    private function mapTextFieldProvider():void {
        this.injector.map(TextAndMapProvider).toType(DebugTextAndMapProvider);
    }


}
}//package kabam.rotmg.text
