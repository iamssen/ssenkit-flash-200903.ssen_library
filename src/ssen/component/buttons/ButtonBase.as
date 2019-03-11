package ssen.component.buttons 
{
	import ssen.component.buttons.IButton;
	import ssen.core.display.SSenSprite;
	import ssen.core.events.OnOffEvent;
	import ssen.core.skinObject.SkinMode;

	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;	

	/** @copy ssen.core.events.OnOffEvent#ONOFF */
	[Event(name="onoff", type="ssen.core.events.OnOffEvent")]

	/** 마우스 클릭 - 당연히 interactive object 의 모든 event 가 된다 */
	[Event(name="click", type="flash.events.MouseEvent")]
	/**
	 * Button 의 원시 구현
	 * @author SSen
	 */
	public class ButtonBase extends SSenSprite implements IButton 
	{
		protected var _enable : Boolean;
		protected var _width : Number;
		protected var _height : Number;
		protected var _buttonType : String;
		private var _skinMode : String;
		private var _toggleOn : Boolean;
		private var _mousePress : Boolean;

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
		/** @private */
		override public function get width() : Number
		{
			return _width;
		}
		override public function set width(width : Number) : void
		{
			_width = width;
		}
		/** @private */
		override public function get height() : Number
		{
			return _height;
		}
		override public function set height(height : Number) : void
		{
			_height = height;
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
