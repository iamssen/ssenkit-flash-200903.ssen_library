package ssen.core.text 
{
	import ssen.core.display.SSenSprite;
	import ssen.core.geom.VerticalAlign;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;	
	/**
	 * Rolling text
	 * @author SSen
	 */
	public class RollText extends SSenSprite implements ITextObject
	{
		private var _width : int;
		private var _height : int;
		private var _text : String;
		private var _defaultTextStyle : TextStyle;
		private var _rollTextStyle : TextStyle;
		private var _bgColor : Boolean;
		private var _defaultBGColor : uint;
		private var _rollBGColor : uint;
		private var _modeOverRoll : Boolean;
		private var _speed : int;
		private var _roll : Boolean;
		private var _over : Boolean;
		private var _timer : Timer;
		private var _replaceText : String;
		private var _replaceWidth : int;
		private var _txt1 : SSenTextField;
		private var _txt2 : SSenTextField;
		private var _mask1 : Bitmap;
		private var _mask2 : Bitmap;
		private var _bmd : BitmapData;
		private var _verticalAlign : String;

		/**
		 * constructor
		 * @param text 글자
		 * @param width 가로 길이
		 * @param height 세로 길이
		 * @param defaultTextStyle 기본 TextStyle
		 * @param rollTextStyle 롤링시의 TextStyle
		 * @param bgColor 백그라운드 컬러를 사용할지 여부
		 * @param defaultBGColor 기본상태에서의 bgColor
		 * @param rollBGColor 롤링시의 bgColor
		 * @param speed 롤링스피드
		 * @param replaceText 기본상태에서의 축약문자
		 * @param replaceWidth 기본상태에서의 축약 사이즈
		 */
		public function RollText(text : String, width : int, height : int, defaultTextStyle : TextStyle, rollTextStyle : TextStyle = null, verticalAlign : String = "middle",modeOverRoll : Boolean = false, bgColor : Boolean = false, defaultBGColor : uint = 0xffffff, rollBGColor : uint = 0xffffff, speed : int = 20, replaceText : String = "...", replaceWidth : int = 15)
		{
			mouseChildren = false;
			
			_replaceText = replaceText;
			_replaceWidth = replaceWidth;
			
			_width = width;
			_height = height;
			_text = text;
			_defaultTextStyle = defaultTextStyle;
			_rollTextStyle = (rollTextStyle != null) ? rollTextStyle : defaultTextStyle;
			_bgColor = bgColor;
			_defaultBGColor = defaultBGColor;
			_rollBGColor = rollBGColor;
			_modeOverRoll = modeOverRoll;
			_speed = speed;
			_verticalAlign = verticalAlign;
			
			_txt1 = new SSenTextField();
			_txt1.text = _text;
			_txt1.setTextFormat(_defaultTextStyle);
			_txt1.autoSizeHeight();
			if (_txt1.fixHeight > _height) _height = _txt1.fixHeight;
			addChild(_txt1);
			
			init();
		}
		/** true 면 rolling 상태로 돌입하고, false 면 멈춘다 */
		public function get roll() : Boolean
		{
			return _roll;
		}
		public function set roll(roll : Boolean) : void
		{
			if (_over && _roll != roll) {
				_roll = roll;
				if (roll) {
					mode2();
				} else {
					mode1();
				}
			}
		}
		private function init() : void
		{
			_roll = false;
			if (_txt1.fixWidth <= _width) {
				_txt1.width = _width;
				verticalAlign(_txt1);
			} else {
				_over = true;
				mode1();
				
				if (_modeOverRoll) {
					addEventListener(MouseEvent.ROLL_OVER, rollOver, false, 0, true);
					addEventListener(MouseEvent.ROLL_OUT, rollOut, false, 0, true);
				}
			}
		}
		private function verticalAlign(txt : SSenTextField) : void
		{
			var y : int;
			switch (_verticalAlign) {
				case VerticalAlign.TOP :
					y = 0; 
					break;
				case VerticalAlign.BOTTOM :
					y = _height - txt.fixHeight;
					break;
				default :
					y = (_height >> 1) - (txt.fixHeight >> 1);
					break;
			}
			txt.y = y;
		}
		private function rollOut(event : MouseEvent) : void
		{
			roll = false;
		}
		private function rollOver(event : MouseEvent) : void
		{
			roll = true;
		}
		private function mode1() : void
		{
			_roll = false;
			
			removeMode2();
			
			_txt1.width = _width;
			_txt1.x = 0;
			_txt1.setTextFormat(_defaultTextStyle);
			_txt1.autoReplaceOverText = true;
			_txt1.autoSizeHeight();
			_txt1.mask = null;
			verticalAlign(_txt1);
			drawRect();
		}
		private function mode2() : void
		{
			_roll = true;
			_bmd = new BitmapData(_width, _height);
			_mask1 = new Bitmap(_bmd);
			_mask2 = new Bitmap(_bmd);
			addChild(_mask1);
			addChild(_mask2);
			
			_txt1.text = _text;
			_txt1.setTextFormat(_rollTextStyle);
			_txt1.autoReplaceOverText = false;
			_txt1.autoSizeWidth();
			_txt1.autoSizeHeight();
			_txt1.mask = _mask1;
			verticalAlign(_txt1);
			
			_txt2 = new SSenTextField();
			_txt2.defaultTextFormat = _rollTextStyle;
			_txt2.text = _text;			_txt2.text = _text;
			_txt2.setTextFormat(_rollTextStyle);
			_txt2.autoSizeHeight();
			_txt2.autoSizeWidth();
			_txt2.x = _txt1.x + _txt1.width + 10;
			_txt2.mask = _mask2;
			verticalAlign(_txt2);
			addChild(_txt2);
			
			drawRect(true);
			
			_timer = new Timer(_speed);
			_timer.addEventListener(TimerEvent.TIMER, timerHandle, false, 0, true);
			_timer.start();
			addEventListener(Event.REMOVED_FROM_STAGE, removeFromStage, false, 0, true);
		}
		private function removeMode2() : void
		{
			if (_txt2 != null && contains(_txt2)) {
				removeChild(_txt2);
				_txt2 = null;
			}
			
			if (_timer != null) {
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER, timerHandle);
				_timer = null;
			}
			
			if (_mask1 != null && contains(_mask1)) {
				removeChild(_mask1);
				removeChild(_mask2);
				_bmd.dispose();
				_bmd = null;
			}
			
			if (hasEventListener(Event.REMOVED_FROM_STAGE)) removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStage);
		}
		private function removeFromStage(event : Event) : void
		{
			mode1();
		}
		private function timerHandle(event : TimerEvent) : void
		{
			_txt1.x--;
			_txt2.x--;
			
			var x : int;
			if (_txt1.x + _txt1.width < 0) {
				x = _txt2.x + _txt2.width;
				_txt1.x = x;
			}
			if (_txt2.x + _txt2.width < 0) {
				x = _txt1.x + _txt1.width;
				_txt2.x = x;
			}
			
			event.updateAfterEvent();
		}
		private function drawRect(isRoll : Boolean = false) : void
		{
			var color : uint = (isRoll) ? _rollBGColor : _defaultBGColor;
			var alpha : Number = (_bgColor) ? 1 : 0;
			var g : Graphics = graphics;
			g.clear();
			g.beginFill(color, alpha);
			g.drawRect(0, 0, _width, _height);
			g.endFill();
		}
		public function appendText(newText : String) : void
		{
			_txt1.appendText(newText);
			_text = _txt1.text;
		}
		public function replaceText(beginIndex : int, endIndex : int, newText : String) : void
		{
			_txt1.replaceText(beginIndex, endIndex, newText);
			_text = _txt1.text;
		}
		public function get length() : int
		{
			return _text.length;
		}
		public function get text() : String
		{
			return _text;
		}
		public function set text(value : String) : void
		{
			_text = value;
			_txt1.text = _text;
			if (_txt2 != null) _txt2.text = _text;
			
			if (_roll) {
				mode2();
			} else {
				mode1();
			}
		}
		override public function get width() : Number
		{
			return _width;
		}
		override public function set width(value : Number) : void
		{
			if (_roll) {
				mode1();
				_roll = true;
			}
			_width = value;
			_txt1.width = value;
			if (_modeOverRoll) {
				if (_txt1.fixWidth > _width) {
					if (!hasEventListener(MouseEvent.ROLL_OVER)) addEventListener(MouseEvent.ROLL_OVER, rollOver, false, 0, true);
					if (!hasEventListener(MouseEvent.ROLL_OUT)) addEventListener(MouseEvent.ROLL_OUT, rollOut, false, 0, true);
				} else {
					if (hasEventListener(MouseEvent.ROLL_OVER)) removeEventListener(MouseEvent.ROLL_OVER, rollOver);
					if (hasEventListener(MouseEvent.ROLL_OUT)) removeEventListener(MouseEvent.ROLL_OUT, rollOut);
				}
			}
			if (_roll) {
				mode2();
			} else {
				mode1();
			}
		}
	}
}
