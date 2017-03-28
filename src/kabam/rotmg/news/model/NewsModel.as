package kabam.rotmg.news.model {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.news.controller.NewsButtonRefreshSignal;
import kabam.rotmg.news.controller.NewsDataUpdatedSignal;
import kabam.rotmg.news.view.NewsModalPage;

public class NewsModel {

    private static const COUNT:int = 3;
    public static const MODAL_PAGE_COUNT:int = 4;

    [Inject]
    public var update:NewsDataUpdatedSignal;
    [Inject]
    public var updateNoParams:NewsButtonRefreshSignal;
    [Inject]
    public var account:Account;
    public var news:Vector.<NewsCellVO>;
    public var modalPages:Vector.<NewsModalPage>;
    public var modalPageData:Vector.<NewsCellVO>;


    public function initNews():void {
        this.news = new Vector.<NewsCellVO>(COUNT, true);
        var _local_1:int;
        while (_local_1 < COUNT) {
            this.news[_local_1] = new DefaultNewsCellVO(_local_1);
            _local_1++;
        }
    }

    public function updateNews(_arg_1:Vector.<NewsCellVO>):void {
        var _local_3:NewsCellVO;
        var _local_4:int;
        var _local_5:int;
        this.initNews();
        var _local_2:Vector.<NewsCellVO> = new Vector.<NewsCellVO>();
        this.modalPageData = new Vector.<NewsCellVO>(4, true);
        for each (_local_3 in _arg_1) {
            if (_local_3.slot <= 3) {
                _local_2.push(_local_3);
            }
            else {
                _local_4 = (_local_3.slot - 4);
                _local_5 = (_local_4 + 1);
                this.modalPageData[_local_4] = _local_3;
                if (Parameters.data_[("newsTimestamp" + _local_5)] != _local_3.endDate) {
                    Parameters.data_[("newsTimestamp" + _local_5)] = _local_3.endDate;
                    Parameters.data_[("hasNewsUpdate" + _local_5)] = true;
                }
            }
        }
        this.sortByPriority(_local_2);
        this.update.dispatch(this.news);
        this.updateNoParams.dispatch();
    }

    public function hasValidNews():Boolean {
        return (((((!((this.news[0] == null))) && (!((this.news[1] == null))))) && (!((this.news[2] == null)))));
    }

    public function hasValidModalNews():Boolean {
        var _local_1:int;
        while (_local_1 < MODAL_PAGE_COUNT) {
            if (this.modalPageData[_local_1] == null) {
                return (false);
            }
            _local_1++;
        }
        return (true);
    }

    private function sortByPriority(_arg_1:Vector.<NewsCellVO>):void {
        var _local_2:NewsCellVO;
        for each (_local_2 in _arg_1) {
            if (((this.isNewsTimely(_local_2)) && (this.isValidForPlatform(_local_2)))) {
                this.prioritize(_local_2);
            }
        }
    }

    private function prioritize(_arg_1:NewsCellVO):void {
        var _local_2:uint = (_arg_1.slot - 1);
        if (this.news[_local_2]) {
            _arg_1 = this.comparePriority(this.news[_local_2], _arg_1);
        }
        this.news[_local_2] = _arg_1;
    }

    private function comparePriority(_arg_1:NewsCellVO, _arg_2:NewsCellVO):NewsCellVO {
        return ((((_arg_1.priority) < _arg_2.priority) ? _arg_1 : _arg_2));
    }

    private function isNewsTimely(_arg_1:NewsCellVO):Boolean {
        var _local_2:Number = new Date().getTime();
        return ((((_arg_1.startDate < _local_2)) && ((_local_2 < _arg_1.endDate))));
    }

    public function buildModalPages():void {
        if (!this.hasValidModalNews()) {
            return;
        }
        this.modalPages = new Vector.<NewsModalPage>(MODAL_PAGE_COUNT, true);
        var _local_1:int;
        while (_local_1 < MODAL_PAGE_COUNT) {
            this.modalPages[_local_1] = new NewsModalPage((this.modalPageData[_local_1] as NewsCellVO).headline, (this.modalPageData[_local_1] as NewsCellVO).linkDetail);
            _local_1++;
        }
    }

    public function getModalPage(_arg_1:int):NewsModalPage {
        if (((((((!((this.modalPages == null))) && ((_arg_1 > 0)))) && ((_arg_1 <= this.modalPages.length)))) && (!((this.modalPages[(_arg_1 - 1)] == null))))) {
            return (this.modalPages[(_arg_1 - 1)]);
        }
        return (new NewsModalPage("No new information", "Please check back later."));
    }

    private function isValidForPlatform(_arg_1:NewsCellVO):Boolean {
        var _local_2:String = this.account.gameNetwork();
        return (!((_arg_1.networks.indexOf(_local_2) == -1)));
    }


}
}//package kabam.rotmg.news.model
