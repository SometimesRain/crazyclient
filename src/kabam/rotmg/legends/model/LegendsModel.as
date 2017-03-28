package kabam.rotmg.legends.model {
public class LegendsModel {

    private const map:Object = {};

    private var timespan:Timespan;

    public function LegendsModel() {
        this.timespan = Timespan.WEEK;
        super();
    }

    public function getTimespan():Timespan {
        return (this.timespan);
    }

    public function setTimespan(_arg_1:Timespan):void {
        this.timespan = _arg_1;
    }

    public function hasLegendList():Boolean {
        return (!((this.map[this.timespan.getId()] == null)));
    }

    public function getLegendList():Vector.<Legend> {
        return (this.map[this.timespan.getId()]);
    }

    public function setLegendList(_arg_1:Vector.<Legend>):void {
        this.map[this.timespan.getId()] = _arg_1;
    }

    public function clear():void {
        var _local_1:String;
        for (_local_1 in this.map) {
            this.dispose(this.map[_local_1]);
            delete this.map[_local_1];
        }
    }

    private function dispose(_arg_1:Vector.<Legend>):void {
        var _local_2:Legend;
        for each (_local_2 in _arg_1) {
            ((_local_2.character) && (this.removeLegendCharacter(_local_2)));
        }
    }

    private function removeLegendCharacter(_arg_1:Legend):void {
        _arg_1.character.dispose();
        _arg_1.character = null;
    }


}
}//package kabam.rotmg.legends.model
