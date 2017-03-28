package kabam.rotmg.dailyLogin.view
{
	import flash.display.Sprite;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsData;
	import kabam.rotmg.text.view.TextFieldDisplayConcrete;
	import flash.events.Event;
	import kabam.rotmg.dailyLogin.config.CalendarSettings;
	import flash.text.TextFieldAutoSize;
	import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
	import flash.display.LineScaleMode;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import com.company.util.GraphicsUtil;
	
	public class CalendarTabButton extends Sprite
	{
		
		public static const STATE_SELECTED:String = "selected";
		
		public static const STATE_IDLE:String = "idle";
		 
		
		private var path_:GraphicsPath;
		
		private var fill_:GraphicsSolidFill;
		
		private var fillIdle_:GraphicsSolidFill;
		
		private var lineStyle_:GraphicsStroke;
		
		private var graphicsDataBackground:Vector.<IGraphicsData>;
		
		private var graphicsDataBackgroundIdle:Vector.<IGraphicsData>;
		
		private var _calendarType:String;
		
		private var state_:String = "idle";
		
		private var tabNameTxt:TextFieldDisplayConcrete;
		
		private var background:Sprite;
		
		private var tabName:String;
		
		private var hintText:String;
		
		//private var hintTextField;
		
		private var tooltip:kabam.rotmg.dailyLogin.view.DailyCalendarInfoIcon;
		
		public function CalendarTabButton(param1:String, param2:String, param3:String, param4:String, param5:int)
		{
			this.path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
			this.fill_ = new GraphicsSolidFill(3552822,1);
			this.fillIdle_ = new GraphicsSolidFill(2236962,1);
			this.lineStyle_ = new GraphicsStroke(CalendarSettings.BOX_BORDER,false,LineScaleMode.NORMAL,CapsStyle.NONE,JointStyle.ROUND,3,new GraphicsSolidFill(16777215));
			this.graphicsDataBackground = new <IGraphicsData>[this.lineStyle_,this.fill_,this.path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
			this.graphicsDataBackgroundIdle = new <IGraphicsData>[this.lineStyle_,this.fillIdle_,this.path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
			super();
			this._calendarType = param3;
			this.tabName = param1;
			this.hintText = param2;
			this.drawTab();
			this.addEventListener(Event.ADDED,this.onAddedHandler);
		}
		
		private function onAddedHandler(param1:Event) : void
		{
			this.removeEventListener(Event.ADDED,this.onAddedHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
		}
		
		private function onRemovedFromStage(param1:Event) : void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
		}
		
		private function drawTab() : void
		{
			if(this.background)
			{
				removeChild(this.background);
			}
			if(this.tooltip)
			{
				removeChild(this.tooltip);
			}
			this.background = CalendarDayBox.drawRectangleWithCuts([1,1,0,0],CalendarSettings.TABS_WIDTH,CalendarSettings.TABS_HEIGHT,3552822,1,this.state_ == STATE_IDLE?this.graphicsDataBackgroundIdle:this.graphicsDataBackground,this.path_);
			this.addChild(this.background);
			if(this.tabNameTxt)
			{
				removeChild(this.tabNameTxt);
			}
			this.tabNameTxt = new TextFieldDisplayConcrete().setSize(CalendarSettings.TABS_FONT_SIZE).setColor(this.state_ == STATE_IDLE?uint(16777215):uint(16768512)).setTextWidth(CalendarSettings.TABS_WIDTH).setAutoSize(TextFieldAutoSize.CENTER);
			this.tabNameTxt.setStringBuilder(new StaticStringBuilder(this.tabName));
			this.tabNameTxt.y = (CalendarSettings.TABS_HEIGHT - CalendarSettings.TABS_FONT_SIZE) / 2;
			this.tooltip = new kabam.rotmg.dailyLogin.view.DailyCalendarInfoIcon(this.tabName,this.hintText);
			this.tooltip.x = CalendarSettings.TABS_WIDTH - 15;
			this.tooltip.y = 5;
			addChild(this.tooltip);
			if(this.state_ == STATE_IDLE)
			{
				this.tabNameTxt.alpha = 0.5;
			}
			this.addChild(this.tabNameTxt);
		}
		
		public function set state(param1:String) : void
		{
			if(param1 != this.state_)
			{
				this.state_ = param1;
				this.drawTab();
			}
		}
		
		public function get calendarType() : String
		{
			return this._calendarType;
		}
	}
}
