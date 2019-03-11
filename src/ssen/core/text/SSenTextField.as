package ssen.core.text 
{
	import ssen.core.text.TextFieldEx;
	import ssen.core.text.TextStyle;
	
	import flash.text.TextField;
	import flash.text.TextFormat;	
	/**
	 * SSen Textfield
	 * @author SSen
	 */
	public class SSenTextField extends TextField implements ITextObject
	{
		private var _autoReplaceOverText : Boolean;
		private var _text : String;
		private var _fixWidth : Number;
		private var _fixHeight : Number;
		private var _htmlMode : Boolean;

		public function SSenTextField()
		{	
		}
		/** text 에 맞춰서 자동으로 폭을 맞춘다 */
		public function autoSizeWidth() : void
		{
			if (!multiline) {
				width = fixWidth;
			} else {
				trace("SSEN//", "singleline 에서만 작동합니다");
			}
		}
		/** text 에 맞춰서 자동으로 높이를 맞춘다 */
		public function autoSizeHeight() : void
		{
			if (!multiline) {
				height = fixHeight;
			} else {
				trace("SSEN//", "singleline 에서만 작동합니다");
			}
		}
		/** text 에 맞춰진 고정 폭 */
		public function get fixWidth() : Number
		{
			return (_autoReplaceOverText) ? _fixWidth : textWidth + 4;
		}
		/** text 에 맞춰진 고정 높이 */
		public function get fixHeight() : Number
		{
			return (_autoReplaceOverText) ? _fixHeight : textHeight + 4;
		}
		/** @private */
		override public function get text() : String
		{
			if (!_autoReplaceOverText) {
				return super.text;
			} else if (!_htmlMode) {
				return _text;
			} else {
				var str : String;
				autoReplaceOverText = false;
				str = super.text;
				autoReplaceOverText = true;
				return str;
			}
		} 
		override public function set text(text : String) : void
		{
			_htmlMode = false;
			
			_text = text;
			super.text = _text;
			_fixWidth = textWidth + 4;
			_fixHeight = textHeight + 4;
			if (_autoReplaceOverText) {
				replaceOverText();
			}
		}
		/** @private */
		override public function get htmlText() : String
		{
			if (!_autoReplaceOverText) {
				return super.htmlText;
			} else {
				var str : String;
				autoReplaceOverText = false;
				str = super.htmlText;
				autoReplaceOverText = true;
				return str;
			}
		} 
		override public function set htmlText(htmlText : String) : void
		{
			_htmlMode = true;
			
			_text = htmlText;
			super.htmlText = _text;
			_fixWidth = textWidth + 4;
			_fixHeight = textHeight + 4;
			if (_autoReplaceOverText) {
				replaceOverText();
			}
		}
		/** @private */
		override public function set width(value : Number) : void
		{
			super.width = value;
			writeText();
			_fixWidth = textWidth + 4;
			if (_autoReplaceOverText) {
				replaceOverText();
			}
		}
		/** @private */
		override public function set height(value : Number) : void
		{
			super.height = value;
			writeText();
			_fixHeight = textHeight + 4;
			if (_autoReplaceOverText) {
				replaceOverText();
			}
		}
		/** 사이즈에 따라 자동으로 OverText 를 줄임처리 한다 */
		public function get autoReplaceOverText() : Boolean
		{
			return _autoReplaceOverText;
		}
		public function set autoReplaceOverText(autoReplaceOverText : Boolean) : void
		{
			if (autoReplaceOverText) {
				if (_autoReplaceOverText) {
					_fixWidth = textWidth + 4;
					_fixHeight = textHeight + 4;
				}
				replaceOverText();
			} else {
				writeText();
			}
			_autoReplaceOverText = autoReplaceOverText;
		}
		private function replaceOverText() : void
		{
			TextFieldEx.replaceOverText(this);
		}
		/** @private */
		public override function setTextFormat(format : TextFormat, beginIndex : int = -1, endIndex : int = -1) : void
		{
			if (format is TextStyle) {
				var style : TextStyle = format as TextStyle;
				if (style.color == null || style.color < 0) style.color = 0x000000;
				setFontRenderingStyle(style.embedFonts, style.sharpness, style.thickness);
				super.setTextFormat(style, beginIndex, endIndex);
			} else {
				super.setTextFormat(format, beginIndex, endIndex);
			}
		}
		/** @private */
		public override function set defaultTextFormat(format : TextFormat) : void
		{
			if (format is TextStyle) {
				var style : TextStyle = format as TextStyle;
				if (style.color == null || style.color < 0) style.color = 0x000000;
				setFontRenderingStyle(style.embedFonts, style.sharpness, style.thickness);
				super.defaultTextFormat = style;
			} else {
				super.defaultTextFormat = format;
			}
		}
		/** border 와 background 를 설정한다 */
		public function setBoxStyle(border : Boolean = false, borderColor : uint = 0x000000, background : Boolean = false, backgroundColor : uint = 0xffffff) : void
		{
			this.border = border;
			this.borderColor = borderColor;
			this.background = background;
			this.backgroundColor = backgroundColor;
		}
		/** font 의 렌더링에 영향을 미치는 부분을 설정한다 */
		public function setFontRenderingStyle(embedFonts : Boolean = false, sharpness : Number = 0, thickness : Number = 0) : void
		{
			this.embedFonts = embedFonts;
			this.sharpness = sharpness;
			this.thickness = thickness;
		}
		private function writeText() : void
		{
			if (!_htmlMode) {
				super.text = _text;
			} else {
				super.htmlText = _text;
			}
		}
	}
}