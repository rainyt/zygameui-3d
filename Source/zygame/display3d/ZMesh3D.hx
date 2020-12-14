package zygame.display3d;

import openfl.display.BitmapData;
import away3d.utils.Cast;
import away3d.materials.TextureMaterial;
import zygame.utils.load.Frame;
import away3d.primitives.PlaneGeometry;
import away3d.entities.Mesh;

/**
 * 平面网格3D对象
 */
class ZMesh3D extends Mesh {

    private var _textureMaterial:TextureMaterial;
    
    public function new(frame:Dynamic) {
        var plane = new PlaneGeometry();
        plane.yUp = false;
        super(plane);
        this.setFrame(frame);
    }

    public function setFrame(frame:Dynamic, resetSize:Bool = true):Void {
		if (_textureMaterial == null) {
			if (Std.is(frame, Frame)) {
				_textureMaterial = new TextureMaterial(cast(frame, Frame).getTexture3D());
			} else {
				_textureMaterial = new TextureMaterial(Cast.bitmapTexture(frame));
			}
		}
		// _textureMaterial.alphaBlending = true;
		this.material = _textureMaterial;
		// if (Std.is(frame, Frame)) {
        //     var uvs = cast(frame, Frame).getUv();
        //     var sub = this.geometry.subGeometries[0];
		// 	sub.UVData[0] = uvs[0];
		// 	sub.UVData[1] = uvs[1];
		// 	sub.UVData[2] = uvs[2];
		// 	sub.UVData[3] = uvs[3];
		// 	sub.UVData[4] = uvs[6];
		// 	sub.UVData[5] = uvs[7];
		// 	sub.UVData[6] = uvs[4];
		// 	sub.UVData[7] = uvs[5];
		// 	if (resetSize) {
		// 		cast(geometry,PlaneGeometry).width = cast(frame, Frame).width;
		// 		cast(geometry,PlaneGeometry).height = cast(frame, Frame).height;
		// 	}
		// } else {
		// 	cast(geometry,PlaneGeometry).width = cast(frame, BitmapData).width;
		// 	cast(geometry,PlaneGeometry).height = cast(frame, BitmapData).height;
		// }
	}

}