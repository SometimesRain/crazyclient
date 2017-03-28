package com.company.assembleegameclient.map.mapoverlay {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.objects.GameObject;

public interface IMapOverlayElement {

    function draw(_arg_1:Camera, _arg_2:int):Boolean;

    function dispose():void;

    function getGameObject():GameObject;

}
}//package com.company.assembleegameclient.map.mapoverlay
