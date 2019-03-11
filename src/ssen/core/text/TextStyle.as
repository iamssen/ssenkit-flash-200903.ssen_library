package ssen.core.text 
{
	import flash.text.TextFormat;		
	/**
	 * TextStyle
	 * @author SSen
	 */
	public class TextStyle extends TextFormat 
	{
		private var _embedFonts : Boolean;
		private var _sharpness : Number;
		private var _thickness : Number;

		public function TextStyle(embedFonts : Boolean = false, sharpness : Number = 0, thickness : Number = 0, 
									font : String = "돋움", size : Object = 11, color : Object = -1, bold : Object = false, 
									italic : Object = false, underline : Object = false, url : String = null, target : String = null, align : String = null, leftMargin : Object = null, rightMargin : Object = null, indent : Object = null, leading : Object = null
									)
		{
			super(font, size, color, bold, italic, underline, url, target, align, leftMargin, rightMargin, indent, leading);
			_embedFonts = embedFonts;
			_sharpness = sharpness;
			_thickness = thickness;
		}
		/** clone */
		public function clone() : TextStyle
		{
			return new TextStyle(embedFonts, sharpness, thickness, font, size, color, bold, italic, underline, url, target, align, leftMargin, rightMargin, indent, leading);
		}
		/** embed font 사용여부 */
		public function get embedFonts() : Boolean
		{
			return _embedFonts;
		}
		public function set embedFonts(embedFont : Boolean) : void
		{
			_embedFonts = embedFont;
		}
		/** 텍스트 필드의 글리프 가장자리 선명도 -400 ~ 400 */
		public function get sharpness() : Number
		{
			return _sharpness;
		}
		public function set sharpness(sharpness : Number) : void
		{
			_sharpness = sharpness;
		}
		/** 텍스트 필드의 글리프 가장자리 두께 -200 ~ 200 */
		public function get thickness() : Number
		{
			return _thickness;
		}
		public function set thickness(thickness : Number) : void
		{
			_thickness = thickness;
		}
	}
}
