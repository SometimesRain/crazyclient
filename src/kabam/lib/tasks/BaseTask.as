package kabam.lib.tasks {
import flash.errors.IllegalOperationError;

import org.osflash.signals.Signal;

public class BaseTask implements Task {

    private var _started:TaskStartedSignal;
    private var _finished:TaskResultSignal;
    private var _lastly:TaskResultSignal;
    private var _isStarted:Boolean;
    private var _isFinished:Boolean;
    private var _isOK:Boolean;
    private var _error:String;


    final public function start():void {
        if (!this._isStarted) {
            this._isStarted = true;
            ((this._started) && (this._started.dispatch(this)));
            this.startTask();
        }
    }

    final public function reset():void {
        if (this._isStarted) {
            this._isStarted = false;
            if (!this._isFinished) {
                throw (new IllegalOperationError("Unable to Task.reset() when a task is ongoing"));
            }
        }
        ((this._started) && (this._started.removeAll()));
        ((this._finished) && (this._finished.removeAll()));
        ((this._lastly) && (this._lastly.removeAll()));
        this.onReset();
    }

    protected function startTask():void {
    }

    protected function onReset():void {
    }

    final protected function completeTask(_arg_1:Boolean, _arg_2:String = ""):void {
        this._isOK = _arg_1;
        this._error = _arg_2;
        this._isFinished = true;
        ((this._finished) && (this._finished.dispatch(this, _arg_1, _arg_2)));
        ((this._lastly) && (this._lastly.dispatch(this, _arg_1, _arg_2)));
    }

    final public function get started():Signal {
        return ((this._started = ((this._started) || (new TaskStartedSignal()))));
    }

    final public function get finished():TaskResultSignal {
        return ((this._finished = ((this._finished) || (new TaskResultSignal()))));
    }

    final public function get lastly():TaskResultSignal {
        return ((this._lastly = ((this._lastly) || (new TaskResultSignal()))));
    }

    public function get isStarted():Boolean {
        return (this._isStarted);
    }

    public function get isFinished():Boolean {
        return (this._isFinished);
    }

    public function get isOK():Boolean {
        return (this._isOK);
    }

    public function get error():String {
        return (this._error);
    }


}
}//package kabam.lib.tasks
