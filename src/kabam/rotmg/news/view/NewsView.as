package kabam.rotmg.news.view {
import flash.display.Sprite;

import kabam.rotmg.news.model.NewsCellVO;

public class NewsView extends Sprite {

    private const LARGE_CELL_WIDTH:Number = 306;
    private const LARGE_CELL_HEIGHT:Number = 194;
    private const SMALL_CELL_WIDTH:Number = 151;
    private const SMALL_CELL_HEIGHT:Number = 189;
    private const SPACER:Number = 4;
    private const cellOne:NewsCell = new NewsCell(LARGE_CELL_WIDTH, LARGE_CELL_HEIGHT);
    private const cellTwo:NewsCell = new NewsCell(SMALL_CELL_WIDTH, SMALL_CELL_HEIGHT);
    private const cellThree:NewsCell = new NewsCell(SMALL_CELL_WIDTH, SMALL_CELL_HEIGHT);

    public function NewsView() {
        this.tabChildren = false;
        this.addChildren();
        this.positionChildren();
    }

    private function addChildren():void {
        addChild(this.cellOne);
        addChild(this.cellTwo);
        addChild(this.cellThree);
    }

    private function positionChildren():void {
        this.cellTwo.y = (this.LARGE_CELL_HEIGHT + this.SPACER);
        this.cellThree.x = (this.SMALL_CELL_WIDTH + this.SPACER);
        this.cellThree.y = (this.LARGE_CELL_HEIGHT + this.SPACER);
    }

    public function update(_arg_1:Vector.<NewsCellVO>):void {
        this.cellOne.init(_arg_1[0]);
        this.cellTwo.init(_arg_1[1]);
        this.cellThree.init(_arg_1[2]);
        this.cellOne.load();
        this.cellTwo.load();
        this.cellThree.load();
    }


}
}//package kabam.rotmg.news.view
