package kabam.rotmg.servers.api {
public final class LatLong {

    private static const TO_DEGREES:Number = (180 / Math.PI);//57.2957795130823
    private static const TO_RADIANS:Number = (Math.PI / 180);//0.0174532925199433
    private static const DISTANCE_SCALAR:Number = (((60 * 1.1515) * 1.609344) * 1000);//111189.57696

    public var latitude:Number;
    public var longitude:Number;

    public function LatLong(_arg_1:Number, _arg_2:Number) {
        this.latitude = _arg_1;
        this.longitude = _arg_2;
    }

    public static function distance(_arg_1:LatLong, _arg_2:LatLong):Number {
        var _local_3:Number = (TO_RADIANS * (_arg_1.longitude - _arg_2.longitude));
        var _local_4:Number = (TO_RADIANS * _arg_1.latitude);
        var _local_5:Number = (TO_RADIANS * _arg_2.latitude);
        var _local_6:Number = ((Math.sin(_local_4) * Math.sin(_local_5)) + ((Math.cos(_local_4) * Math.cos(_local_5)) * Math.cos(_local_3)));
        _local_6 = ((TO_DEGREES * Math.acos(_local_6)) * DISTANCE_SCALAR);
        return (_local_6);
    }


    public function toString():String {
        return ((((("(" + this.latitude) + ", ") + this.longitude) + ")"));
    }


}
}//package kabam.rotmg.servers.api
