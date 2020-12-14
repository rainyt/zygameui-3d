package zygame.display3d;

import away3d.animators.SkeletonAnimator;
import away3d.entities.Mesh;
import away3d.containers.ObjectContainer3D;

/**
 * 创建一个新的ZObject3D对象。
 */
class ZObject3D extends ZSprite3D{

    public var object3d:ObjectContainer3D;
    
    public function new(object3d:ObjectContainer3D) {
        super();
        this.object3d = cast object3d.clone();
        this.addChild(this.object3d);
    }

    /**
     * 转换为Mesh对象
     * @return Mesh
     */
    public function getMesh(skip:Int = 0):Mesh
    {
        return _getChildByMesh(object3d,skip);
    }

    /**
     * 获取骨骼动画对象
     * @return SkeletonAnimator
     */
    public function getSkeletonAnimator():SkeletonAnimator
    {
        return cast getMesh().animator;
    }

    /**
     * 获取对象
     * @param name 
     * @return Dynamic
     */
    public function getChildByName(name:String):ObjectContainer3D{
        return _getChildByName(name,object3d);
    }

    private function _getChildByName(name:String,display:ObjectContainer3D):ObjectContainer3D{
        for (i in 0...display.numChildren) {
            var mesh = display.getChildAt(i);
            if(mesh.name == name)
                return mesh;
            else if(mesh.numChildren > 0){
                mesh = _getChildByName(name,mesh);
                if(mesh != null)
                    return mesh;
            }
        }
        return null;
    }

    private function _getChildByMesh(display:ObjectContainer3D,skip:Int):Mesh{
        for (i in 0...display.numChildren) {
            var mesh = display.getChildAt(i);
            if(Std.is(mesh,Mesh)){
                skip --;
                return skip < 0 ? cast mesh: null;
            }
            else if(mesh.numChildren > 0){
                mesh = _getChildByMesh(mesh,skip);
                if(mesh != null){
                    skip --;
                    return skip < 0 ? cast mesh : null;
                }
            }
        }
        return null;
    }


}