package ssen.component.buttons 
{
	import ssen.component.buttons.IButton;
	import ssen.core.events.OnOffEvent;
	import ssen.core.skinObject.SkinMode;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;		

	/** @copy ssen.core.events.OnOffEvent#ONOFF */
	[Event(name="onoff", type="ssen.core.events.OnOffEvent")]

	/** 마우스 클릭 - 당연히 interactive object 의 모든 event 가 된다 */
	[Event(name="click", type="flash.events.MouseEvent")]
	/**
	 * MovieClip frame 상에서 Skin 작업을 할 수 있는 버튼
	 * @author SSen
	 */
	public class McButton extends MovieClip implements IButton 
	{
		private var _enable : Boolean;
		private var _buttonType : String;
		private var _skinMode : String;
		private var _toggleOn : Boolean;
		private var _mousePress : Boolean;
		// mc 전용
		private var _hitArea : Sprite;

		public function McButton()
		{
			stop();
			
			// frame6 를 hitArea 로 설정
			gotoAndStop(6);
			_hitArea = new Sprite();
			_hitArea.addChild(getChildAt(0));
			_hitArea.mouseEnabled = false;
			_hitArea.visible = false;
			addChild(_hitArea);
			hitArea = _hitArea;
			buttonMode = true;
			gotoAndStop(1);
			
			_buttonType = ButtonType.NORMAL;
			enable = true;
		}
		/** @copy ssen.component.base#enable */
		public function get enable() : Boolean
		{
			return _enable;
		}
		public function set enable(enable : Boolean) : void
		{
			if (enable) {
				tabEnabled = true;
				buttonMode = true;
				mouseEnabled = true;
				skinDefault();
				eventOn();
			} else {
				tabEnabled = false;
				buttonMode = false;
				mouseEnabled = false;
				skinDisabled();
				eventOff();
			}
			mouseChildren = false;
			_enable = enable;
		}
		/** @copy ssen.component.base#resourceKill() */
		public function resourceKill() : void
		{
			eventOff();
		}
		/** @copy ssen.component.buttons#toggleOn */
		public function get toggleOn() : Boolean
		{
			return _toggleOn;
		}
		public function set toggleOn(toggleOn : Boolean) : void
		{
			_toggleOn = toggleOn;
			skinDefault();
		}
		/** @copy ssen.component.buttons#buttonType */
		public function get buttonType() : String
		{
			return _buttonType;
		}
		public function set buttonType(buttonType : String) : void
		{
			_buttonType = buttonType;
			_toggleOn = false;
			if (_buttonType == ButtonType.TOGGLE) {
				addEventListener(MouseEvent.CLICK, mouseClick, false, 0, true);
			} else {
				removeEventListener(MouseEvent.CLICK, mouseClick);
			}
			skinning();
		}
		/** @copy ssen.component.buttons#isMousePress */
		public function get isMousePress() : Boolean
		{
			return _mousePress;
		}
		/* *********************************************************************
		 * Event 
		 ********************************************************************* */
		private function eventOn() : void
		{
			addEventListener(MouseEvent.MOUSE_OVER, mouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOut, false, 0, true);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown, false, 0, true);
			if (_buttonType == ButtonType.TOGGLE) addEventListener(MouseEvent.CLICK, mouseClick, false, 0, true);
			addEventListener(FocusEvent.FOCUS_IN, focusIn, false, 0, true);
			addEventListener(FocusEvent.FOCUS_OUT, focusOut, false, 0, true);
		}
		private function eventOff() : void
		{
			removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			if (_buttonType == ButtonType.TOGGLE) removeEventListener(MouseEvent.CLICK, mouseClick);
			removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
			if (stage.hasEventListener(MouseEvent.MOUSE_UP)) stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		private function focusOut(event : FocusEvent) : void
		{
			if (_enable) {
				skinDefault();
				removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				removeEventListener(KeyboardEvent.KEY_UP, keyUp);
			}
		}
		private function focusIn(event : FocusEvent) : void
		{
			if (_enable) {
				skinOver();
				addEventListener(KeyboardEvent.KEY_DOWN, keyDown, false, 0, true);
				addEventListener(KeyboardEvent.KEY_UP, keyUp, false, 0, true);
			}
		}
		private function keyUp(event : KeyboardEvent) : void
		{
			if (event.keyCode == 32 || event.keyCode == 13) {
				skinOver();
				dispatchEvent(new MouseEvent(MouseEvent.CLICK, true, false, 0, 0, null, event.ctrlKey, event.altKey, event.shiftKey));
			}
		}
		private function keyDown(event : KeyboardEvent) : void
		{
			if (event.keyCode == 32 || event.keyCode == 13) {
				skinDown();
			}
		}
		// 토글 클릭
		private function mouseClick(event : MouseEvent) : void
		{
			_toggleOn = (_toggleOn) ? false : true;
			dispatchEvent(new OnOffEvent(OnOffEvent.ONOFF, _toggleOn));
			if (_toggleOn) {
				skinDown();
			} else {
				skinOver();
			}
		}
		// 마우스 눌렀다 뗌
		private function mouseUp(event : MouseEvent) : void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			_mousePress = false;
			if (isPointerInRect(this, getRect(this))) {
				skinOver();
			} else {
				skinDefault();
			}
		}
		/**
		 * mousePointer 가 Rectangle 안에 위치하는지를 확인
		 * @param where 영역체크의 기준이 될 DisplayObject
		 * @param rect 영역체크에 사용될 Rectangle
		 */
		private function isPointerInRect(where : DisplayObject, rect : Rectangle) : Boolean
		{
			var sx : Number = where.mouseX;
			var sy : Number = where.mouseY;
			if (sx > rect.x && sx < rect.x + rect.width && sy > rect.y && sy < rect.y + rect.height) {
				return true;
			} else {
				return false;
			}
		}
		// 마우스 누름
		private function mouseDown(event : MouseEvent) : void
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp, false, 0, true);
			_mousePress = true;
			skinDown();
		}
		// 마우스 벗어남
		private function mouseOut(event : MouseEvent) : void
		{
			skinDefault();
		}
		// 마우스 오버
		private function mouseOver(event : MouseEvent) : void
		{
			if (_mousePress) {
				skinDown();
			} else {
				skinOver();
			}
		}
		/* *********************************************************************
		 * Skinning Methods
		 ********************************************************************* */
		// 스킨 #기본 상태
		private function skinDefault() : void
		{
			if (_toggleOn) {
				_skinMode = SkinMode.SELECTED;
			} else {
				_skinMode = SkinMode.DEFAULT;
			}
			skinning();
		}
		protected function skinning() : void
		{
			var frame : int;
			switch (_skinMode) {
				case SkinMode.DEFAULT :
					frame = 1;
					break;
				case SkinMode.SELECTED :
					frame = 5;
					break;
				case SkinMode.OVER :
					frame = 2;
					break;
				case SkinMode.ACTION :
					frame = 3;
					break;
				case SkinMode.DISABLE :
					frame = 4;
					break;
				default : 
					_skinMode = SkinMode.DEFAULT;
					frame = 1;
			}
			gotoAndStop(frame);
		}
		// 스킨 #비활성화 상태
		private function skinDisabled() : void
		{
			_skinMode = SkinMode.DISABLE;
			skinning();
		}
		// 스킨 #오버되어 있는 모습
		private function skinOver() : void
		{
			_skinMode = SkinMode.OVER;
			skinning();
		}
		// 스킨 #누르는 순간
		private function skinDown() : void
		{
			_skinMode = SkinMode.ACTION;
			skinning();
		}
		/** 현재의 skin mode */
		public function get skinMode() : String
		{
			return _skinMode;
		}
	}
}
