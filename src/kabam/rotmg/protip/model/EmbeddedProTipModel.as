package kabam.rotmg.protip.model {
public class EmbeddedProTipModel implements IProTipModel {

    public static var protipsXML:Class = EmbeddedProTipModel_protipsXML;

    private var tips:Vector.<String>;
    private var indices:Vector.<int>;
    private var index:int;
    private var count:int;

    public function EmbeddedProTipModel() {
        this.index = 0;
        this.makeTipsVector();
        this.count = this.tips.length;
        this.makeRandomizedIndexVector();
    }

    public function getTip():String {
        var _local_1:int = this.indices[(this.index++ % this.count)];
        return (this.tips[_local_1]);
    }

    private function makeTipsVector():void {
        var _local_2:XML;
        var _local_1:XML = XML(new protipsXML());
        this.tips = new Vector.<String>(0);
        for each (_local_2 in _local_1.Protip) {
            this.tips.push(_local_2.toString());
        }
        this.count = this.tips.length;
    }

    private function makeRandomizedIndexVector():void {
        var _local_1:Vector.<int> = new Vector.<int>(0);
        var _local_2:int;
        while (_local_2 < this.count) {
            _local_1.push(_local_2);
            _local_2++;
        }
        this.indices = new Vector.<int>(0);
        while (_local_2 > 0) {
            this.indices.push(_local_1.splice(Math.floor((Math.random() * _local_2--)), 1)[0]);
        }
        this.indices.fixed = true;
    }


}
}//package kabam.rotmg.protip.model
