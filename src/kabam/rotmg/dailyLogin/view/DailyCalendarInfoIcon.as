package kabam.rotmg.dailyLogin.view
{
	import flash.display.Sprite;
	import kabam.rotmg.tooltips.TooltipAble;
	import flash.geom.ColorTransform;
	import kabam.rotmg.tooltips.HoverTooltipDelegate;
	import com.company.assembleegameclient.ui.tooltip.TextToolTip;
	import flash.events.MouseEvent;
	import com.company.util.MoreColorUtil;
	import kabam.rotmg.core.signals.ShowTooltipSignal;
	import kabam.rotmg.core.signals.HideTooltipsSignal;
	import kabam.rotmg.text.view.TextFieldDisplayConcrete;
	import kabam.rotmg.dailyLogin.config.CalendarSettings;
	import flash.text.TextFieldAutoSize;
	import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
	
	public class DailyCalendarInfoIcon extends Sprite implements TooltipAble
	{
		
		protected static const mouseOverCT:ColorTransform = new ColorTransform(1,220 / 255,133 / 255);
		 
		
		public var hoverTooltipDelegate:HoverTooltipDelegate;
		
		private var toolTip_:TextToolTip = null;
		
		public function DailyCalendarInfoIcon(param1:String = "", param2:String = "", param3:Object = null)
		{
			this.hoverTooltipDelegate = new HoverTooltipDelegate();
			super();
			var _loc4_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(CalendarSettings.TABS_FONT_SIZE).setColor(16777215).setTextWidth(15).setAutoSize(TextFieldAutoSize.CENTER).setBold(true).setSize(22);
			_loc4_.setStringBuilder(new StaticStringBuilder("i"));
			addChild(_loc4_);
			if(param1 != "")
			{
				this.setToolTipTitle(param1,param2,param3);
			}
		}
		
		public function destroy() : void
		{
			while(numChildren > 0)
			{
				this.removeChildAt(numChildren - 1);
			}
			this.toolTip_ = null;
			this.hoverTooltipDelegate.removeDisplayObject();
			this.hoverTooltipDelegate = null;
			removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
		}
		
		private function setToolTipTitle(param1:String, param2:String, param3:Object) : void
		{
			this.toolTip_ = new TextToolTip(3552822,10197915,param1,param2,200,param3);
			this.hoverTooltipDelegate.setDisplayObject(this);
			this.hoverTooltipDelegate.tooltip = this.toolTip_;
			addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
		}
		
		protected function onMouseOver(param1:MouseEvent) : void
		{
			transform.colorTransform = mouseOverCT;
		}
		
		protected function onMouseOut(param1:MouseEvent) : void
		{
			transform.colorTransform = MoreColorUtil.identity;
		}
		
		public function setShowToolTipSignal(param1:ShowTooltipSignal) : void
		{
			this.hoverTooltipDelegate.setShowToolTipSignal(param1);
		}
		
		public function getShowToolTip() : ShowTooltipSignal
		{
			return this.hoverTooltipDelegate.getShowToolTip();
		}
		
		public function setHideToolTipsSignal(param1:HideTooltipsSignal) : void
		{
			this.hoverTooltipDelegate.setHideToolTipsSignal(param1);
		}
		
		public function getHideToolTips() : HideTooltipsSignal
		{
			return this.hoverTooltipDelegate.getHideToolTips();
		}
	}
}
