package com.company.assembleegameclient.ui.board {
import com.company.assembleegameclient.ui.board.EmbeddedHelp;
public class HelpXML {

    public static var protipsXML:Class = EmbeddedHelp;

    public var commands:Vector.<String> = new <String>[];
    public var explanations:Vector.<String> = new <String>[];

    public function HelpXML() {
        this.makeTipsVector();
    }

    private function makeTipsVector():void {
        var _local_1:XML = XML(new protipsXML());
        for (var con:String in _local_1.Article) {
            commands.push(_local_1.Article.Command[con]);
            explanations.push(_local_1.Article.Explanation[con]);
        }
    }

}
}