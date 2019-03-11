package ssen.component.panels 
{
	import ssen.component.panels.IPanelObject;
	import ssen.core.array.Values;
	import ssen.core.display.SSenSprite;

	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;	
	/**
	 * PanelObject 의 원시구현
	 * @author SSen
	 */
	public class PanelObjectBase extends SSenSprite implements IPanelObject 
	{
		private var _enable : Boolean;
		private var _closeCallback : Function;
		private var _okCallback : Function;
		private var _cancelCallback : Function;
		private var _completeCallback : Function;
		private var _panelMode : String;
		private var _options : Object;
		private var _moveStartX : int;
		private var _moveStartY : int;
		private var _moveStartMouseX : int;
		private var _moveStartMouseY : int;
		private var _moveObjects : Vector.<InteractiveObject>;
		private var _cancelBtns : Vector.<InteractiveObject>;
		private var _okBtns : Vector.<InteractiveObject>;

		public function PanelObjectBase()
		{
			_enable = true;
			tabEnabled = false;
		}
		/** @copy ssen.component.base.ISSenComponent#enable */
		public function get enable() : Boolean
		{
			return false;
		}
		public function set enable(enable : Boolean) : void
		{
			if (enable) {
				mouseEnabled = true;
				mouseChildren = true;
			} else {
				mouseEnabled = false;
				mouseChildren = false;
			}
			_enable = enable;
		}
		/** @copy ssen.component.panels.IPanelObject#initialize() */
		public function initialize() : void
		{
		}
		/** @copy ssen.component.panels.IPanelObject#topIndex() */
		public function topIndex() : void
		{
			index = stage.numChildren - 1;
		}
		/** @copy ssen.component.panels.IPanelObject#resourceKill() */
		public function resourceKill() : void
		{
			_closeCallback = null;
			_okCallback = null;
			_cancelCallback = null;
			_completeCallback = null;
			if (_moveObjects != null) unsetMouseMove();
			if (_cancelBtns != null) unsetCancel();
			if (_okBtns != null) unsetOk();
			_moveObjects = null;
			_cancelBtns = null;
			_okBtns = null;
		}
		/** @copy ssen.component.panels.IPanelObject#okCallback */
		public function get okCallback() : Function
		{
			return _okCallback;
		}
		public function set okCallback(okCallback : Function) : void
		{
			_okCallback = okCallback;
		}
		/** @copy ssen.component.panels.IPanelObject#cancelCallback */
		public function get cancelCallback() : Function
		{
			return _cancelCallback;
		}
		public function set cancelCallback(cancelCallback : Function) : void
		{
			_cancelCallback = cancelCallback;
		}
		/** @copy ssen.component.panels.IPanelObject#panelMode */
		public function get panelMode() : String
		{
			return _panelMode;
		}
		public function set panelMode(panelMode : String) : void
		{
			_panelMode = panelMode;
		}
		/** @copy ssen.component.panels.IPanelObject#content */
		public function get options() : Object
		{
			return _options;
		}
		public function set options(options : Object) : void
		{
			_options = options;
		}
		/** prompt mode 시에 ok 를 클릭했을때 데이터를 수집한다 */
		protected function getPromptData() : Values
		{
			return null;
		}
		/** panel move 를 걸 Object들을 입력한다 */
		protected function setMoveObjects(...objs) : void
		{
			if (_moveObjects != null) unsetMouseMove();
			_moveObjects = new Vector.<InteractiveObject>();
			
			var obj : InteractiveObject;
			for each (obj in objs) {
				_moveObjects.push(obj);
			}
			
			setMouseMove();
		}
		/** cancel 을 걸 Object 들을 입력한다 */
		protected function setCancelButtons(...btns) : void
		{
			if (_cancelBtns != null) unsetCancel();
			_cancelBtns = new Vector.<InteractiveObject>();
			
			var obj : InteractiveObject;
			for each (obj in btns) {
				_cancelBtns.push(obj);
			}
			
			setCancel();
		}
		/** ok 를 걸 Object 들을 입력한다 */
		protected function setOkButtons(...btns) : void
		{
			if (_okBtns != null) unsetOk();
			_okBtns = new Vector.<InteractiveObject>();
			
			var obj : InteractiveObject;
			for each (obj in btns) {
				_okBtns.push(obj);
			}
			
			setOk();
		}
		private function moveStart() : void
		{
			unsetMouseMove();
			
			_moveStartX = x;
			_moveStartY = y;
			_moveStartMouseX = stage.mouseX;
			_moveStartMouseY = stage.mouseY;
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp, false, 0, true);
		}
		private function mouseMove(event : MouseEvent) : void
		{
			var ox : int = _moveStartX + (stage.mouseX - _moveStartMouseX);
			var oy : int = _moveStartY + (stage.mouseY - _moveStartMouseY);
			var xmode : int;
			var ymode : int;
			
			if (ox < 0) {
				ox = 0;
				xmode = 1;
			} else if (ox > stage.stageWidth - width) {
				ox = stage.stageWidth - width;
				xmode = 2;
			}
			if (oy < 0) {
				oy = 0;
				ymode = 1;
			} else if (oy > stage.stageHeight - height) {
				oy = stage.stageHeight - height;
				ymode = 2;
			}
			x = ox;
			y = oy;
			
			event.updateAfterEvent();
		}
		private function moveStop() : void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			setMouseMove();
		}
		private function mouseUp(event : MouseEvent) : void
		{
			moveStop();
		}
		private function mouseDown(event : MouseEvent) : void
		{
			moveStart();
		}
		private function setMouseMove() : void
		{
			var obj : InteractiveObject;
			var f : int;
			for (f = 0;f < _moveObjects.length; f++) {
				obj = _moveObjects[f];
				if (!obj.hasEventListener(MouseEvent.MOUSE_DOWN)) obj.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown, false, 0, true);
			}
		}
		private function unsetMouseMove() : void
		{
			var obj : InteractiveObject;
			var f : int;
			for (f = 0;f < _moveObjects.length; f++) {
				obj = _moveObjects[f];
				if (obj.hasEventListener(MouseEvent.MOUSE_DOWN)) obj.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			}
		}
		private function setCancel() : void
		{
			var obj : InteractiveObject;
			var f : int;
			for (f = 0;f < _cancelBtns.length; f++) {
				obj = _cancelBtns[f];
				if (!obj.hasEventListener(MouseEvent.CLICK)) obj.addEventListener(MouseEvent.CLICK, cancelClick, false, 0, true);
			}
		}
		private function unsetCancel() : void
		{
			var obj : InteractiveObject;
			var f : int;
			for (f = 0;f < _cancelBtns.length; f++) {
				obj = _cancelBtns[f];
				if (obj.hasEventListener(MouseEvent.CLICK)) obj.removeEventListener(MouseEvent.CLICK, cancelClick);
			}
		}
		private function cancelClick(event : MouseEvent) : void
		{
			_cancelCallback();
		}
		private function setOk() : void
		{
			var obj : InteractiveObject;
			var f : int;
			for (f = 0;f < _okBtns.length; f++) {
				obj = _okBtns[f];
				if (!obj.hasEventListener(MouseEvent.CLICK)) obj.addEventListener(MouseEvent.CLICK, okClick, false, 0, true);
			}
		}
		private function unsetOk() : void
		{
			var obj : InteractiveObject;
			var f : int;
			for (f = 0;f < _okBtns.length; f++) {
				obj = _okBtns[f];
				if (obj.hasEventListener(MouseEvent.CLICK)) obj.removeEventListener(MouseEvent.CLICK, okClick);
			}
		}
		private function okClick(event : MouseEvent) : void
		{
			if (panelMode == PanelMode.PROMPT) {
				_okCallback(getPromptData());
			} else {
				_okCallback();
			}
		}
	}
}
