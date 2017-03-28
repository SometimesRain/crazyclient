package kabam.rotmg.fortune.components {
import flash.events.TimerEvent;
import flash.utils.Timer;

public class TimerCallback {

    private var f:Function;
    private var data1:*;
    private var data2:*;
    private var data3:*;
    private var data4:*;
    private var data5:*;
    private var data6:*;
    private var data7:*;
    private var data8:*;
    private var tbo:Timer;

    public function TimerCallback(_arg_1:Number, _arg_2:Function, _arg_3:* = null, _arg_4:* = null, _arg_5:* = null, _arg_6:* = null, _arg_7:* = null, _arg_8:* = null, _arg_9:* = null, _arg_10:* = null) {
        this.f = _arg_2;
        if (_arg_3 != null) {
            this.data1 = _arg_3;
        }
        if (_arg_4 != null) {
            this.data2 = _arg_4;
        }
        if (_arg_5 != null) {
            this.data3 = _arg_5;
        }
        if (_arg_6 != null) {
            this.data4 = _arg_6;
        }
        if (_arg_7 != null) {
            this.data5 = _arg_7;
        }
        if (_arg_8 != null) {
            this.data6 = _arg_8;
        }
        if (_arg_9 != null) {
            this.data7 = _arg_9;
        }
        if (_arg_10 != null) {
            this.data8 = _arg_10;
        }
        this.tbo = new Timer((_arg_1 * 1000), 1);
        this.tbo.addEventListener(TimerEvent.TIMER_COMPLETE, this.callbackWrapper);
        this.tbo.start();
    }

    public function callbackWrapper(_arg_1:TimerEvent):void {
        this.tbo.removeEventListener(TimerEvent.TIMER_COMPLETE, this.callbackWrapper);
        if (this.data8 != null) {
            this.f(this.data1, this.data2, this.data3, this.data4, this.data5, this.data6, this.data7, this.data8);
        }
        else {
            if (this.data7 != null) {
                this.f(this.data1, this.data2, this.data3, this.data4, this.data5, this.data6, this.data7);
            }
            else {
                if (this.data6 != null) {
                    this.f(this.data1, this.data2, this.data3, this.data4, this.data5, this.data6);
                }
                else {
                    if (this.data5 != null) {
                        this.f(this.data1, this.data2, this.data3, this.data4, this.data5);
                    }
                    else {
                        if (this.data4 != null) {
                            this.f(this.data1, this.data2, this.data3, this.data4);
                        }
                        else {
                            if (this.data3 != null) {
                                this.f(this.data1, this.data2, this.data3);
                            }
                            else {
                                if (this.data2 != null) {
                                    this.f(this.data1, this.data2);
                                }
                                else {
                                    if (this.data1 != null) {
                                        this.f(this.data1);
                                    }
                                    else {
                                        this.f();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }


}
}//package kabam.rotmg.fortune.components
