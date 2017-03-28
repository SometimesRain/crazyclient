package kabam.rotmg.dailyLogin.view
{
	import flash.display.Sprite;
	import flash.display.IGraphicsData;
	import flash.display.GraphicsPath;
	import flash.display.Shape;
	import com.company.util.GraphicsUtil;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import kabam.rotmg.dailyLogin.model.CalendarDayModel;
	import flash.display.Bitmap;
	import com.company.util.AssetLibrary;
	import flash.display.BitmapData;
	import com.company.assembleegameclient.util.TextureRedrawer;
	import kabam.rotmg.dailyLogin.config.CalendarSettings;
	import kabam.rotmg.text.view.TextFieldDisplayConcrete;
	import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
	import flash.display.LineScaleMode;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import kabam.rotmg.assets.services.IconFactory;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	
	public class CalendarDayBox extends Sprite
	{
		 
		
		private var fill_:GraphicsSolidFill;
		
		private var fillCurrent_:GraphicsSolidFill;
		
		private var fillBlack_:GraphicsSolidFill;
		
		private var lineStyle_:GraphicsStroke;
		
		private var path_:GraphicsPath;
		
		private var graphicsDataBackground:Vector.<IGraphicsData>;
		
		private var graphicsDataBackgroundCurrent:Vector.<IGraphicsData>;
		
		private var graphicsDataClaimedOverlay:Vector.<IGraphicsData>;
		
		public var day:CalendarDayModel;
		
		private var redDot:Bitmap;
		
		private var boxCuts:Array;
		
		public function CalendarDayBox(param1:CalendarDayModel, param2:int, param3:Boolean)
		{
			var _loc6_:ItemTileRenderer = null;
			var _loc7_:Bitmap = null;
			var _loc8_:BitmapData = null;
			var _loc9_:TextFieldDisplayConcrete = null;
			this.fill_ = new GraphicsSolidFill(3552822,1);
			this.fillCurrent_ = new GraphicsSolidFill(4889165,1);
			this.fillBlack_ = new GraphicsSolidFill(0,0.7);
			this.lineStyle_ = new GraphicsStroke(CalendarSettings.BOX_BORDER,false,LineScaleMode.NORMAL,CapsStyle.NONE,JointStyle.ROUND,3,new GraphicsSolidFill(16777215));
			this.path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
			this.graphicsDataBackground = new <IGraphicsData>[this.lineStyle_,this.fill_,this.path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
			this.graphicsDataBackgroundCurrent = new <IGraphicsData>[this.lineStyle_,this.fillCurrent_,this.path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
			this.graphicsDataClaimedOverlay = new <IGraphicsData>[this.lineStyle_,this.fillBlack_,this.path_,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
			super();
			this.day = param1;
			var _loc4_:int = Math.ceil(param1.dayNumber / CalendarSettings.NUMBER_OF_COLUMNS);
			var _loc5_:int = Math.ceil(param2 / CalendarSettings.NUMBER_OF_COLUMNS);
			if(param1.dayNumber == 1)
			{
				if(_loc5_ == 1)
				{
					this.boxCuts = [1,0,0,1];
				}
				else
				{
					this.boxCuts = [1,0,0,0];
				}
			}
			else if(param1.dayNumber == param2)
			{
				if(_loc5_ == 1)
				{
					this.boxCuts = [0,1,1,0];
				}
				else
				{
					this.boxCuts = [0,0,1,0];
				}
			}
			else if(_loc4_ == 1 && param1.dayNumber % CalendarSettings.NUMBER_OF_COLUMNS == 0)
			{
				this.boxCuts = [0,1,0,0];
			}
			else if(_loc4_ == _loc5_ && (param1.dayNumber - 1) % CalendarSettings.NUMBER_OF_COLUMNS == 0)
			{
				this.boxCuts = [0,0,0,1];
			}
			else
			{
				this.boxCuts = [0,0,0,0];
			}
			this.drawBackground(this.boxCuts,param3);
			if(param1.gold == 0 && param1.itemID > 0)
			{
				_loc6_ = new ItemTileRenderer(param1.itemID);
				addChild(_loc6_);
				_loc6_.x = Math.round(CalendarSettings.BOX_WIDTH / 2);
				_loc6_.y = Math.round(CalendarSettings.BOX_HEIGHT / 2);
			}
			if(param1.gold > 0)
			{
				_loc7_ = new Bitmap();
				_loc7_.bitmapData = IconFactory.makeCoin(80);
				addChild(_loc7_);
				_loc7_.x = Math.round(CalendarSettings.BOX_WIDTH / 2 - _loc7_.width / 2);
				_loc7_.y = Math.round(CalendarSettings.BOX_HEIGHT / 2 - _loc7_.height / 2);
			}
			this.displayDayNumber(param1.dayNumber);
			if(param1.claimKey != "")
			{
				_loc8_ = AssetLibrary.getImageFromSet("lofiInterface",52);
				_loc8_.colorTransform(new Rectangle(0,0,_loc8_.width,_loc8_.height),CalendarSettings.GREEN_COLOR_TRANSFORM);
				_loc8_ = TextureRedrawer.redraw(_loc8_,40,true,0);
				this.redDot = new Bitmap(_loc8_);
				this.redDot.x = CalendarSettings.BOX_WIDTH - Math.round(this.redDot.width / 2) - 10;
				this.redDot.y = -Math.round(this.redDot.width / 2) + 10;
				addChild(this.redDot);
			}
			if(param1.quantity > 1 || param1.gold > 0)
			{
				_loc9_ = new TextFieldDisplayConcrete().setSize(14).setColor(16777215).setTextWidth(CalendarSettings.BOX_WIDTH).setAutoSize(TextFieldAutoSize.RIGHT);
				_loc9_.setStringBuilder(new StaticStringBuilder("x" + (param1.gold > 0?param1.gold.toString():param1.quantity.toString())));
				_loc9_.y = CalendarSettings.BOX_HEIGHT - 18;
				_loc9_.x = -2;
				addChild(_loc9_);
			}
			if(param1.isClaimed)
			{
				this.markAsClaimed();
			}
		}
		
		public static function drawRectangleWithCuts(param1:Array, param2:int, param3:int, param4:uint, param5:Number, param6:Vector.<IGraphicsData>, param7:GraphicsPath) : Sprite
		{
			var _loc8_:Shape = new Shape();
			var _loc9_:Shape = new Shape();
			var _loc10_:Sprite = new Sprite();
			_loc10_.addChild(_loc8_);
			_loc10_.addChild(_loc9_);
			GraphicsUtil.clearPath(param7);
			GraphicsUtil.drawCutEdgeRect(0,0,param2,param3,4,param1,param7);
			_loc8_.graphics.clear();
			_loc8_.graphics.drawGraphicsData(param6);
			var _loc11_:GraphicsSolidFill = new GraphicsSolidFill(param4,param5);
			GraphicsUtil.clearPath(param7);
			var _loc12_:Vector.<IGraphicsData> = new <IGraphicsData>[_loc11_,param7,GraphicsUtil.END_FILL];
			GraphicsUtil.drawCutEdgeRect(0,0,param2,param3,4,param1,param7);
			_loc9_.graphics.drawGraphicsData(_loc12_);
			_loc9_.cacheAsBitmap = true;
			_loc9_.visible = false;
			return _loc10_;
		}
		
		public function getDay() : CalendarDayModel
		{
			return this.day;
		}
		
		public function markAsClaimed() : void
		{
			if(this.redDot && this.redDot.parent)
			{
				removeChild(this.redDot);
			}
			var _loc1_:BitmapData = AssetLibrary.getImageFromSet("lofiInterfaceBig",11);
			_loc1_ = TextureRedrawer.redraw(_loc1_,60,true,2997032);
			var _loc2_:Bitmap = new Bitmap(_loc1_);
			_loc2_.x = Math.round((CalendarSettings.BOX_WIDTH - _loc2_.width) / 2);
			_loc2_.y = Math.round((CalendarSettings.BOX_HEIGHT - _loc2_.height) / 2);
			var _loc3_:Sprite = drawRectangleWithCuts(this.boxCuts,CalendarSettings.BOX_WIDTH,CalendarSettings.BOX_HEIGHT,0,1,this.graphicsDataClaimedOverlay,this.path_);
			addChild(_loc3_);
			addChild(_loc2_);
		}
		
		private function displayDayNumber(param1:int) : void
		{
			var _loc2_:TextFieldDisplayConcrete = null;
			_loc2_ = new TextFieldDisplayConcrete().setSize(16).setColor(16777215).setTextWidth(CalendarSettings.BOX_WIDTH);
			_loc2_.setBold(true);
			_loc2_.setStringBuilder(new StaticStringBuilder(param1.toString()));
			_loc2_.x = 4;
			_loc2_.y = 4;
			addChild(_loc2_);
		}
		
		public function drawBackground(param1:Array, param2:Boolean) : void
		{
			addChild(drawRectangleWithCuts(param1,CalendarSettings.BOX_WIDTH,CalendarSettings.BOX_HEIGHT,3552822,1,!!param2?this.graphicsDataBackgroundCurrent:this.graphicsDataBackground,this.path_));
		}
	}
}
