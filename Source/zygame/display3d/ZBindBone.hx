package zygame.display3d;

import zygame.core.Refresher;
import away3d.animators.data.JointPose;
import away3d.animators.SkeletonAnimator;
import away3d.animators.data.Skeleton;
import away3d.containers.ObjectContainer3D;

/**
 * 绑定骨骼支持
 */
class ZBindBone extends ObjectContainer3D implements Refresher {
	private var _skeletonAnimator:SkeletonAnimator;
	private var _skeletonIndex:Int;

	/**
	 * 指定绑定的骨骼，以及骨骼索引，用于同步骨骼数据
	 * @param skeleton 骨骼
	 * @param skeletonIndex 骨骼索引
	 */
	public function new(skeleton:SkeletonAnimator, skeletonBoneName:String = "") {
		super();
		_skeletonAnimator = skeleton;
		_skeletonIndex = skeleton.skeleton.jointIndexFromName(skeletonBoneName);
		@:privateAccess for (mesh in _skeletonAnimator._owners) {
			mesh.addChild(this);
		}
		// @:privateAccess skeleton._owners[_skeletonIndex].addChild(this);
	}

	public function onFrame():Void {
		this.invalidateTransform();
	}

	override private function updateSceneTransform():Void {
		if (this.parent != null) {
			var jointPoses:openfl.Vector<JointPose> = _skeletonAnimator.globalPose.jointPoses;
			if (jointPoses != null && jointPoses.length > 0) {
				// 取到骨骼数据并同步给当前对象
				_sceneTransform.copyFrom(jointPoses[_skeletonIndex].toMatrix3D());
				_sceneTransform.append(_parent.sceneTransform);
				_sceneTransform.prepend(transform);
			}
		}
		_sceneTransformDirty = false;
	}
}
