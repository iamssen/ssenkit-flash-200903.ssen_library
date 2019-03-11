package ssen.core.skinObject 
{
	import ssen.core.display.SSenSprite;
	import ssen.core.geom.VerticalAlign;
	import ssen.core.graphics.FavoriteColorMatrix;
	import ssen.core.skinObject.ISkinObject;
	import ssen.core.skinObject.SkinMode;
	import ssen.core.skinObject.SkinSprite;
	import ssen.core.text.ITextObject;
	import ssen.core.text.RollText;
	import ssen.core.text.SSenTextField;
	import ssen.core.text.TextStyle;
	
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;	
	/**
	 * SkinObject : Thumbnail 과 TextField 로 구성된 Label, textStyle 를 사용해서 SkinMode 를 구성한다
	 * @author SSen
	 */
	public class SkinLabel extends SSenSprite implements ISkinObject, ITextObject 
	{
		private var _title : SSenTextField;
		private var _thumbnail : DisplayObject;
		private var _textStyles : Array;
		private var _thumbnailSkinOn : Boolean;
		private var _flag : String;
		private var _width : Number;
		private var _roll : Boolean;
		private var _rollTitle : RollText;

		public function SkinLabel(title : String, textStyles : Array, thumbnail : DisplayObject = null, thumbnailResize : Boolean = true)
		{
			_flag = SkinMode.DEFAULT; 
			_textStyles = textStyles;
			
			var txt : SSenTextField = new SSenTextField();
			_title = txt;
			_title.defaultTextFormat = _textStyles[_flag];
			_title.text = title;
			_title.autoReplaceOverText = true;
			_title.autoSizeWidth();
			_title.autoSizeHeight();
			
			setThumbnail(thumbnail, thumbnailResize);
			
			mouseChildren = false;
			addChild(_title);
		}
		/** 
		 * thumbnail 을 생성, 교체한다.
		 * @param thumbnail thumbnail 역활을 할 DisplayObject
		 * @param thumbnailResize thumbnail 을 리사이즈 할 것 인지의 여부
		 */
		public function setThumbnail(thumbnail : DisplayObject = null, thumbnailResize : Boolean = true) : void
		{
			removeThumbnail();
			
			if (thumbnail != null) {
				_thumbnail = thumbnail;
				if (_thumbnail is SkinSprite) _thumbnailSkinOn = true;
				addChild(_thumbnail);
			}
			
			if (_thumbnail != null) {
				if (thumbnailResize && _thumbnail.height > _title.height) {
					var d : Number = _title.height / _thumbnail.height;
					_thumbnail.width *= d;
					_thumbnail.height *= d;
				} else if (_thumbnail.height > _title.height) {
					_title.y = (_thumbnail.height >> 1) - (_title.height >> 1);
				} else {
					_thumbnail.y = (_title.height >> 1) - (_thumbnail.height >> 1);
				}
				addChild(_thumbnail);
				
				_title.x = _thumbnail.width + 4;
			} else {
				_title.x = 0;
			}
			
			align();
		}
		/** thumbnail 을 지운다 */
		public function removeThumbnail() : void
		{
			if (_thumbnail != null && contains(_thumbnail)) {
				removeChild(_thumbnail);
				_thumbnail = null;
				align();
			}
		}
		// 정렬
		private function align() : void
		{
			var obj : DisplayObject = (_roll) ? _rollTitle : _title;
			if (_width > 0) {
				var w : Number = _width;
				if (_thumbnail != null) w -= _thumbnail.width + 4;
				obj.width = w;
			} else {
				_width = obj.x + obj.width;
			}
		}
		/** @copy ssen.core.text.ITextObject#length */
		public function get length() : int
		{
			return _title.text.length;
		}
		/** @copy ssen.core.text.ITextObject#text */
		public function get text() : String
		{
			return _title.text;
		}
		public function set text(value : String) : void
		{
			_title.text = value;
		}
		/** @copy ssen.core.text.ITextObject#appendText() */
		public function appendText(newText : String) : void
		{
			_title.appendText(newText);
		}
		/** @copy ssen.core.text.ITextObject#replaceText() */
		public function replaceText(beginIndex : int, endIndex : int, newText : String) : void
		{
			_title.replaceText(beginIndex, endIndex, newText);
		}
		/** @private */
		override public function get width() : Number
		{
			return _width;
		}
		override public function set width(value : Number) : void
		{
			if (_roll && _title.fixWidth < value) {
				rollStop();
			}
			_width = value;
			align();
		}
		/** text 에 맞춰서 자동으로 폭을 맞춘다 */
		public function autoSizeWidth() : void
		{
			if (_roll) {
				rollStop();
			}
			_title.autoSizeWidth();
			_width = 0;
			align();
		}
		/** @copy ssen.core.skinObject#skinning() */
		public function skinning(modeName : String = SkinMode.DEFAULT) : void
		{
			var textStyle : TextStyle = _textStyles[modeName];
			_title.setTextFormat(textStyle);
			_title.defaultTextFormat = textStyle;
			
			if (_thumbnailSkinOn) {
				var skinsp : SkinSprite = _thumbnail as SkinSprite;
				skinsp.skinning(modeName);
			} else if (_thumbnail != null) {
				if (modeName == SkinMode.DISABLE) {
					_thumbnail.filters = [new ColorMatrixFilter(FavoriteColorMatrix.GRAY)];
				} else {
					_thumbnail.filters = null;
				}
			}
			_flag = modeName;
		}
		/** @copy ssen.core.skinObject#flag */
		public function get flag() : String
		{
			return _flag;
		}
		/** @copy ssen.core.skinObject#skinList */
		public function get skinList() : Array
		{
			var arr : Array = new Array();
			var name : String;
			for (name in _textStyles) {
				arr.push(name);
			}
			return arr;
		}
		/** label 의 textStyle 을 교체한다 */
		public function get textStyles() : Array
		{
			return _textStyles;
		}
		public function set textStyles(styles : Array) : void
		{
			_textStyles = styles;
			var textStyle : TextStyle = _textStyles[_flag];
			_title.defaultTextFormat = textStyle;
			_title.setTextFormat(textStyle);
		}
		public function rollStop(modeName : String = "default") : void
		{
			if (_roll) {
				_roll = false;
				_flag = modeName;
				var h : Number = _title.height;
				addChildTo(_title, _rollTitle);
				_title.height = h;
				_rollTitle = null;
				skinning(_flag);
			}
		}
		public function rollStart(modeName : String = "default") : void
		{
			if (!_roll && _title.fixWidth > _width) {
				_roll = true;
				var textStyle : TextStyle = _textStyles[modeName];
				_rollTitle = new RollText(_title.text, _title.width, _title.height, textStyle, null, VerticalAlign.TOP);
				var h : Number = _rollTitle.height;
				_flag = modeName;
				addChildTo(_rollTitle, _title);
				_rollTitle.height = h;
				_rollTitle.roll = true;
			}
		}
		public function get roll() : Boolean
		{
			return _roll;
		}
	}
}
