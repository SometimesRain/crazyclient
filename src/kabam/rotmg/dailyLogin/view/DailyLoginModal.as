package kabam.rotmg.dailyLogin.view
{
	import flash.display.Sprite;
	import kabam.rotmg.text.view.TextFieldDisplayConcrete;
	import kabam.rotmg.pets.view.components.DialogCloseButton;
	import flash.geom.Rectangle;
	import com.company.assembleegameclient.ui.DeprecatedTextButtonStatic;
	import kabam.rotmg.dailyLogin.model.DailyLoginModel;
	import kabam.rotmg.dailyLogin.config.CalendarSettings;
	import flash.display.Bitmap;
	import flash.text.TextFormatAlign;
	import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
	import com.company.util.AssetLibrary;
	import flash.display.BitmapData;
	import com.company.assembleegameclient.util.TextureRedrawer;
	import kabam.rotmg.mysterybox.components.MysteryBoxSelectModal;
	import flash.display.DisplayObject;
	import kabam.rotmg.pets.view.components.PopupWindowBackground;
	import kabam.rotmg.text.view.stringBuilder.LineBuilder;
	import flash.text.TextFieldAutoSize;
	import flash.filters.DropShadowFilter;
	
	public class DailyLoginModal extends Sprite
	{
		
		private var content:Sprite;
		
		private var calendarView:kabam.rotmg.dailyLogin.view.CalendarView;
		
		private var titleTxt:TextFieldDisplayConcrete;
		
		private var serverTimeTxt:TextFieldDisplayConcrete;
		
		public var closeButton:DialogCloseButton;
		
		private var modalRectangle:Rectangle;
		
		private var daysLeft:int = 300;
		
		public var claimButton:DeprecatedTextButtonStatic;
		
		private var tabs:kabam.rotmg.dailyLogin.view.CalendarTabsView;
		
		public function DailyLoginModal()
		{
			this.calendarView = new kabam.rotmg.dailyLogin.view.CalendarView();
			this.closeButton = new DialogCloseButton();
			super();
		}
		
		public function init(param1:DailyLoginModel) : void
		{
			this.daysLeft = param1.daysLeftToCalendarEnd;
			this.modalRectangle = CalendarSettings.getCalendarModalRectangle(param1.overallMaxDays,this.daysLeft < CalendarSettings.CLAIM_WARNING_BEFORE_DAYS);
			this.content = new Sprite();
			addChild(this.content);
			this.createModalBox();
			this.tabs = new kabam.rotmg.dailyLogin.view.CalendarTabsView();
			addChild(this.tabs);
			this.tabs.y = CalendarSettings.TABS_Y_POSITION;
			if(this.daysLeft < CalendarSettings.CLAIM_WARNING_BEFORE_DAYS)
			{
				this.tabs.y = this.tabs.y + 20;
			}
			this.centerModal();
		}
		
		private function addClaimButton() : *
		{
			this.claimButton = new DeprecatedTextButtonStatic(16,"Go & Claim");
			this.claimButton.textChanged.addOnce(this.alignClaimButton);
			addChild(this.claimButton);
		}
		
		public function showLegend(param1:Boolean) : *
		{
			var _loc2_:Sprite = null;
			var _loc6_:Bitmap = null;
			var _loc7_:Bitmap = null;
			_loc2_ = new Sprite();
			_loc2_.y = this.modalRectangle.height - 55;
			var _loc3_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(16777215).setTextWidth(this.modalRectangle.width).setHorizontalAlign(TextFormatAlign.LEFT);
			_loc3_.setStringBuilder(new StaticStringBuilder(param1 ? "- Reward ready to claim. Click on day to claim reward." : "- Reward ready to claim."));
			var _loc4_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(16777215).setTextWidth(this.modalRectangle.width).setHorizontalAlign(TextFormatAlign.LEFT);
			_loc4_.setStringBuilder(new StaticStringBuilder("- Item claimed already."));
			_loc3_.x = 20;
			_loc3_.y = 0;
			_loc4_.x = 20;
			_loc4_.y = 20;
			var _loc5_:BitmapData = AssetLibrary.getImageFromSet("lofiInterface",52);
			_loc5_.colorTransform(new Rectangle(0,0,_loc5_.width,_loc5_.height),CalendarSettings.GREEN_COLOR_TRANSFORM);
			_loc5_ = TextureRedrawer.redraw(_loc5_,40,true,0);
			_loc6_ = new Bitmap(_loc5_);
			_loc6_.x = -Math.round(_loc6_.width / 2) + 10;
			_loc6_.y = -Math.round(_loc6_.height / 2) + 9;
			_loc2_.addChild(_loc6_);
			_loc5_ = AssetLibrary.getImageFromSet("lofiInterfaceBig",11);
			_loc5_ = TextureRedrawer.redraw(_loc5_,20,true,0);
			_loc7_ = new Bitmap(_loc5_);
			_loc7_.x = -Math.round(_loc7_.width / 2) + 10;
			_loc7_.y = -Math.round(_loc7_.height / 2) + 30;
			_loc2_.addChild(_loc7_);
			_loc2_.addChild(_loc3_);
			_loc2_.addChild(_loc4_);
			if(!param1)
			{
				this.addClaimButton();
				_loc2_.x = CalendarSettings.DAILY_LOGIN_MODAL_PADDING + this.claimButton.width + 10;
			}
			else
			{
				_loc2_.x = CalendarSettings.DAILY_LOGIN_MODAL_PADDING;
			}
			addChild(_loc2_);
		}
		
		private function alignClaimButton() : void
		{
			this.claimButton.x = CalendarSettings.DAILY_LOGIN_MODAL_PADDING;
			this.claimButton.y = this.modalRectangle.height - this.claimButton.height - CalendarSettings.DAILY_LOGIN_MODAL_PADDING;
			if(this.daysLeft < CalendarSettings.CLAIM_WARNING_BEFORE_DAYS)
			{
			}
		}
		
		private function createModalBox() : *
		{
			var _loc1_:DisplayObject = new MysteryBoxSelectModal.backgroundImageEmbed();
			_loc1_.width = this.modalRectangle.width - 1;
			_loc1_.height = this.modalRectangle.height - 27;
			_loc1_.y = 27;
			_loc1_.alpha = 0.95;
			this.content.addChild(_loc1_);
			this.content.addChild(this.makeModalBackground(this.modalRectangle.width,this.modalRectangle.height));
		}
		
		private function makeModalBackground(param1:int, param2:int) : PopupWindowBackground
		{
			var _loc3_:PopupWindowBackground = new PopupWindowBackground();
			_loc3_.draw(param1,param2,PopupWindowBackground.TYPE_TRANSPARENT_WITH_HEADER);
			return _loc3_;
		}
		
		public function addCloseButton() : void
		{
			this.closeButton.y = 4;
			this.closeButton.x = this.modalRectangle.width - this.closeButton.width - 5;
			addChild(this.closeButton);
		}
		
		public function addTitle(param1:String) : void
		{
			this.titleTxt = this.getText(param1,0,6,true).setSize(18);
			this.titleTxt.setColor(16768512);
			addChild(this.titleTxt);
		}
		
		public function showServerTime(param1:String, param2:String) : void
		{
			var _loc3_:TextFieldDisplayConcrete = null;
			this.serverTimeTxt = new TextFieldDisplayConcrete().setSize(14).setColor(16777215).setTextWidth(this.modalRectangle.width);
			this.serverTimeTxt.setStringBuilder(new StaticStringBuilder("Server time: " + param1 + ", ends on: " + param2));
			this.serverTimeTxt.x = CalendarSettings.DAILY_LOGIN_MODAL_PADDING;
			if(this.daysLeft < CalendarSettings.CLAIM_WARNING_BEFORE_DAYS)
			{
				_loc3_ = new TextFieldDisplayConcrete().setSize(14).setColor(16711680).setTextWidth(this.modalRectangle.width);
				_loc3_.setStringBuilder(new StaticStringBuilder("Calendar will soon end, remember to claim before it ends."));
				_loc3_.x = CalendarSettings.DAILY_LOGIN_MODAL_PADDING;
				_loc3_.y = 40;
				this.serverTimeTxt.y = 60;
				this.calendarView.y = 90;
				addChild(_loc3_);
			}
			else
			{
				this.calendarView.y = 70;
				this.serverTimeTxt.y = 40;
			}
			addChild(this.serverTimeTxt);
		}
		
		public function getText(param1:String, param2:int, param3:int, param4:Boolean = false) : TextFieldDisplayConcrete
		{
			var _loc5_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(16777215).setTextWidth(this.modalRectangle.width);
			_loc5_.setBold(true);
			if(param4)
			{
				_loc5_.setStringBuilder(new StaticStringBuilder(param1));
			}
			else
			{
				_loc5_.setStringBuilder(new LineBuilder().setParams(param1));
			}
			_loc5_.setWordWrap(true);
			_loc5_.setMultiLine(true);
			_loc5_.setAutoSize(TextFieldAutoSize.CENTER);
			_loc5_.setHorizontalAlign(TextFormatAlign.CENTER);
			_loc5_.filters = [new DropShadowFilter(0,0,0)];
			_loc5_.x = param2;
			_loc5_.y = param3;
			return _loc5_;
		}
		
		private function centerModal() : void
		{
			this.x = 400 - this.width / 2;
			this.y = 300 - this.height / 2;
			this.tabs.x = CalendarSettings.DAILY_LOGIN_MODAL_PADDING;
		}
	}
}
