package ssen.core.display 
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;	
	/**
	 * Interactive 를 위해 패키징한 GridBitmap
	 * @author SSen
	 */
	public class GridSprite extends SSenSprite 
	{
		// gridBitmap
		private var _gridBitmap : GridBitmap;
		private var _width : Number;
		private var _height : Number;

		/**
		 * GridSprite
		 * @param gridBitmap 소스가 될 GridBitmap
		 */
		public function GridSprite(gridBitmap : GridBitmap)
		{
			_gridBitmap = gridBitmap;
			_width = _gridBitmap.width;
			_height = _gridBitmap.height;
			addChild(_gridBitmap);
		}
		/** 
		 * gridBitmap
		 * @see ssen.core.graphics.GridBitmap
		 */
		public function get gridBitmap() : GridBitmap
		{
			return _gridBitmap;
		}
		public function set gridBitmap(gridBitmap : GridBitmap) : void
		{
			removeChild(_gridBitmap);
			_gridBitmap = gridBitmap;
			_gridBitmap.width = _width;
			_gridBitmap.height = _height;
			addChild(_gridBitmap);
		}
		/** scale9Grid */
		override public function get scale9Grid() : Rectangle
		{
			return _gridBitmap.scale9Grid;
		}
		override public function set scale9Grid(grid : Rectangle) : void
		{
			_gridBitmap.scale9Grid = grid;
		}
		/** width */
		override public function get width() : Number
		{
			return _width;
		} 
		override public function set width(value : Number) : void
		{
			_width = value;
			setBlank();
			_gridBitmap.width = value;
		}
		/** height */
		override public function get height() : Number
		{
			return _height;
		}
		override public function set height(value : Number) : void
		{
			_height = value;
			setBlank();
			_gridBitmap.height = value;
		}
		/** int 형식의 Bitmap Size 의 공백을 메꾼다 */
		public function setBlank() : void
		{
			var g : Graphics = graphics;
			g.clear();
			var w : int = _width;
			var h : int = _height;
			if ((_width - w) != 0 || (_height - h) != 0) {
				g.beginFill(0xffffff, 0);
				g.drawRect(0, 0, _width, _height);
				g.endFill();
			}
		}
	}
}
