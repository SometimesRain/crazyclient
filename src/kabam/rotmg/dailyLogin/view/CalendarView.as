package kabam.rotmg.dailyLogin.view
{
	import flash.display.Sprite;
	import kabam.rotmg.dailyLogin.model.CalendarDayModel;
	import kabam.rotmg.dailyLogin.config.CalendarSettings;
	
	public class CalendarView extends Sprite
	{
		 
		
		public function CalendarView()
		{
			super();
		}
		
		public function init(param1:Vector.<CalendarDayModel>, param2:int, param3:int) : void
		{
			var _loc7_:CalendarDayModel = null;
			var _loc8_:int = 0;
			var _loc9_:CalendarDayBox = null;
			var _loc4_:int = 0;
			var _loc5_:int = 0;
			var _loc6_:int = 0;
			for each(_loc7_ in param1)
			{
				_loc9_ = new CalendarDayBox(_loc7_,param2,_loc4_ + 1 == param3);
				addChild(_loc9_);
				_loc9_.x = _loc5_ * CalendarSettings.BOX_WIDTH;
				if(_loc5_ > 0)
				{
					_loc9_.x = _loc9_.x + _loc5_ * CalendarSettings.BOX_MARGIN;
				}
				_loc9_.y = _loc6_ * CalendarSettings.BOX_HEIGHT;
				if(_loc6_ > 0)
				{
					_loc9_.y = _loc9_.y + _loc6_ * CalendarSettings.BOX_MARGIN;
				}
				_loc5_++;
				_loc4_++;
				if(_loc4_ % CalendarSettings.NUMBER_OF_COLUMNS == 0)
				{
					_loc5_ = 0;
					_loc6_++;
				}
			}
			_loc8_ = CalendarSettings.BOX_WIDTH * CalendarSettings.NUMBER_OF_COLUMNS + (CalendarSettings.NUMBER_OF_COLUMNS - 1) * CalendarSettings.BOX_MARGIN;
			this.x = (this.parent.width - _loc8_) / 2;
			this.y = CalendarSettings.DAILY_LOGIN_TABS_PADDING + CalendarSettings.TABS_HEIGHT;
		}
	}
}
