package kabam.rotmg.dailyLogin.view
{
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.filters.ColorMatrixFilter;
	import kabam.rotmg.text.view.BitmapTextFactory;
	import com.company.assembleegameclient.ui.tooltip.ToolTip;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import kabam.rotmg.core.StaticInjectorContext;
	import org.swiftsuspenders.Injector;
	import kabam.rotmg.core.signals.HideTooltipsSignal;
	import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;
	import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
	import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.EquipmentTile;
	import kabam.rotmg.constants.ItemConstants;
	import kabam.rotmg.text.model.TextKey;
	import com.company.assembleegameclient.ui.tooltip.TextToolTip;
	import kabam.rotmg.core.signals.ShowTooltipSignal;
	import flash.display.BitmapData;
	import com.company.assembleegameclient.objects.ObjectLibrary;
	import kabam.rotmg.dailyLogin.config.CalendarSettings;
	import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
	
	public class ItemTileRenderer extends Sprite
	{
		
		protected static const DIM_FILTER:Array = [new ColorMatrixFilter([0.4,0,0,0,0,0,0.4,0,0,0,0,0,0.4,0,0,0,0,0,1,0])];
		
		private static const IDENTITY_MATRIX:Matrix = new Matrix();
		
		private static const DOSE_MATRIX:Matrix = function():Matrix
		{
			var _loc1_:* = new Matrix();
			_loc1_.translate(10,5);
			return _loc1_;
		}();
		 
		
		private var itemId:int;
		
		private var bitmapFactory:BitmapTextFactory;
		
		private var tooltip:ToolTip;
		
		private var itemBitmap:Bitmap;
		
		public function ItemTileRenderer(param1:int)
		{
			super();
			this.itemId = param1;
			this.itemBitmap = new Bitmap();
			addChild(this.itemBitmap);
			this.drawTile();
			this.addEventListener(MouseEvent.MOUSE_OVER,this.onTileHover);
			this.addEventListener(MouseEvent.MOUSE_OUT,this.onTileOut);
		}
		
		private function onTileOut(param1:MouseEvent) : void
		{
			var _loc2_:Injector = StaticInjectorContext.getInjector();
			var _loc3_:HideTooltipsSignal = _loc2_.getInstance(HideTooltipsSignal);
			_loc3_.dispatch();
		}
		
		private function onTileHover(param1:MouseEvent) : void
		{
			if(!stage)
			{
				return;
			}
			var _loc2_:ItemTile = param1.currentTarget as ItemTile;
			this.addToolTipToTile(_loc2_);
		}
		
		private function addToolTipToTile(param1:ItemTile) : void
		{
			var _loc4_:String = null;
			if(this.itemId > 0)
			{
				this.tooltip = new EquipmentToolTip(this.itemId,null,-1,"");
			}
			else
			{
				if(param1 is EquipmentTile)
				{
					_loc4_ = ItemConstants.itemTypeToName((param1 as EquipmentTile).itemType);
				}
				else
				{
					_loc4_ = TextKey.ITEM;
				}
				this.tooltip = new TextToolTip(3552822,10197915,null,TextKey.ITEM_EMPTY_SLOT,200,{"itemType":TextKey.wrapForTokenResolution(_loc4_)});
			}
			this.tooltip.attachToTarget(param1);
			var _loc2_:Injector = StaticInjectorContext.getInjector();
			var _loc3_:ShowTooltipSignal = _loc2_.getInstance(ShowTooltipSignal);
			_loc3_.dispatch(this.tooltip);
		}
		
		public function drawTile() : void
		{
			var _loc2_:BitmapData = null;
			var _loc3_:XML = null;
			var _loc4_:BitmapData = null;
			var _loc1_:int = this.itemId;
			if(_loc1_ != ItemConstants.NO_ITEM)
			{
				if(_loc1_ >= 36864 && _loc1_ < 61440)
				{
					_loc1_ = 36863;
				}
				_loc2_ = ObjectLibrary.getRedrawnTextureFromType(_loc1_,CalendarSettings.ITEM_SIZE,true);
				_loc3_ = ObjectLibrary.xmlLibrary_[_loc1_];
				if(_loc3_ && _loc3_.hasOwnProperty("Doses") && this.bitmapFactory)
				{
					_loc2_ = _loc2_.clone();
					_loc4_ = this.bitmapFactory.make(new StaticStringBuilder(String(_loc3_.Doses)),12,16777215,false,IDENTITY_MATRIX,false);
					_loc2_.draw(_loc4_,DOSE_MATRIX);
				}
				if(_loc3_ && _loc3_.hasOwnProperty("Quantity") && this.bitmapFactory)
				{
					_loc2_ = _loc2_.clone();
					_loc4_ = this.bitmapFactory.make(new StaticStringBuilder(String(_loc3_.Quantity)),12,16777215,false,IDENTITY_MATRIX,false);
					_loc2_.draw(_loc4_,DOSE_MATRIX);
				}
				this.itemBitmap.bitmapData = _loc2_;
				this.itemBitmap.x = -_loc2_.width / 2;
				this.itemBitmap.y = -_loc2_.width / 2;
				visible = true;
			}
			else
			{
				visible = false;
			}
		}
	}
}
