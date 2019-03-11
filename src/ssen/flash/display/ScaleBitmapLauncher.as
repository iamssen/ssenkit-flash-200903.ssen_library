package ssen.flash.display 
{
	import ssen.core.display.SSenSprite;
	
	import org.bytearray.display.ScaleBitmap;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;	
	/**
	 * 매개변수의 정보를 토대로 ScaleBitmap 을 만들어줍니다.
	 * @author SSen
	 */
	public class ScaleBitmapLauncher extends SSenSprite	
	{
		private var _bitmapClassName : String;
		private var _rectX : Number;
		private var _rectY : Number;
		private var _rectWidth : Number;
		private var _rectHeight : Number;
		private var _pixelSnapping : String;
		private var _smoothing : Boolean;
		private var _parameterTotal : int;

		public function ScaleBitmapLauncher() 
		{
			_parameterTotal = 7;
		}
		private function getParameter(info :*= null) : void
		{
			_parameterTotal--;
			if (_parameterTotal <= 0) {
				launchScaleBitmap();
			}
		}
		private function launchScaleBitmap() : void
		{
			var bm : BitmapData = getBitmapDefinition(_bitmapClassName);
			var sb : ScaleBitmap = new ScaleBitmap(bm, _pixelSnapping, _smoothing);
			
			sb.name = name;
			sb.scale9Grid = new Rectangle(_rectX, _rectY, _rectWidth, _rectHeight);
			
			sb.x = x;
			sb.y = y;
			sb.z = z;
			sb.width = width;
			sb.height = height;
			sb.rotation = rotation;
			sb.rotationX = rotationX;
			sb.rotationY = rotationY;
			sb.rotationZ = rotationZ;
			
			parent.addChildAt(sb, parent.getChildIndex(this));
			parent.removeChild(this);
		}

		/** @private */
		[Inspectable(type="String", defaultValue="BitmapDataClassName", name="BitmapData Class Name")]
		public function set bitmapClassName(bitmapClassName : String) : void
		{
			_bitmapClassName = bitmapClassName;
			getParameter(bitmapClassName);
		}

		/** @private */
		[Inspectable(type="Number", defaultValue="0", name="Scale9Grid Rectangle X")]
		public function set rectX(rectX : Number) : void
		{
			_rectX = rectX;
			getParameter(rectX);
		}

		/** @private */
		[Inspectable(type="Number", defaultValue="0", name="Scale9Grid Rectangle Y")]
		public function set rectY(rectY : Number) : void
		{
			_rectY = rectY;
			getParameter(rectY);
		}

		/** @private */
		[Inspectable(type="Number", defaultValue="0", name="Scale9Grid Rectangle Width")]
		public function set rectWidth(rectWidth : Number) : void
		{
			_rectWidth = rectWidth;
			getParameter(rectWidth);
		}

		/** @private */
		[Inspectable(type="Number", defaultValue="0", name="Scale9Grid Rectangle Height")]
		public function set rectHeight(rectHeight : Number) : void
		{
			_rectHeight = rectHeight;
			getParameter(rectHeight);
		}

		/** @private */
		[Inspectable(type="String", defaultValue="auto", enumeration="auto, always, never", name="Bitmap Pixel Snapping")]
		public function set pixelSnapping(pixelSnapping : String) : void
		{
			_pixelSnapping = pixelSnapping;
			getParameter(pixelSnapping);
		}

		/** @private */
		[Inspectable(type="Boolean", defaultValue="false", name="Bitmap Smoothing")]
		public function set smoothing(smoothing : Boolean) : void
		{
			_smoothing = smoothing;
			getParameter(smoothing);
		}
	}
}
