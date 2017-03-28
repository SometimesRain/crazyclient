package kabam.rotmg.news.view {
import kabam.rotmg.news.controller.NewsDataUpdatedSignal;
import kabam.rotmg.news.model.NewsCellVO;
import kabam.rotmg.news.model.NewsModel;
import kabam.rotmg.news.services.GetAppEngineNewsTask;

import robotlegs.bender.bundles.mvcs.Mediator;

public class NewsModalMediator extends Mediator {

    public static var firstRun:Boolean = true;

    [Inject]
    public var update:NewsDataUpdatedSignal;
    [Inject]
    public var model:NewsModel;
    [Inject]
    public var getNews:GetAppEngineNewsTask;


    override public function initialize():void {
        this.update.add(this.onUpdate);
        this.getNews.start();
        if (firstRun) {
            firstRun = false;
            this.model.buildModalPages();
        }
    }

    override public function destroy():void {
        this.update.remove(this.onUpdate);
    }

    private function onUpdate(_arg_1:Vector.<NewsCellVO>):void {
        this.model.buildModalPages();
    }


}
}//package kabam.rotmg.news.view
