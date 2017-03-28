package kabam.rotmg.pets.view.dialogs {
import com.company.util.GraphicsUtil;

import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;

public class PetItemBackground extends Sprite {

    private var backgroundFill_:GraphicsSolidFill;
    private var path_:GraphicsPath;

    public function PetItemBackground(_arg_1:int, _arg_2:Array) {
        this.backgroundFill_ = new GraphicsSolidFill(0x545454);
        this.path_ = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        super();
        var _local_3:Vector.<IGraphicsData> = new <IGraphicsData>[this.backgroundFill_, this.path_, GraphicsUtil.END_FILL];
        GraphicsUtil.drawCutEdgeRect(0, 0, _arg_1, _arg_1, (_arg_1 / 12), _arg_2, this.path_);
        graphics.drawGraphicsData(_local_3);
    }

}
}//package kabam.rotmg.pets.view.dialogs
