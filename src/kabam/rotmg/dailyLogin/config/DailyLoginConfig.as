package kabam.rotmg.dailyLogin.config
{
	import robotlegs.bender.framework.api.IConfig;
	import org.swiftsuspenders.Injector;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
	import kabam.rotmg.dailyLogin.view.DailyLoginPanel;
	import kabam.rotmg.dailyLogin.controller.DailyLoginPanelMediator;
	import kabam.rotmg.dailyLogin.view.DailyLoginModal;
	import kabam.rotmg.dailyLogin.controller.DailyLoginModalMediator;
	import kabam.rotmg.dailyLogin.view.CalendarView;
	import kabam.rotmg.dailyLogin.controller.CalendarViewMediator;
	import kabam.rotmg.dailyLogin.view.CalendarDayBox;
	import kabam.rotmg.dailyLogin.controller.CalendarDayBoxMediator;
	import kabam.rotmg.dailyLogin.view.CalendarTabsView;
	import kabam.rotmg.dailyLogin.controller.CalendarTabsViewMediator;
	import kabam.rotmg.dailyLogin.tasks.FetchPlayerCalendarTask;
	import kabam.rotmg.dailyLogin.model.DailyLoginModel;
	import kabam.rotmg.dailyLogin.signal.ClaimDailyRewardResponseSignal;
	import kabam.rotmg.dailyLogin.signal.ShowDailyCalendarPopupSignal;
	import kabam.rotmg.dailyLogin.commands.ShowDailyCalendarPopupCommand;
	
	public class DailyLoginConfig implements IConfig
	{
		 
		
		[Inject]
		public var injector:Injector;
		
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		[Inject]
		public var commandMap:ISignalCommandMap;
		
		public function DailyLoginConfig()
		{
			super();
		}
		
		public function configure() : void
		{
			this.mediatorMap.map(DailyLoginPanel).toMediator(DailyLoginPanelMediator);
			this.mediatorMap.map(DailyLoginModal).toMediator(DailyLoginModalMediator);
			this.mediatorMap.map(CalendarView).toMediator(CalendarViewMediator);
			this.mediatorMap.map(CalendarDayBox).toMediator(CalendarDayBoxMediator);
			this.mediatorMap.map(CalendarTabsView).toMediator(CalendarTabsViewMediator);
			this.injector.map(FetchPlayerCalendarTask);
			this.injector.map(DailyLoginModel).asSingleton();
			this.injector.map(ClaimDailyRewardResponseSignal).asSingleton();
			this.commandMap.map(ShowDailyCalendarPopupSignal).toCommand(ShowDailyCalendarPopupCommand);
		}
	}
}
