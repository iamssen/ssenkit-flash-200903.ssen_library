package ssen.component.buttons 
{
	import ssen.component.buttons.ButtonBase;
	import ssen.core.convert.GraphicsConverter;
	import ssen.core.geom.Padding;
	import ssen.core.geom.Position9;
	import ssen.core.skinObject.ISkinObject;
	import ssen.core.skinObject.SkinLabel;
	import ssen.core.text.TextStyle;

	import flash.display.DisplayObject;		
	/**
	 * @author SSen
	 */
	public class LabelButton extends ButtonBase
	{
		// position9 내부 컨텐츠의 정렬
		private var _contentPosition9 : String;
		// 자동 사이즈 관련
		private var _autoWidth : Boolean;
		private var _autoHeight : Boolean;
		// 모양새들
		private var _content : ISkinObject;
		private var _bg : ISkinObject;
		private var _textStyle : TextStyle;
		private var _padding : Padding;
		private var _fontColors : Array;

		public function LabelButton(skin : ILabelButtonSkin, title : String, 
									textStyle : TextStyle, thumbnail : DisplayObject = null, 
									thumbnailResize : Boolean = true, buttonType : String = "normal")
		{
			// skin 추출
			_padding = skin.button_innerGrid;
			_fontColors = skin.button_fontColors;
			_textStyle = textStyle;
			// object setting
			_content = new SkinLabel(title, GraphicsConverter.textStyleToTextStyles(textStyle, _fontColors), thumbnail, thumbnailResize);
			_bg = skin.button_bg();
			_width = _content.width + _padding.left + _padding.right;
			_height = _content.height + _padding.top + _padding.bottom;
			_bg.width = _width;
			_bg.height = _height;
			// setting
			_buttonType = buttonType;
			_autoWidth = false;
			_autoHeight = false;
			_contentPosition9 = Position9.MC;
			
			addChildren(_bg, _content);
			align();
			enable = true;
		}
		/* *********************************************************************
		 * Interface Properties and Methods 
		 ********************************************************************* */
		/** Skin 을 교체한다 */
		public function set skin(skin : ILabelButtonSkin) : void
		{
			var bg : ISkinObject = skin.button_bg();
			addChildTo(DisplayObject(bg), DisplayObject(_bg));
			_bg = bg;
			_padding = skin.button_innerGrid;
			_fontColors = skin.button_fontColors;
			if (_content is SkinLabel) SkinLabel(_content).textStyles = GraphicsConverter.textStyleToTextStyles(_textStyle, skin.button_fontColors);
			skinning();
		}
		public function get padding() : Padding
		{
			return _padding.clone();
		}
		public function set padding(padding : Padding) : void
		{
			_padding = padding;
			align();
		}
		public function get textStyle() : TextStyle
		{
			return _textStyle;
		}
		public function set textStyle(textStyle : TextStyle) : void
		{
			_textStyle = textStyle;
			if (_content is SkinLabel) SkinLabel(_content).textStyles = GraphicsConverter.textStyleToTextStyles(_textStyle, _fontColors);
			skinning();
			align();
		}
		public function set options(content : ISkinObject) : void
		{
			addChildTo(DisplayObject(content), DisplayObject(_content));
			_content = content;
			_width = _content.width + _padding.left + _padding.right;
			_height = _content.height + _padding.top + _padding.bottom;
			skinning();
			align();
		}
		public function setContent(title : String, textStyle : TextStyle, thumbnail : DisplayObject = null, thumbnailResize : Boolean = true) : void
		{
			var c : ISkinObject = new SkinLabel(title, GraphicsConverter.textStyleToTextStyles(textStyle, _fontColors), thumbnail, thumbnailResize);
			options = c;
		}
		/** 가로 사이즈 자동 맞추기 */
		public function get autoWidth() : Boolean
		{
			return _autoWidth;
		}
		public function set autoWidth(bool : Boolean) : void
		{
			_autoWidth = bool;
			align();
		}
		/** 높이 자동 맞추기 */
		public function get autoHeight() : Boolean
		{
			return _autoHeight;
		}
		public function set autoHeight(bool : Boolean) : void
		{
			_autoHeight = bool;
			align();
		}
		/** content position #lance.core.geom.Position9 constants TL, ML, BL... */
		public function get contentPosition9() : String
		{
			return _contentPosition9;
		}
		public function set contentPosition9(contentPosition9 : String) : void
		{
			_contentPosition9 = contentPosition9;
			align();
		}
		/** @private */
		override public function set width(value : Number) : void
		{
			super.width = value;
			align();
		}
		/** @private */
		override public function set height(value : Number) : void
		{
			super.height = value;
			align();
		}
		override public function resourceKill() : void
		{
			super.resourceKill();
			if (_content != null) removeChild(DisplayObject(_content));
			removeChild(DisplayObject(_bg));
		}		
		/** @private */
		override protected function skinning() : void
		{
			_bg.skinning(skinMode);
			if (_content != null) _content.skinning(skinMode);
		}
		/* *********************************************************************
		 * Private Util functions
		 ********************************************************************* */
		// 정렬한다
		private function align() : void
		{
			if (_content != null) {
				// grid bitmap size
				var minWidth : Number = _content.width + _padding.left + _padding.right;
				var minHeight : Number = _content.height + _padding.top + _padding.bottom;
				
				if (_autoWidth || _width < minWidth) {
					_bg.width = minWidth;
					_width = minWidth;
				} else {
					_bg.width = _width;
				}
				if (_autoHeight || _height < minHeight) {
					_bg.height = minHeight;
					_height = minHeight;
				} else {
					_bg.height = _height;
				}
				
				// align txt and thumb
				var w : Number = _content.width;
				var h : Number = _content.height;
				var x : int;
				var y : int;
				switch (_contentPosition9) {
					case Position9.TL :
					case Position9.TC :
					case Position9.TR :
						y = _padding.top;
						break;
					case Position9.ML : 
					case Position9.MC :
					case Position9.MR : 
						y = (_bg.height >> 1) - (h >> 1);
						break;
					case Position9.BL :
					case Position9.BC : 
					case Position9.BR : 
						y = _bg.height - h - _padding.bottom;
						break;
				}
				switch (_contentPosition9) {
					case Position9.TL :
					case Position9.ML :
					case Position9.BL :
						x = _padding.left;
						break;
					case Position9.TC :
					case Position9.MC :
					case Position9.BC :
						x = (_bg.width >> 1) - (w >> 1);
						break;
					case Position9.TR :
					case Position9.MR :
					case Position9.BR :
						x = _bg.width - w - _padding.right;
						break;
				}
				_content.x = x;
				_content.y = y;
			} else {
				_bg.width = _width;
				_bg.height = _height;
			}
		}
	}
}
