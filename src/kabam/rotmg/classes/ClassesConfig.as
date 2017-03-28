package kabam.rotmg.classes {
import kabam.rotmg.account.core.control.IsAccountRegisteredToBuyGoldGuard;
import kabam.rotmg.account.core.signals.CharListDataSignal;
import kabam.rotmg.account.core.signals.LogoutSignal;
import kabam.rotmg.assets.EmbeddedData;
import kabam.rotmg.classes.control.BuyCharacterSkinCommand;
import kabam.rotmg.classes.control.BuyCharacterSkinSignal;
import kabam.rotmg.classes.control.FocusCharacterSkinSignal;
import kabam.rotmg.classes.control.ParseCharListXmlCommand;
import kabam.rotmg.classes.control.ParseClassesXMLSignal;
import kabam.rotmg.classes.control.ParseClassesXmlCommand;
import kabam.rotmg.classes.control.ParseSkinsXmlCommand;
import kabam.rotmg.classes.control.ResetClassDataCommand;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.classes.services.BuySkinTask;
import kabam.rotmg.classes.view.CharacterSkinListItem;
import kabam.rotmg.classes.view.CharacterSkinListItemFactory;
import kabam.rotmg.classes.view.CharacterSkinListItemMediator;
import kabam.rotmg.classes.view.CharacterSkinListMediator;
import kabam.rotmg.classes.view.CharacterSkinListView;
import kabam.rotmg.classes.view.CharacterSkinMediator;
import kabam.rotmg.classes.view.CharacterSkinView;
import kabam.rotmg.classes.view.ClassDetailMediator;
import kabam.rotmg.classes.view.ClassDetailView;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

public class ClassesConfig implements IConfig {

    [Inject]
    public var context:IContext;
    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;


    public function configure():void {
        this.injector.map(ClassesModel).asSingleton();
        this.injector.map(CharacterSkinListItemFactory).asSingleton();
        this.injector.map(FocusCharacterSkinSignal).asSingleton();
        this.injector.map(BuySkinTask);
        this.mediatorMap.map(CharacterSkinListItem).toMediator(CharacterSkinListItemMediator);
        this.mediatorMap.map(CharacterSkinListView).toMediator(CharacterSkinListMediator);
        this.mediatorMap.map(CharacterSkinView).toMediator(CharacterSkinMediator);
        this.mediatorMap.map(ClassDetailView).toMediator(ClassDetailMediator);
        this.commandMap.map(LogoutSignal).toCommand(ResetClassDataCommand);
        this.commandMap.map(CharListDataSignal).toCommand(ParseCharListXmlCommand);
        this.commandMap.map(ParseClassesXMLSignal).toCommand(ParseClassesXmlCommand);
        this.commandMap.map(ParseClassesXMLSignal).toCommand(ParseSkinsXmlCommand);
        this.commandMap.map(BuyCharacterSkinSignal).toCommand(BuyCharacterSkinCommand).withGuards(IsAccountRegisteredToBuyGoldGuard);
        this.context.lifecycle.afterInitializing(this.init);
    }

    private function init():void {
        var _local_1:XML = XML(new EmbeddedData.PlayersCXML());
        var _local_2:ParseClassesXMLSignal = this.injector.getInstance(ParseClassesXMLSignal);
        _local_2.dispatch(_local_1);
    }


}
}//package kabam.rotmg.classes
