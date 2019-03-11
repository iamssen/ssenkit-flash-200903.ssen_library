package ssen.core.convert 
{
	import ssen.core.geom.Padding;
	import ssen.core.graphics.BitmapEx;
	import ssen.core.skinObject.SkinSprite;
	import ssen.core.text.SSenTextField;
	import ssen.core.text.TextStyle;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedSuperclassName;		
	/**
	 * dislay, graphics, skinObject 에 관련된 Object 들을 변환시키는 유틸들
	 * @author SSen
	 */
	public class GraphicsConverter 
	{
		/**
		 * bitmapData 혹은 displayObject 를 받아들여 displayObject 로 리턴해준다.
		 * @param obj bitmapData 또는 displayObject 여야 한다.
		 */
		public static function objectToDisplayObject(obj : Object) : DisplayObject
		{
			var bm : Bitmap;
			if (obj is DisplayObject) { 
				return obj as DisplayObject;
			} else if (obj is BitmapData) {
				bm = new Bitmap(obj as BitmapData);
				return bm;
			} else if (getQualifiedSuperclassName("flash.display::BitmapData")) {
				bm = new Bitmap(new obj(0, 0));
				return bm;
			} else if (obj is String) {
				var txt : SSenTextField = TextConverter.stringToTextField(String(obj));
				return txt;
			} else {
				throw new Error("GraphicsConverter.objectToDisplayObject 지원 타입 : DisplayObject, BitmapData, Class(BitmapData), String -> SSenTextField");
			}
		}
		/**
		 * object 가 bitmapData 이거나 Displayobject 둘 중 하나인지 확인
		 * @param obj 테스트할 객체
		 */
		public static function isDisplayObjectOrBitmapData(obj : Object) : Boolean
		{
			return obj != null && (obj is BitmapData || obj is DisplayObject);
		}
		/**
		 * bitmapData 를 SkinSprite 로 변환
		 * @param bitmapData 대상 bitmapData
		 * @param width 잘릴 영역의 width
		 * @param height 잘릴 영역의 height
		 * @param names SkinMode 의 이름들
		 * @param pixelSnapping Bitmap.pixelSnapping
		 * @param smoothing Bitmap.smoothing
		 */
		public static function bitmapDataToSkinSprite(bitmapData : BitmapData, width : int, height : int, names : Array, pixelSnapping : String = "auto", smoothing : Boolean = false) : SkinSprite
		{
			var skins : Array = new Array();
			var name : String;
			var bmd : BitmapData;
			var cnt : int = 0;
			for each (name in names) {
				bmd = BitmapEx.getSlice(bitmapData, width * cnt, 0, width, height);
				skins[name] = new Bitmap(bmd, pixelSnapping, smoothing);
				cnt++;
			}
			
			return new SkinSprite(skins);
		}
		/**
		 * 정보들을 가지고 Array.<TextStyle> 을 만든다
		 */
		public static function createSkinTextStyles(names : Array, colors : Array, embedFonts : Boolean = false, sharpness : Number = 0, thickness : Number = 0,
												font : String = "돋움", size : Object = 11, bold : Object = false, 
												italic : Object = false, underline : Object = false, url : String = null, target : String = null, align : String = null, leftMargin : Object = null, rightMargin : Object = null, indent : Object = null, leading : Object = null
												) : Array
		{
			var styles : Array = new Array();
			var style : TextStyle;
			var color : uint;
			var name : String;
			var f : int;
			for (f = 0;f < names.length; f++) {
				name = names[f];
				color = colors[f];
				style = new TextStyle(embedFonts, sharpness, thickness, font, size, color, bold, italic, underline, url, target, align, leftMargin, rightMargin, indent, leading);
				styles[name] = style;
			}
			return styles;
		}
		public static function textStyleToTextStyles(textStyle : TextStyle, colors : Array) : Array
		{
			var styles : Array = new Array();
			var style : TextStyle;
			var name : String;
			for (name in colors) {
				style = textStyle.clone();
				style.color = colors[name];
				styles[name] = style;
			}
			return styles;
		}
		/** bitmapData 에서 color 를 뽑아온다 */
		public static function getColor(bitmapData : BitmapData, x : int, y : int) : uint
		{
			return bitmapData.getPixel(x, y);
		}
		/** bitmapData 에서 Padding 을 뽑아온다 */
		public static function getPaddingFromBitmapData(bitmapData : BitmapData,x : int, y : int, width : int, height : int) : Padding
		{
			var center : int = width >> 1;
			
			var l : int;
			var r : int;
			var t : int;
			var b : int;
			
			var f : int;
			var color : uint = 0xffffff;
			for (f = 1;f <= height; f++) {
				if (bitmapData.getPixel(center + x, f + y) >= color) {
					t = f;
					break;
				}
			}
			for (f = height;f >= 1; f--) {
				if (bitmapData.getPixel(center + x, f + y) >= color) {
					b = height - f - 1;
					break;
				}
			}
			for (f = 1;f <= width; f++) {
				if (bitmapData.getPixel(f + x, t + y) >= color) {
					l = f;
					break;
				}
			}
			for (f = width;f >= 1; f--) {
				if (bitmapData.getPixel(f + x, t + y) >= color) {
					r = width - f - 1;
					break;
				}
			}
			
			return new Padding(t, r, b, l);
		}
		/** bitmapData 에서 scale9Grid 를 뽑아온다 */
		public static function getScale9GridFromBitmapData(bitmapData : BitmapData,x : int, y : int, width : int, height : int) : Rectangle
		{
			var center : int = width >> 1;
			
			var l : int;
			var r : int;
			var t : int;
			var b : int;
			
			var f : int;
			var color : uint = 0xffffff;
			for (f = 1;f <= height; f++) {
				if (bitmapData.getPixel(center + x, f + y) >= color) {
					t = f;
					break;
				}
			}
			for (f = height;f >= 1; f--) {
				if (bitmapData.getPixel(center + x, f + y) >= color) {
					b = height - f - 1;
					break;
				}
			}
			for (f = 1;f <= width; f++) {
				if (bitmapData.getPixel(f + x, t + y) >= color) {
					l = f;
					break;
				}
			}
			for (f = width;f >= 1; f--) {
				if (bitmapData.getPixel(f + x, t + y) >= color) {
					r = width - f - 1;
					break;
				}
			}
			
			return new Rectangle(l, t, width - l - r, height - t - b);
		}
	}
}
