package ssen.core.display 
{
	import ssen.core.display.SSenSprite;
	
	import org.bytearray.display.ScaleBitmap;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.geom.Rectangle;	
	/**
	 * Flash 의 MovieClip 상에서 Single Frame 으로 된 ScaleBitmap 을 설정할 수 있음
	 * @author SSen
	 */
	public class McScaleBitmapSprite extends SSenSprite 
	{
		private var _scaleBitmap : ScaleBitmap;

		public function McScaleBitmapSprite()
		{
			var w : int = width;
			var h : int = height;
			
			var shape : DisplayObject = getChildAt(0);
			var grid : Rectangle = scale9Grid;
			var bmd : BitmapData = new BitmapData(shape.width, shape.height);
			bmd.draw(shape);
			
			_scaleBitmap = new ScaleBitmap(bmd);
			_scaleBitmap.scale9Grid = grid;
			_scaleBitmap.width = w;
			_scaleBitmap.height = h;
			
			removeChild(shape);
			addChild(_scaleBitmap);
			
			scaleX = 1;
			scaleY = 1;
		}
		/** scale9Grid */
		override public function set scale9Grid(grid : Rectangle) : void
		{
			scale9Grid = grid;
			_scaleBitmap.scale9Grid = grid;
		}
		/** @private */
		override public function set width(value : Number) : void
		{
			var w : int = value;
			_scaleBitmap.width = w;
			setBlank(width, height);
		}
		/** @private */
		override public function set height(value : Number) : void
		{
			var h : int = value;
			_scaleBitmap.height = h;
			setBlank(width, height);
		}
		/** int 형식의 Bitmap Size 의 공백을 메꾼다 */
		private function setBlank(width : Number, height : Number) : void
		{
			var g : Graphics = graphics;
			g.clear();
			var w : int = width;
			var h : int = height;
			if ((width - w) != 0 || (height - h) != 0) {
				g.beginFill(0xffffff, 0);
				g.drawRect(0, 0, width, height);
				g.endFill();
			}
		}
	}
}
