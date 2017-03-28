package kabam.rotmg.external.service {
import com.company.util.MoreObjectUtil;

import flash.events.TimerEvent;
import flash.utils.Timer;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.game.model.GameModel;

public class RequestPlayerCreditsTask extends BaseTask {

    private static const REQUEST:String = "account/getCredits";

    [Inject]
    public var account:Account;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var gameModel:GameModel;
    [Inject]
    public var playerModel:PlayerModel;
    private var retryTimes:Array;
    private var timer:Timer;
    private var retryCount:int = 0;

    public function RequestPlayerCreditsTask() {
        this.retryTimes = [2, 5, 15];
        this.timer = new Timer(1000);
        super();
    }

    override protected function startTask():void {
        this.timer.addEventListener(TimerEvent.TIMER, this.handleTimer);
        this.timer.start();
    }

    private function handleTimer(_arg_1:TimerEvent):void {
        var _local_2:Array = this.retryTimes;
        var _local_3:int = this.retryCount;
        var _local_4:int = (_local_2[_local_3] - 1);
        _local_2[_local_3] = _local_4;
        if (this.retryTimes[this.retryCount] <= 0) {
            this.timer.removeEventListener(TimerEvent.TIMER, this.handleTimer);
            this.makeRequest();
            this.retryCount++;
            this.timer.stop();
        }
    }

    private function makeRequest():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest(REQUEST, this.makeRequestObject());
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        var _local_4:String;
        var _local_3:Boolean;
        if (_arg_1) {
            _local_4 = XML(_arg_2).toString();
            if (((!((_local_4 == ""))) && (!((_local_4.search("Error") == -1))))) {
                this.setCredits(int(_local_4));
            }
        }
        else {
            if (this.retryCount < this.retryTimes.length) {
                this.timer.addEventListener(TimerEvent.TIMER, this.handleTimer);
                this.timer.start();
                _local_3 = true;
            }
        }
        ((!(_local_3)) && (completeTask(_arg_1, _arg_2)));
    }

    private function setCredits(_arg_1:int):void {
        if (_arg_1 >= 0) {
            if (((((!((this.gameModel == null))) && (!((this.gameModel.player == null))))) && (!((_arg_1 == this.gameModel.player.credits_))))) {
                this.gameModel.player.credits_ = _arg_1;
            }
            else {
                if (((!((this.playerModel == null))) && (!((this.playerModel.getCredits() == _arg_1))))) {
                    this.playerModel.setCredits(_arg_1);
                }
            }
        }
    }

    private function makeRequestObject():Object {
        var _local_1:Object = {};
        MoreObjectUtil.addToObject(_local_1, this.account.getCredentials());
        return (_local_1);
    }


}
}//package kabam.rotmg.external.service
