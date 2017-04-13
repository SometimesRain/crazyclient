package kabam.rotmg.news.model
{
   import kabam.rotmg.news.controller.NewsDataUpdatedSignal;
   import kabam.rotmg.news.controller.NewsButtonRefreshSignal;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.news.view.NewsModalPage;
   import com.company.assembleegameclient.parameters.Parameters;
   
   public class NewsModel
   {
      
      private static const COUNT:int = 3;
      
      public static const MODAL_PAGE_COUNT:int = 4;
       
      
      [Inject]
      public var update:NewsDataUpdatedSignal;
      
      [Inject]
      public var updateNoParams:NewsButtonRefreshSignal;
      
      [Inject]
      public var account:Account;
      
      public var news:Vector.<kabam.rotmg.news.model.NewsCellVO>;
      
      public var modalPages:Vector.<NewsModalPage>;
      
      public var modalPageData:Vector.<kabam.rotmg.news.model.NewsCellVO>;
      
      private var inGameNews:Vector.<kabam.rotmg.news.model.InGameNews>;
      
      public function NewsModel()
      {
         this.inGameNews = new Vector.<kabam.rotmg.news.model.InGameNews>();
         super();
      }
      
      public function addInGameNews(param1:kabam.rotmg.news.model.InGameNews) : void
      {
         if(this.isValidForPlatform(param1))
         {
            this.inGameNews.push(param1);
         }
         this.sortNews();
      }
      
      private function sortNews() : *
      {
         this.inGameNews.sort(function(param1:InGameNews, param2:InGameNews):*
         {
            if(param1.weight > param2.weight)
            {
               return -1;
            }
            if(param1.weight == param2.weight)
            {
               return 0;
            }
            return 1;
         });
      }
      
      public function markAsRead() : void
      {
         var _loc1_:kabam.rotmg.news.model.InGameNews = this.getFirstNews();
         if(_loc1_ != null)
         {
            Parameters.data_["lastNewsKey"] = _loc1_.newsKey;
            Parameters.save();
         }
      }
      
      public function hasUpdates() : Boolean
      {
         var _loc1_:kabam.rotmg.news.model.InGameNews = this.getFirstNews();
         if(_loc1_ == null || Parameters.data_["lastNewsKey"] == _loc1_.newsKey)
         {
            return false;
         }
         return true;
      }
      
      public function getFirstNews() : kabam.rotmg.news.model.InGameNews
      {
         if(this.inGameNews && this.inGameNews.length > 0)
         {
            return this.inGameNews[0];
         }
         return null;
      }
      
      public function initNews() : void
      {
         this.news = new Vector.<kabam.rotmg.news.model.NewsCellVO>(COUNT,true);
         var _loc1_:int = 0;
         while(_loc1_ < COUNT)
         {
            this.news[_loc1_] = new DefaultNewsCellVO(_loc1_);
            _loc1_++;
         }
      }
      
      public function updateNews(param1:Vector.<kabam.rotmg.news.model.NewsCellVO>) : void
      {
         var _loc3_:kabam.rotmg.news.model.NewsCellVO = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this.initNews();
         var _loc2_:Vector.<kabam.rotmg.news.model.NewsCellVO> = new Vector.<kabam.rotmg.news.model.NewsCellVO>();
         this.modalPageData = new Vector.<kabam.rotmg.news.model.NewsCellVO>(4,true);
         for each(_loc3_ in param1)
         {
            if(_loc3_.slot <= 3)
            {
               _loc2_.push(_loc3_);
            }
            else
            {
               _loc4_ = _loc3_.slot - 4;
               _loc5_ = _loc4_ + 1;
               this.modalPageData[_loc4_] = _loc3_;
               if(Parameters.data_["newsTimestamp" + _loc5_] != _loc3_.endDate)
               {
                  Parameters.data_["newsTimestamp" + _loc5_] = _loc3_.endDate;
                  Parameters.data_["hasNewsUpdate" + _loc5_] = true;
               }
            }
         }
         this.update.dispatch(this.news);
         this.updateNoParams.dispatch();
      }
      
      public function hasValidNews() : Boolean
      {
         return this.news[0] != null && this.news[1] != null && this.news[2] != null;
      }
      
      public function hasValidModalNews() : Boolean
      {
         return this.inGameNews.length > 0;
      }
      
      public function get numberOfNews() : int
      {
         return this.inGameNews.length;
      }
      
      public function getModalPage(param1:int) : NewsModalPage
      {
         var _loc2_:kabam.rotmg.news.model.InGameNews = null;
         if(this.hasValidModalNews())
         {
            _loc2_ = this.inGameNews[param1 - 1];
            return new NewsModalPage(_loc2_.title,_loc2_.text);
         }
         return new NewsModalPage("No new information","Please check back later.");
      }
      
      private function isValidForPlatform(param1:kabam.rotmg.news.model.InGameNews) : Boolean
      {
         var _loc2_:String = this.account.gameNetwork();
         return param1.platform.indexOf(_loc2_) != -1;
      }
   }
}
