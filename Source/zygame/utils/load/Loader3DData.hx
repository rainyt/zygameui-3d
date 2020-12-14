package zygame.utils.load;

import away3d.animators.SkeletonAnimator;
import away3d.materials.lightpickers.StaticLightPicker;
import away3d.materials.SinglePassMaterialBase;
import away3d.animators.data.Skeleton;
import away3d.entities.Mesh;
import away3d.animators.SkeletonAnimationSet;
import away3d.animators.nodes.SkeletonClipNode;
import away3d.library.assets.Asset3DType;
import away3d.library.assets.IAsset;
import away3d.events.Asset3DEvent;
import openfl.net.URLRequest;
import away3d.loaders.misc.AssetLoaderContext;
import away3d.loaders.parsers.ParserBase;
import away3d.loaders.misc.AssetLoaderToken;
import away3d.events.LoaderEvent;
import away3d.loaders.Loader3D;

/**
 * 加载3D资源统一入口
 */
class Loader3DData {

	private var path:String = "";

	public function new(path) {
		this.path = path;
	}

	public function load(call:ZLoader3D->Void, errorCall:String->Void) {
		var loader:ZLoader3D = new ZLoader3D();
		loader.addEventListener(LoaderEvent.RESOURCE_COMPLETE, (event) -> {
			call(loader);
		});
		loader.addEventListener(LoaderEvent.LOAD_ERROR, (event) -> {
			errorCall("无法加载" + path);
		});
        loader.load(new URLRequest(path));
	}
}

/**
 * 3D载入器
 */
class ZLoader3D extends Loader3D {

    public var path:String = null;

    public var nodes:Map<String,SkeletonClipNode> = [];
    
    public var meshs:Map<String,Mesh> = [];

    public var skeleton:Map<String,Skeleton> = [];

    public var animationSets:Map<String,SkeletonAnimationSet> = [];

    public var materials:Map<String,SinglePassMaterialBase> = [];

	override function load(req:URLRequest, ?context:AssetLoaderContext = null, ?ns:String = null, ?parser:ParserBase = null):AssetLoaderToken {
		path = req.url;
        this.addEventListener(Asset3DEvent.ASSET_COMPLETE, onAssets3DEvent);
		return super.load(req, context, ns, parser);
	}

	private function onAssets3DEvent(event:Asset3DEvent):Void {
        var asset:IAsset = event.asset;
        trace("3D asset",path,asset,asset.assetType,asset.name,asset.assetNamespace);
		if (asset == null)
			return;
        var name:String = event.asset.assetNamespace;
        if(name != null && (asset.name == null || asset.name == "null"))
            asset.name = name;
		switch (asset.assetType) {
			case Asset3DType.ANIMATOR:
				trace("get a animator!");
			case Asset3DType.ANIMATION_NODE:
				var node:SkeletonClipNode = cast(event.asset, SkeletonClipNode);
                //如果是MD5动画文件，则以默认文件为识别名
                if(node.name == "default" && path.indexOf(".md5anim") != -1){
                    var actionName = StringUtils.getName(path);
                    node.name = actionName.indexOf("_") != -1?actionName.split("_")[1]:actionName;
                }
                nodes.set(node.name,node);
			case Asset3DType.SKELETON:
                //不支持载入
                skeleton.set(asset.name,cast asset);
			case Asset3DType.ANIMATION_SET:
				var animationSet:SkeletonAnimationSet = cast asset;
                animationSets.set(animationSet.name,animationSet);
				// loader.loadData(Assets.getBytes("assets/cat.md5anim"), null, "cat2", new MD5AnimParser());
			case Asset3DType.MESH:
                var mesh:Mesh = cast asset;
				meshs.set(mesh.name,mesh);
			case Asset3DType.MATERIAL:
				var material:SinglePassMaterialBase = cast(asset, SinglePassMaterialBase);
                materials.set(material.name,material);
                // 测试
                // material.addMethod(new away3d.materials.methods.OutlineMethod(0x0,2));
		}
	}

    /**
     * 根据ID获取Mesh对象
     * @param id 
     * @return Mesh
     */
    public function getMesh(id:String = "default"):Mesh
    {
        if(id == "default"){
            return meshs.iterator().next();
        }
        return meshs.get(id);
    }

    /**
     * 获取骨骼影片对象
     * @param id 
     * @return SkeletonClipNode
     */
    public function getSkeletonClipNode(id:String = "default"):SkeletonClipNode
    {
        return nodes.get(id);
    }

    public function getSkeletonAnimationSet(id:String = "default"):SkeletonAnimationSet
    {
        return animationSets.get(id);
    }

    public function getSkeleton(id:String = "default"):Skeleton
    {
        return skeleton.get(id);
    }

    /**
     * 应用所有物料的光线源
     * @param picker 
     */
    public function applyAllMaterialsLight(picker:StaticLightPicker,ambientColor:UInt = 0xffffff):Void
    {
        for (key => value in materials) {
            value.ambientColor = ambientColor;
            value.lightPicker = picker;
        }
    }

    /**
     * 获取材料
     * @param id 
     * @return SinglePassMaterialBase
     */
    public function getMaterials(id:String):SinglePassMaterialBase
    {
        return materials.get(id);
    }   

    /**
     * 追加加载的资源
     * @param loader 
     */
    public function pushZLoader3D(loader:ZLoader3D):Void
    {
        @:privateAccess for (key => value in loader.animationSets) {
            this.animationSets.set(key,value);
        }
        @:privateAccess for (key => value in loader.materials) {
            this.materials.set(key,value);
        }
        @:privateAccess for (key => value in loader.meshs) {
            this.meshs.set(key,value);
        }
        @:privateAccess for (key => value in loader.nodes) {
            this.nodes.set(key,value);
            //默认将node追加到动画中
            if(this.getSkeletonAnimationSet() != null)
                this.getSkeletonAnimationSet().addAnimation(value);
        }
        loader.dispose();
    }

    public function getSkeletonAnimator(animationSetId:String = "default",skeletonId:String = "default"):SkeletonAnimator
    {
        trace("???",skeleton,animationSets);
        return new SkeletonAnimator(this.getSkeletonAnimationSet(),this.getSkeleton());
    }
}
