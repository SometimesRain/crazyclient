package kabam.rotmg.stage3D {
import com.company.assembleegameclient.map.Camera;

import flash.display.IGraphicsData;

import kabam.rotmg.stage3D.Object3D.Object3DStage3D;

import org.osflash.signals.Signal;

public class Render3D extends Signal {

    public function Render3D() {
        super(Vector.<IGraphicsData>, Vector.<Object3DStage3D>, Number, Number, Camera, uint);
    }

}
}//package kabam.rotmg.stage3D
