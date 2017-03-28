package kabam.rotmg.dailyLogin.view
{
	import flash.display.Sprite;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.GraphicsPath;
	import flash.display.IGraphicsData;
	import flash.geom.Rectangle;
	import kabam.rotmg.dailyLogin.config.CalendarSettings;
	import flash.display.LineScaleMode;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import com.company.util.GraphicsUtil;
	
	public class CalendarTabsView extends Sprite
	{
		
		private var fill_:GraphicsSolidFill;
		
		private var fillTransparent_:GraphicsSolidFill;
		
		private var lineStyle_:GraphicsStroke;
		
		private var path_:GraphicsPath;
		
		private var graphicsDataBackgroundTransparent:Vector.<IGraphicsData>;
		
		private var modalRectangle:Rectangle;
		
		private var tabs:Vector.<kabam.rotmg.dailyLogin.view.CalendarTabButton>;
		
		private var calendar:kabam.rotmg.dailyLogin.view.CalendarView;
		
		public function CalendarTabsView()
		{
			this.fill_ = new GraphicsSolidFill(3552822,1);
			this.fillTransparent_ = new GraphicsSolidFill(3552822,0);
			this.lineStyle_ = new GraphicsStroke(CalendarSettings.BOX_BORDER,false,LineScaleMode.NORMAL,CapsStyle.NONE,JointStyle.ROUND,3,new GraphicsSolidFill(16777215));
			this.path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
			this.graphicsDataBackgroundTransparent = new <IGraphicsData>[this.lineStyle_,this.fillTransparent_,this.path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
			super();
		}
		
		public function init(param1:Rectangle) : void
		{
			this.modalRectangle = param1;
			this.tabs = new Vector.<kabam.rotmg.dailyLogin.view.CalendarTabButton>();
		}
		
		public function addCalendar(param1:String, param2:String, param3:String) : kabam.rotmg.dailyLogin.view.CalendarTabButton
		{
			var _loc4_:kabam.rotmg.dailyLogin.view.CalendarTabButton = new kabam.rotmg.dailyLogin.view.CalendarTabButton(param1,param3,param2,kabam.rotmg.dailyLogin.view.CalendarTabButton.STATE_IDLE,this.tabs.length);
			this.addChild(_loc4_);
			_loc4_.x = (CalendarSettings.TABS_WIDTH - 1) * this.tabs.length;
			this.tabs.push(_loc4_);
			return _loc4_;
		}
		
		public function selectTab(param1:String) : void
		{
			var _loc2_:kabam.rotmg.dailyLogin.view.CalendarTabButton = null;
			for each(_loc2_ in this.tabs)
			{
				if(_loc2_.calendarType == param1)
				{
					_loc2_.state = kabam.rotmg.dailyLogin.view.CalendarTabButton.STATE_SELECTED;
				}
				else
				{
					_loc2_.state = kabam.rotmg.dailyLogin.view.CalendarTabButton.STATE_IDLE;
				}
			}
			if(this.calendar)
			{
				removeChild(this.calendar);
			}
			this.calendar = new kabam.rotmg.dailyLogin.view.CalendarView();
			addChild(this.calendar);
			this.calendar.x = CalendarSettings.DAILY_LOGIN_TABS_PADDING;
		}
		
		public function drawTabs() :void
		{
			this.drawBorder();
		}
		
		private function drawBorder() : void
		{
			var _loc1_:Sprite = new Sprite();
			this.drawRectangle(_loc1_,this.modalRectangle.width,this.modalRectangle.height);
			addChild(_loc1_);
			_loc1_.y = CalendarSettings.TABS_HEIGHT;
		}
		
		private function drawRectangle(param1:Sprite, param2:int, param3:int) : void
		{
			param1.addChild(CalendarDayBox.drawRectangleWithCuts([0,0,1,1],param2,param3,3552822,1,this.graphicsDataBackgroundTransparent,this.path_));
		}
	}
}
