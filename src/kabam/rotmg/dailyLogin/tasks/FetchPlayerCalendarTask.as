package kabam.rotmg.dailyLogin.tasks
{
	import kabam.lib.tasks.BaseTask;
	import kabam.rotmg.account.core.Account;
	import kabam.rotmg.messaging.impl.GameServerConnectionConcrete;
	import robotlegs.bender.framework.api.ILogger;
	import kabam.rotmg.appengine.api.AppEngineClient;
	import kabam.rotmg.core.signals.SetLoadingMessageSignal;
	import kabam.rotmg.dailyLogin.model.DailyLoginModel;
	import kabam.rotmg.build.api.BuildData;
	import com.company.assembleegameclient.parameters.Parameters;
	import kabam.rotmg.build.api.BuildEnvironment;
	import kabam.rotmg.dailyLogin.model.CalendarTypes;
	import kabam.rotmg.dailyLogin.model.CalendarDayModel;
	import com.company.util.MoreObjectUtil;
	
	public class FetchPlayerCalendarTask extends BaseTask
	{
		 
		
		[Inject]
		public var account:Account;
		
		[Inject]
		public var logger:ILogger;
		
		[Inject]
		public var client:AppEngineClient;
		
		[Inject]
		public var setLoadingMessage:SetLoadingMessageSignal;
		
		[Inject]
		public var dailyLoginModel:DailyLoginModel;
		
		[Inject]
		public var buildData:BuildData;
		
		private var requestData:Object;
		
		public function FetchPlayerCalendarTask()
		{
			super();
		}
		
		override protected function startTask() : void
		{
			this.logger.info("FetchPlayerCalendarTask start");
			this.requestData = this.makeRequestData();
			this.sendRequest();
		}
		
		private function sendRequest() : void
		{
			this.client.complete.addOnce(this.onComplete);
			this.client.sendRequest("/dailyLogin/fetchCalendar",this.requestData);
		}
		
		private function onComplete(param1:Boolean, param2:*) : void
		{
			if(param1)
			{
				this.onCalendarUpdate(param2);
			}
			else
			{
				this.onTextError(param2);
			}
		}
		
		private function onCalendarUpdate(param1:String) : void
		{
			var xmlData:XML = null;
			var data:String = param1;
			try
			{
				xmlData = new XML(data);
			}
			catch(e:Error)
			{
				completeTask(true);
				return;
			}
			this.dailyLoginModel.clear();
			var serverTimestamp:Number = parseFloat(xmlData.attribute("serverTime")) * 1000;
			this.dailyLoginModel.setServerTime(serverTimestamp);
			if(!Parameters.data_.calendarShowOnDay || Parameters.data_.calendarShowOnDay < this.dailyLoginModel.getTimestampDay())
			{
				this.dailyLoginModel.shouldDisplayCalendarAtStartup = true;
			}
			if(xmlData.hasOwnProperty("NonConsecutive") && xmlData.NonConsecutive..Login.length() > 0)
			{
				this.parseCalendar(xmlData.NonConsecutive,CalendarTypes.NON_CONSECUTIVE,xmlData.attribute("nonconCurDay"));
			}
			if(xmlData.hasOwnProperty("Consecutive") && xmlData.Consecutive..Login.length() > 0)
			{
				this.parseCalendar(xmlData.Consecutive,CalendarTypes.CONSECUTIVE,xmlData.attribute("conCurDay"));
			}
			completeTask(true);
		}
		
		private function parseCalendar(param1:XMLList, param2:String, param3:String) : void
		{
			var _loc4_:XML = null;
			var _loc5_:CalendarDayModel = null;
			for each(_loc4_ in param1..Login)
			{
				_loc5_ = this.getDayFromXML(_loc4_, param2);
				if (_loc4_.hasOwnProperty("key")) { //3 or more stars for autocalendar
					_loc5_.claimKey = _loc4_.key;
					var numStars_:int = 0;
					account.reportIntStat("NumStars", numStars_);
					if (numStars_ > 2) {
						GameServerConnectionConcrete.claimkey = _loc4_.key;
					}
				}
				this.dailyLoginModel.addDay(_loc5_,param2);
			}
			if (param3)
			{
				this.dailyLoginModel.setCurrentDay(param2,int(param3));
			}
			this.dailyLoginModel.setUserDay(param1.attribute("days"),param2);
			this.dailyLoginModel.calculateCalendar(param2);
		}
		
		private function getDayFromXML(param1:XML, param2:String) : CalendarDayModel
		{
			return new CalendarDayModel(param1.Days,param1.ItemId,param1.Gold,param1.ItemId.attribute("quantity"),param1.hasOwnProperty("Claimed"),param2);
		}
		
		private function onTextError(param1:String) : void
		{
			completeTask(true);
		}
		
		public function makeRequestData() : Object
		{
			var _loc1_:Object = {};
			_loc1_.game_net_user_id = this.account.gameNetworkUserId();
			_loc1_.game_net = this.account.gameNetwork();
			_loc1_.play_platform = this.account.playPlatform();
			_loc1_.do_login = Parameters.sendLogin_;
			MoreObjectUtil.addToObject(_loc1_,this.account.getCredentials());
			return _loc1_;
		}
	}
}
