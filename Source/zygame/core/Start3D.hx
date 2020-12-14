package zygame.core;

import away3d.cameras.Camera3D;
import away3d.loaders.parsers.Parsers;
import away3d.containers.View3D;
import away3d.containers.Scene3D;
import away3d.loaders.misc.SingleFileLoader;

/**
 * 核心3D启动器，3D游戏相关逻辑在这里默认启动
 */
class Start3D extends Scene3D implements Refresher{

    public static var current:Start3D;

    public var view3d:View3D;

    public function new(view3d:View3D) {
        super();
        this.view3d = view3d;
        Start3D.current = this;
        Parsers.enableAllBundled();
        SingleFileLoader.enableParsers([zygame.loader.parser.SparticleParser.Away3DSprticleParser]);
    }

    public function onInit():Void
    {
        Start.current.addToUpdate(this);
    }

    public function onFrame():Void
    {

    }

}