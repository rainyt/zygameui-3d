package zygame.display3d;

import zygame.core.Start;
import zygame.core.Refresher;
import away3d.containers.ObjectContainer3D;

/**
 * 通常的3D容器对象
 */
class ZSprite3D extends ObjectContainer3D implements Refresher{

    public function setFrameEvent(bool:Bool):Void
    {
        if(bool)
            Start.current.addToUpdate(this);
        else
            Start.current.removeToUpdate(this);
    }

    public function onFrame():Void
    {

    }

}