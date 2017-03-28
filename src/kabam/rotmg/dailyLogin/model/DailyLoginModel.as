package kabam.rotmg.dailyLogin.model
{
	public class DailyLoginModel
	{
		
		public static const DAY_IN_MILLISECONDS:Number = 24 * 60 * 60 * 1000;
		
		public var shouldDisplayCalendarAtStartup:Boolean;
		
		public var currentDisplayedCaledar:String;
		
		private var serverTimestamp:Number;
		
		private var serverMeasureTime:Number;
		
		private var daysConfig:Object;
		
		private var userDayConfig:Object;
		
		private var currentDayConfig:Object;
		
		private var maxDayConfig:Object;
		
		private var _initialized:Boolean;
		
		private var _currentDay:int = -1;
		
		private var sortAsc:Function;
		
		public function DailyLoginModel()
		{
			this.daysConfig = {};
			this.userDayConfig = {};
			this.currentDayConfig = {};
			this.maxDayConfig = {};
			this.sortAsc = function(param1:CalendarDayModel, param2:CalendarDayModel):Number
			{
				if(param1.dayNumber < param2.dayNumber)
				{
					return -1;
				}
				if(param1.dayNumber > param2.dayNumber)
				{
					return 1;
				}
				return 0;
			};
			super();
			this.clear();
		}
		
		public function setServerTime(param1:Number) : void
		{
			this.serverTimestamp = param1;
			this.serverMeasureTime = new Date().getTime();
		}
		
		public function hasCalendar(param1:String) : Boolean
		{
			return this.daysConfig[param1].length > 0;
		}
		
		public function getServerTime() : Date
		{
			var _loc1_:Date = new Date();
			_loc1_.setTime(this.serverTimestamp + (_loc1_.getTime() - this.serverMeasureTime));
			return _loc1_;
		}
		
		public function getTimestampDay() : int
		{
			return Math.floor(this.getServerTime().getTime() / DailyLoginModel.DAY_IN_MILLISECONDS);
		}
		
		private function getDayCount(param1:int, param2:int) : int
		{
			var _loc3_:Date = new Date(param1,param2,0);
			return _loc3_.getDate();
		}
		
		public function get daysLeftToCalendarEnd() : int
		{
			var _loc1_:Date = this.getServerTime();
			var _loc2_:int = _loc1_.getDate();
			var _loc3_:int = this.getDayCount(_loc1_.fullYear,_loc1_.month + 1);
			return _loc3_ - _loc2_;
		}
		
		public function addDay(param1:CalendarDayModel, param2:String) : void
		{
			this._initialized = true;
			this.daysConfig[param2].push(param1);
		}
		
		public function setUserDay(param1:int, param2:String) : void
		{
			this.userDayConfig[param2] = param1;
		}
		
		public function calculateCalendar(param1:String) : void
		{
			var _loc6_:CalendarDayModel = null;
			var _loc2_:Vector.<CalendarDayModel> = this.sortCalendar(this.daysConfig[param1]);
			var _loc3_:int = _loc2_.length;
			this.daysConfig[param1] = _loc2_;
			this.maxDayConfig[param1] = _loc2_[_loc3_ - 1].dayNumber;
			var _loc4_:Vector.<CalendarDayModel> = new Vector.<CalendarDayModel>();
			var _loc5_:int = 1;
			while(_loc5_ <= this.maxDayConfig[param1])
			{
				_loc6_ = this.getDayByNumber(param1,_loc5_);
				if(_loc5_ == this.userDayConfig[param1])
				{
					_loc6_.isCurrent = true;
				}
				_loc4_.push(_loc6_);
				_loc5_++;
			}
			this.daysConfig[param1] = _loc4_;
		}
		
		private function getDayByNumber(param1:String, param2:int) : CalendarDayModel
		{
			var _loc3_:CalendarDayModel = null;
			for each(_loc3_ in this.daysConfig[param1])
			{
				if(_loc3_.dayNumber == param2)
				{
					return _loc3_;
				}
			}
			return new CalendarDayModel(param2,-1,0,0,false,param1);
		}
		
		public function getDaysConfig(param1:String) : Vector.<CalendarDayModel>
		{
			return this.daysConfig[param1];
		}
		
		public function getMaxDays(param1:String) : int
		{
			return this.maxDayConfig[param1];
		}
		
		public function get overallMaxDays() : int
		{
			var _loc2_:int = 0;
			var _loc1_:int = 0;
			for each(_loc2_ in this.maxDayConfig)
			{
				if(_loc2_ > _loc1_)
				{
					_loc1_ = _loc2_;
				}
			}
			return _loc1_;
		}
		
		public function markAsClaimed(param1:int, param2:String) : void
		{
			this.daysConfig[param2][param1 - 1].isClaimed = true;
		}
		
		private function sortCalendar(param1:Vector.<CalendarDayModel>) : Vector.<CalendarDayModel>
		{
			return param1.sort(this.sortAsc);
		}
		
		public function get initialized() : Boolean
		{
			return this._initialized;
		}
		
		public function clear() : void
		{
			this.daysConfig[CalendarTypes.CONSECUTIVE] = new Vector.<CalendarDayModel>();
			this.daysConfig[CalendarTypes.NON_CONSECUTIVE] = new Vector.<CalendarDayModel>();
			this.daysConfig[CalendarTypes.UNLOCK] = new Vector.<CalendarDayModel>();
			this.shouldDisplayCalendarAtStartup = false;
		}
		
		public function getCurrentDay(param1:String) : int
		{
			return this.currentDayConfig[param1];
		}
		
		public function setCurrentDay(param1:String, param2:int) : void
		{
			this.currentDayConfig[param1] = param2;
		}
	}
}
