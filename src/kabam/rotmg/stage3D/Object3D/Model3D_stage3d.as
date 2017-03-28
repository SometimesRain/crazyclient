package kabam.rotmg.stage3D.Object3D {
import flash.display3D.Context3D;
import flash.display3D.VertexBuffer3D;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

public class Model3D_stage3d {

    public var name:String;
    public var groups:Vector.<OBJGroup>;
    public var vertexBuffer:VertexBuffer3D;
    protected var _materials:Dictionary;
    protected var _tupleIndex:uint;
    protected var _tupleIndices:Dictionary;
    protected var _vertices:Vector.<Number>;

    public function Model3D_stage3d() {
        this.groups = new Vector.<OBJGroup>();
        this._materials = new Dictionary();
        this._vertices = new Vector.<Number>();
    }

    public function dispose():void {
        var _local_1:OBJGroup;
        for each (_local_1 in this.groups) {
            _local_1.dispose();
        }
        this.groups.length = 0;
        if (this.vertexBuffer !== null) {
            this.vertexBuffer.dispose();
            this.vertexBuffer = null;
        }
        this._vertices.length = 0;
        this._tupleIndex = 0;
        this._tupleIndices = new Dictionary();
    }

    public function CreatBuffer(_arg_1:Context3D):void {
        var _local_2:OBJGroup;
        for each (_local_2 in this.groups) {
            if (_local_2._indices.length > 0) {
                _local_2.indexBuffer = _arg_1.createIndexBuffer(_local_2._indices.length);
                _local_2.indexBuffer.uploadFromVector(_local_2._indices, 0, _local_2._indices.length);
                _local_2._faces = null;
            }
        }
        this.vertexBuffer = _arg_1.createVertexBuffer((this._vertices.length / 8), 8);
        this.vertexBuffer.uploadFromVector(this._vertices, 0, (this._vertices.length / 8));
    }

    public function readBytes(_arg_1:ByteArray):void {
        var _local_2:Vector.<String>;
        var _local_3:OBJGroup;
        var _local_10:String;
        var _local_11:Array;
        var _local_12:String;
        var _local_13:int;
        var _local_14:int;
        this.dispose();
        var _local_4:String = "";
        var _local_5:Vector.<Number> = new Vector.<Number>();
        var _local_6:Vector.<Number> = new Vector.<Number>();
        var _local_7:Vector.<Number> = new Vector.<Number>();
        _arg_1.position = 0;
        var _local_8:String = _arg_1.readUTFBytes(_arg_1.bytesAvailable);
        var _local_9:Array = _local_8.split(/[\r\n]+/);
        for each (_local_10 in _local_9) {
            _local_10 = _local_10.replace(/^\s*|\s*$/g, "");
            if (!(((_local_10 == "")) || ((_local_10.charAt(0) === "#")))) {
                _local_11 = _local_10.split(/\s+/);
                switch (_local_11[0].toLowerCase()) {
                    case "v":
                        _local_5.push(parseFloat(_local_11[1]), parseFloat(_local_11[2]), parseFloat(_local_11[3]));
                        break;
                    case "vn":
                        _local_6.push(parseFloat(_local_11[1]), parseFloat(_local_11[2]), parseFloat(_local_11[3]));
                        break;
                    case "vt":
                        _local_7.push(parseFloat(_local_11[1]), (1 - parseFloat(_local_11[2])));
                        break;
                    case "f":
                        _local_2 = new Vector.<String>();
                        for each (_local_12 in _local_11.slice(1)) {
                            _local_2.push(_local_12);
                        }
                        if (_local_3 === null) {
                            _local_3 = new OBJGroup(null, _local_4);
                            this.groups.push(_local_3);
                        }
                        _local_3._faces.push(_local_2);
                        break;
                    case "g":
                        _local_3 = new OBJGroup(_local_11[1], _local_4);
                        this.groups.push(_local_3);
                        break;
                    case "o":
                        this.name = _local_11[1];
                        break;
                    case "mtllib":
                        break;
                    case "usemtl":
                        _local_4 = _local_11[1];
                        if (_local_3 !== null) {
                            _local_3.materialName = _local_4;
                        }
                        break;
                }
            }
        }
        for each (_local_3 in this.groups) {
            _local_3._indices.length = 0;
            for each (_local_2 in _local_3._faces) {
                _local_13 = (_local_2.length - 1);
                _local_14 = 1;
                while (_local_14 < _local_13) {
                    _local_3._indices.push(this.mergeTuple(_local_2[_local_14], _local_5, _local_6, _local_7));
                    _local_3._indices.push(this.mergeTuple(_local_2[0], _local_5, _local_6, _local_7));
                    _local_3._indices.push(this.mergeTuple(_local_2[(_local_14 + 1)], _local_5, _local_6, _local_7));
                    _local_14++;
                }
            }
            _local_3._faces = null;
        }
        this._tupleIndex = 0;
        this._tupleIndices = null;
    }

    protected function mergeTuple(_arg_1:String, _arg_2:Vector.<Number>, _arg_3:Vector.<Number>, _arg_4:Vector.<Number>):uint {
        var _local_5:Array;
        var _local_6:uint;
        if (this._tupleIndices[_arg_1] !== undefined) {
            return (this._tupleIndices[_arg_1]);
        }
        _local_5 = _arg_1.split("/");
        _local_6 = (parseInt(_local_5[0], 10) - 1);
        this._vertices.push(_arg_2[((_local_6 * 3) + 0)], _arg_2[((_local_6 * 3) + 1)], _arg_2[((_local_6 * 3) + 2)]);
        if ((((_local_5.length > 2)) && ((_local_5[2].length > 0)))) {
            _local_6 = (parseInt(_local_5[2], 10) - 1);
            this._vertices.push(_arg_3[((_local_6 * 3) + 0)], _arg_3[((_local_6 * 3) + 1)], _arg_3[((_local_6 * 3) + 2)]);
        }
        else {
            this._vertices.push(0, 0, 0);
        }
        if ((((_local_5.length > 1)) && ((_local_5[1].length > 0)))) {
            _local_6 = (parseInt(_local_5[1], 10) - 1);
            this._vertices.push(_arg_4[((_local_6 * 2) + 0)], _arg_4[((_local_6 * 2) + 1)]);
        }
        else {
            this._vertices.push(0, 0);
        }
        return ((this._tupleIndices[_arg_1] = this._tupleIndex++));
    }


}
}//package kabam.rotmg.stage3D.Object3D
