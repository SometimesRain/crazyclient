package kabam.rotmg.questrewards {
import kabam.rotmg.questrewards.controller.QuestFetchCompleteSignal;
import kabam.rotmg.questrewards.controller.QuestRedeemCompleteSignal;
import kabam.rotmg.questrewards.view.QuestRewardsContainer;
import kabam.rotmg.questrewards.view.QuestRewardsMediator;
import kabam.rotmg.questrewards.view.QuestRewardsPanel;
import kabam.rotmg.questrewards.view.QuestRewardsPanelMediator;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class QuestRewardsConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;
    [Inject]
    public var commandCenter:ICommandCenter;


    public function configure():void {
        this.mediatorMap.map(QuestRewardsPanel).toMediator(QuestRewardsPanelMediator);
        this.mediatorMap.map(QuestRewardsContainer).toMediator(QuestRewardsMediator);
        this.injector.map(QuestFetchCompleteSignal).asSingleton();
        this.injector.map(QuestRedeemCompleteSignal).asSingleton();
    }


}
}//package kabam.rotmg.questrewards
