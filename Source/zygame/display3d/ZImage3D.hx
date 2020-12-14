package zygame.display3d;

import openfl.display.BitmapData;
import away3d.utils.Cast;
import away3d.materials.MaterialBase;
import openfl.Vector;
import away3d.core.base.SubGeometry;
import away3d.materials.TextureMaterial;
import zygame.utils.load.Frame;
import away3d.entities.Sprite3D;

/**
 * 可使用zygameui框架中的Frame精灵表数据
 */
class ZImage3D extends Sprite3D {
	private var _textureMaterial:TextureMaterial;

	public function new(frame:Dynamic, textureMaterial:TextureMaterial = null) {
		super(null, frame.width, frame.height,false);
		_textureMaterial = textureMaterial;
		this.setFrame(frame);
    }

    /**
     * 获取纹理
     * @return TextureMaterial
     */
    public function getTextureMaterial():TextureMaterial{
        return _textureMaterial;
    }

	public function setFrame(frame:Dynamic, resetSize:Bool = true):Void {
		if (_textureMaterial == null) {
			if (Std.is(frame, Frame)) {
				_textureMaterial = new TextureMaterial(cast(frame, Frame).getTexture3D());
			} else {
				_textureMaterial = new TextureMaterial(Cast.bitmapTexture(frame));
			}
		}
		_textureMaterial.bothSides = true;
		_textureMaterial.alphaBlending = true;
		this.material = _textureMaterial;
		if (Std.is(frame, Frame)) {
			var uvs = cast(frame, Frame).getUv();
			this.UVData[0] = uvs[0];
			this.UVData[1] = uvs[1];
			this.UVData[2] = uvs[2];
			this.UVData[3] = uvs[3];
			this.UVData[4] = uvs[6];
			this.UVData[5] = uvs[7];
			this.UVData[6] = uvs[4];
			this.UVData[7] = uvs[5];
			if (resetSize) {
				this.width = cast(frame, Frame).width;
				this.height = cast(frame, Frame).height;
			}
		} else {
			this.width = cast(frame, BitmapData).width;
			this.height = cast(frame, BitmapData).height;
		}
	}
}