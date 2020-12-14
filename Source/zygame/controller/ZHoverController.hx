package zygame.controller;

import zygame.core.Refresher;
import openfl.events.Event;
import openfl.events.MouseEvent;
import zygame.core.Start;
import away3d.controllers.HoverController;

/**
 * 扩展悬挂镜头
 */
class ZHoverController extends HoverController implements Refresher {
	/**
	 * 启动鼠标拖动事件
	 */
	public function openMouseDragEvent():Void {
		Start.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		Start.current.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        Start.current.addToUpdate(this);
	}

    var _move:Bool;
	var _lastPanAngle:Float;
	var _lastTiltAngle:Float;
	var _lastMouseX:Float;
	var _lastMouseY:Float;

    /**
	 * Mouse down listener for navigation
	 */
	private function onMouseDown(event:MouseEvent):Void {
		_lastPanAngle = this.panAngle;
		_lastTiltAngle = this.tiltAngle;
		_lastMouseX = Start.current.stage.mouseX;
		_lastMouseY = Start.current.stage.mouseY;
		_move = true;
		Start.current.stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
	}

	/**
	 * Mouse up listener for navigation
	 */
	private function onMouseUp(event:MouseEvent):Void {
		_move = false;
		Start.current.stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
	}

    /**
	 * Mouse stage leave listener for navigation
	 */
	private function onStageMouseLeave(event:Event):Void {
		_move = false;
		Start.current.stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
	}

    /**
     * 更新摄像头
     */
    public function onFrame():Void
    {
        if (_move) {
			this.panAngle = 0.3 * (Start.current.stage.mouseX - _lastMouseX) + _lastPanAngle;
			this.tiltAngle = 0.3 * (Start.current.stage.mouseY - _lastMouseY) + _lastTiltAngle;
		}
    }

	/**
	 * 设置摄像头的距离，根据scale进行了优化
	 * @param val 
	 * @return Float
	 */
	override function set_distance(val:Float):Float {
		// val -= Start.currentScale * val - val;
		return super.set_distance(val);
	}
}
