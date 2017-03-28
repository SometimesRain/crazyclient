package kabam.rotmg.dailyLogin.controller
{
	import robotlegs.bender.bundles.mvcs.Mediator;
	import kabam.rotmg.dailyLogin.view.CalendarTabsView;
	import kabam.rotmg.dailyLogin.model.DailyLoginModel;
	import kabam.rotmg.dailyLogin.view.CalendarTabButton;
	import kabam.rotmg.dailyLogin.config.CalendarSettings;
	import kabam.rotmg.dailyLogin.model.CalendarTypes;
	import flash.events.MouseEvent;
	
	public class CalendarTabsViewMediator extends Mediator
	{
		 
		
		[Inject]
		public var view:CalendarTabsView;
		
		[Inject]
		public var model:DailyLoginModel;
		
		private var tabs:Vector.<CalendarTabButton>;
		
		public function CalendarTabsViewMediator()
		{
			super();
		}
		
		override public function initialize() : void
		{
			var _loc2_:CalendarTabButton = null;
			this.tabs = new Vector.<CalendarTabButton>();
			this.view.init(CalendarSettings.getTabsRectangle(this.model.overallMaxDays));
			var _loc1_:String = "";
			if(this.model.hasCalendar(CalendarTypes.NON_CONSECUTIVE))
			{
				_loc1_ = CalendarTypes.NON_CONSECUTIVE;
				this.tabs.push(this.view.addCalendar("Login Calendar",CalendarTypes.NON_CONSECUTIVE,"Unlock rewards the more days you login. Logins do not need to be in consecutive days. You must claim all rewards before the end of the event."));
			}
			if(this.model.hasCalendar(CalendarTypes.CONSECUTIVE))
			{
				if(_loc1_ == "")
				{
					_loc1_ = CalendarTypes.CONSECUTIVE;
				}
				this.tabs.push(this.view.addCalendar("Login Streak",CalendarTypes.CONSECUTIVE,"Login on consecutive days to keep your streak alive. The more consecutive days you login, the more rewards you can unlock. If you miss a day, you start over. All rewards must be claimed by the end of the event."));
			}
			for each(_loc2_ in this.tabs)
			{
				_loc2_.addEventListener(MouseEvent.CLICK,this.onTabChange);
			}
			this.view.drawTabs();
			if(_loc1_ != "")
			{
				this.model.currentDisplayedCaledar = _loc1_;
				this.view.selectTab(_loc1_);
			}
		}
		
		private function onTabChange(param1:MouseEvent) : void
		{
			param1.stopImmediatePropagation();
			param1.stopPropagation();
			var _loc2_:CalendarTabButton = param1.currentTarget as CalendarTabButton;
			if(_loc2_ != null)
			{
				this.model.currentDisplayedCaledar = _loc2_.calendarType;
				this.view.selectTab(_loc2_.calendarType);
			}
		}
		
		override public function destroy() : void
		{
			var _loc1_:CalendarTabButton = null;
			for each(_loc1_ in this.tabs)
			{
				_loc1_.removeEventListener(MouseEvent.CLICK,this.onTabChange);
			}
			this.tabs = new Vector.<CalendarTabButton>();
			super.destroy();
		}
	}
}
