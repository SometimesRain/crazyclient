package kabam.rotmg.news.view
{
   import kabam.rotmg.account.core.view.EmptyFrame;
   import flash.geom.ColorTransform;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import flash.text.TextField;
   import kabam.rotmg.text.model.FontModel;
   import flash.display.Sprite;
   import kabam.rotmg.news.model.NewsModel;
   import kabam.rotmg.core.StaticInjectorContext;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.KeyboardEvent;
   import kabam.rotmg.ui.model.HUDModel;
   import flash.display.DisplayObject;
   import kabam.rotmg.pets.view.components.PopupWindowBackground;
   import com.company.util.KeyCodes;
   import com.company.util.AssetLibrary;
   import flash.display.BitmapData;
   import flash.display.Bitmap;
   import com.company.util.MoreColorUtil;
   import com.company.assembleegameclient.sound.SoundEffectLibrary;
   
   public class NewsModal extends EmptyFrame
   {
      
      public static var backgroundImageEmbed:Class = NewsModal_backgroundImageEmbed;
      
      public static var foregroundImageEmbed:Class = NewsModal_foregroundImageEmbed;
      
      public static const MODAL_WIDTH:int = 440;
      
      public static const MODAL_HEIGHT:int = 400;
      
      public static var modalWidth:int = MODAL_WIDTH;
      
      public static var modalHeight:int = MODAL_HEIGHT;
      
      private static const OVER_COLOR_TRANSFORM:ColorTransform = new ColorTransform(1,220 / 255,133 / 255);
      
      private static const DROP_SHADOW_FILTER:DropShadowFilter = new DropShadowFilter(0,0,0);
      
      private static const GLOW_FILTER:GlowFilter = new GlowFilter(16711680,1,11,5);
      
      private static const filterWithGlow:Array = [DROP_SHADOW_FILTER,GLOW_FILTER];
      
      private static const filterNoGlow:Array = [DROP_SHADOW_FILTER];
       
      
      private var currentPage:kabam.rotmg.news.view.NewsModalPage;
      
      private var currentPageNum:int = -1;
      
      private var pageOneNav:TextField;
      
      private var pageTwoNav:TextField;
      
      private var pageThreeNav:TextField;
      
      private var pageFourNav:TextField;
      
      private var pageNavs:Vector.<TextField>;
      
      private var pageIndicator:TextField;
      
      private var fontModel:FontModel;
      
      private var leftNavSprite:Sprite;
      
      private var rightNavSprite:Sprite;
      
      private var newsModel:NewsModel;
      
      private var currentPageNumber:int = 1;
      
      private var triggeredOnStartup:Boolean;
      
      public function NewsModal(param1:Boolean = false)
      {
         this.triggeredOnStartup = param1;
         this.newsModel = StaticInjectorContext.getInjector().getInstance(NewsModel);
         this.fontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
         modalWidth = MODAL_WIDTH;
         modalHeight = MODAL_HEIGHT;
         super(modalWidth,modalHeight);
         this.setCloseButton(true);
         this.pageIndicator = new TextField();
         this.initNavButtons();
         this.setPage(this.currentPageNumber);
         WebMain.STAGE.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownListener);
         addEventListener(Event.ADDED_TO_STAGE,this.onAdded);
         addEventListener(Event.REMOVED_FROM_STAGE,this.destroy);
         closeButton.clicked.add(this.onCloseButtonClicked);
      }
      
      public static function getText(param1:String, param2:int, param3:int, param4:Boolean) : TextFieldDisplayConcrete
      {
         var _loc5_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(18).setColor(16777215).setTextWidth(NewsModal.modalWidth - TEXT_MARGIN * 2 - 10);
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
      
      public function onCloseButtonClicked() : *
      {
         /*var _loc1_:FlushPopupStartupQueueSignal = StaticInjectorContext.getInjector().getInstance(FlushPopupStartupQueueSignal);
         closeButton.clicked.remove(this.onCloseButtonClicked);
         if(this.triggeredOnStartup)
         {
            _loc1_.dispatch();
         }*/
      }
      
      private function onAdded(param1:Event) : *
      {
         this.newsModel.markAsRead();
         this.refreshNewsButton();
      }
      
      private function updateIndicator() : *
      {
         this.fontModel.apply(this.pageIndicator,24,16777215,true);
         this.pageIndicator.text = this.currentPageNumber + " / " + this.newsModel.numberOfNews;
         addChild(this.pageIndicator);
         this.pageIndicator.y = modalHeight - 33;
         this.pageIndicator.x = modalWidth / 2 - this.pageIndicator.textWidth / 2;
         this.pageIndicator.width = this.pageIndicator.textWidth + 4;
      }
      
      private function initNavButtons() : void
      {
         this.updateIndicator();
         this.leftNavSprite = this.makeLeftNav();
         this.rightNavSprite = this.makeRightNav();
         this.leftNavSprite.x = modalWidth * 4 / 11 - this.rightNavSprite.width / 2;
         this.leftNavSprite.y = modalHeight - 4;
         addChild(this.leftNavSprite);
         this.rightNavSprite.x = modalWidth * 7 / 11 - this.rightNavSprite.width / 2;
         this.rightNavSprite.y = modalHeight - 4;
         addChild(this.rightNavSprite);
      }
      
      public function onClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.rightNavSprite:
               if(this.currentPageNumber + 1 <= this.newsModel.numberOfNews)
               {
                  this.setPage(this.currentPageNumber + 1);
               }
               break;
            case this.leftNavSprite:
               if(this.currentPageNumber - 1 >= 1)
               {
                  this.setPage(this.currentPageNumber - 1);
               }
         }
      }
      
      private function destroy(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAdded);
         WebMain.STAGE.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownListener);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.destroy);
         this.leftNavSprite.removeEventListener(MouseEvent.CLICK,this.onClick);
         this.leftNavSprite.removeEventListener(MouseEvent.MOUSE_OVER,this.onArrowHover);
         this.leftNavSprite.removeEventListener(MouseEvent.MOUSE_OUT,this.onArrowHoverOut);
         this.rightNavSprite.removeEventListener(MouseEvent.CLICK,this.onClick);
         this.rightNavSprite.removeEventListener(MouseEvent.MOUSE_OVER,this.onArrowHover);
         this.rightNavSprite.removeEventListener(MouseEvent.MOUSE_OUT,this.onArrowHoverOut);
      }
      
      private function setPage(param1:int) : void
      {
         this.currentPageNumber = param1;
         if(this.currentPage && this.currentPage.parent)
         {
            removeChild(this.currentPage);
         }
         this.currentPage = this.newsModel.getModalPage(param1);
         addChild(this.currentPage);
         this.updateIndicator();
      }
      
      private function refreshNewsButton() : void
      {
         /*var _loc1_:HUDModel = StaticInjectorContext.getInjector().getInstance(HUDModel);
         if(_loc1_ != null && _loc1_.gameSprite != null)
         {
            _loc1_.gameSprite.refreshNewsUpdateButton();
         }*/
      }
      
      override protected function makeModalBackground() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         var _loc2_:DisplayObject = new backgroundImageEmbed();
         _loc2_.width = modalWidth + 1;
         _loc2_.height = modalHeight - 25;
         _loc2_.y = 27;
         _loc2_.alpha = 0.95;
         var _loc3_:DisplayObject = new foregroundImageEmbed();
         _loc3_.width = modalWidth + 1;
         _loc3_.height = modalHeight - 67;
         _loc3_.y = 27;
         _loc3_.alpha = 1;
         var _loc4_:PopupWindowBackground = new PopupWindowBackground();
         _loc4_.draw(modalWidth,modalHeight,PopupWindowBackground.TYPE_TRANSPARENT_WITH_HEADER);
         _loc1_.addChild(_loc2_);
         _loc1_.addChild(_loc3_);
         _loc1_.addChild(_loc4_);
         return _loc1_;
      }
      
      private function keyDownListener(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == KeyCodes.RIGHT)
         {
            if(this.currentPageNumber + 1 <= this.newsModel.numberOfNews)
            {
               this.setPage(this.currentPageNumber + 1);
            }
         }
         else if(param1.keyCode == KeyCodes.LEFT)
         {
            if(this.currentPageNumber - 1 >= 1)
            {
               this.setPage(this.currentPageNumber - 1);
            }
         }
      }
      
      private function makeLeftNav() : Sprite
      {
         var _loc1_:BitmapData = AssetLibrary.getImageFromSet("lofiInterface",54);
         var _loc2_:Bitmap = new Bitmap(_loc1_);
         _loc2_.scaleX = 4;
         _loc2_.scaleY = 4;
         _loc2_.rotation = -90;
         var _loc3_:Sprite = new Sprite();
         _loc3_.addChild(_loc2_);
         _loc3_.addEventListener(MouseEvent.MOUSE_OVER,this.onArrowHover);
         _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.onArrowHoverOut);
         _loc3_.addEventListener(MouseEvent.CLICK,this.onClick);
         return _loc3_;
      }
      
      private function makeRightNav() : Sprite
      {
         var _loc1_:BitmapData = AssetLibrary.getImageFromSet("lofiInterface",55);
         var _loc2_:Bitmap = new Bitmap(_loc1_);
         _loc2_.scaleX = 4;
         _loc2_.scaleY = 4;
         _loc2_.rotation = -90;
         var _loc3_:Sprite = new Sprite();
         _loc3_.addChild(_loc2_);
         _loc3_.addEventListener(MouseEvent.MOUSE_OVER,this.onArrowHover);
         _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.onArrowHoverOut);
         _loc3_.addEventListener(MouseEvent.CLICK,this.onClick);
         return _loc3_;
      }
      
      private function onArrowHover(param1:MouseEvent) : void
      {
         param1.currentTarget.transform.colorTransform = OVER_COLOR_TRANSFORM;
      }
      
      private function onArrowHoverOut(param1:MouseEvent) : void
      {
         param1.currentTarget.transform.colorTransform = MoreColorUtil.identity;
      }
      
      override public function onCloseClick(param1:MouseEvent) : void
      {
         SoundEffectLibrary.play("button_click");
      }
   }
}
