package zygame.utils;

import openfl.geom.Vector3D;
import away3d.containers.View3D;

/**
 * 3D使用的便捷库
 */
class Lib3D {
    
    public static function unproject(view3d:View3D,mouseX:Float,mouseY:Float,z:Float = 0):Vector3D{
        var viewWidth = view3d.width * 0.5;
        var viewHeight = view3d.height * 0.5;
        return view3d.camera.unproject((mouseX - viewWidth) / viewWidth,(mouseY - viewHeight) / viewHeight,z); 
    }

}