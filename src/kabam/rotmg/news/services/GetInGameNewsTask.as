package kabam.rotmg.news.services
{
   import kabam.lib.tasks.BaseTask;
   import robotlegs.bender.framework.api.ILogger;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.news.model.NewsModel;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.news.model.InGameNews;
   import kabam.rotmg.news.view.NewsModal;
   
   public class GetInGameNewsTask extends BaseTask
   {
       
      
      [Inject]
      public var logger:ILogger;
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var model:NewsModel;
      
      [Inject]
      public var openDialogSignal:OpenDialogSignal;
      
      private var requestData:Object;
      
      public function GetInGameNewsTask()
      {
         super();
      }
      
      override protected function startTask() : void
      {
         this.logger.info("GetInGameNewsTask start");
         this.requestData = this.makeRequestData();
         this.sendRequest();
      }
      
      public function makeRequestData() : Object
      {
         var _loc1_:Object = {};
         return _loc1_;
      }
      
      private function sendRequest() : void
      {
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/inGameNews/getNews",this.requestData);
      }
      
      private function onComplete(param1:Boolean, param2:*) : void
      {
         this.logger.info("String response from GetInGameNewsTask: " + param2);
         if(param1)
         {
            this.parseNews(param2);
         }
         else
         {
            completeTask(true);
         }
      }
      
      private function parseNews(param1:String) : *
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:InGameNews = null;
         this.logger.info("Parsing news");
         try
         {
            _loc3_ = JSON.parse(param1);
            for each(_loc4_ in _loc3_)
            {
               this.logger.info("Parse single news");
               _loc5_ = new InGameNews();
               _loc5_.newsKey = _loc4_.newsKey;
               _loc5_.showAtStartup = _loc4_.showAtStartup;
               _loc5_.startTime = _loc4_.startTime;
               _loc5_.text = _loc4_.text;
               _loc5_.title = _loc4_.title;
               _loc5_.platform = _loc4_.platform;
               _loc5_.weight = _loc4_.weight;
               this.model.addInGameNews(_loc5_);
            }
         }
         catch(e:Error)
         {
         }
         var _loc2_:InGameNews = this.model.getFirstNews();
         completeTask(true);
      }
   }
}
