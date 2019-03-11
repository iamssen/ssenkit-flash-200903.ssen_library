package ssen.core.graphics 
{
	import ssen.core.number.MathEx;	

	import flash.geom.Matrix;	
	import flash.geom.Point;	
	import flash.geom.Rectangle;	
	import flash.display.BitmapData;	
	/**
	 * Description
	 * @author SSen
	 */
	public class BitmapEx 
	{
		/**
		 * bitmapData 를 scale9Grid 에 맞춰서 리사이징한 후에 반환한다 
		 * @param source 오리지널 BitmapData
		 * @param scale9Grid Scale9Grid
		 * @param canvasWidth 최종 결과물의 width
		 * @param canvasHeight 최종 결과물의 height
		 * @param smoothing 부드럽게 하기 옵션
		 * 
		 * @author http://www.bytearray.org/?p=118 from ScaleBitmap 1.2.2
		 */
		static public function gridBitmapDraw(source : BitmapData, scale9Grid : Rectangle, canvasWidth : int, canvasHeight : int, smoothing : Boolean = true) : BitmapData
		{
			var minWidth : int = source.width - scale9Grid.width;
			var minHeight : int = source.height - scale9Grid.height;
			var isMinWidth : Boolean = canvasWidth <= minWidth;
			var isMinHeight : Boolean = canvasHeight <= minHeight;
			var width : int = (!isMinWidth) ? canvasWidth : minWidth;
			var height : int = (!isMinHeight) ? canvasHeight : minHeight;
			var canvas : BitmapData = new BitmapData(width, height, true, 0x000000);
			
			var rows : Array = [0, scale9Grid.top, scale9Grid.bottom, source.height];
			var cols : Array = [0, scale9Grid.left, scale9Grid.right, source.width];
			
			var dRows : Array = [0, scale9Grid.top, height - (source.height - scale9Grid.bottom), height];
			var dCols : Array = [0, scale9Grid.left, width - (source.width - scale9Grid.right), width];

			var origin : Rectangle;
			var draw : Rectangle;
			var mat : Matrix = new Matrix();
			
			for (var cx : int = 0;cx < 3; cx++) {
				for (var cy : int = 0 ;cy < 3; cy++) {
					origin = new Rectangle(cols[cx], rows[cy], cols[cx + 1] - cols[cx], rows[cy + 1] - rows[cy]);
					draw = new Rectangle(dCols[cx], dRows[cy], dCols[cx + 1] - dCols[cx], dRows[cy + 1] - dRows[cy]);
					mat.identity();
					mat.a = draw.width / origin.width;
					mat.d = draw.height / origin.height;
					mat.tx = draw.x - origin.x * mat.a;
					mat.ty = draw.y - origin.y * mat.d;
					canvas.draw(source, mat, null, null, draw, smoothing);
				}
			}
			
			if (isMinWidth || isMinHeight) {
				var resized : BitmapData = new BitmapData(canvasWidth, canvasHeight, true, 0x000000);
				mat.identity();
				mat.a = resized.width / width;
				mat.d = resized.height / height;
				resized.draw(canvas, mat, null, null, null, true);
				
				return resized;
			} else {
				return canvas;
			}
		}
		/**
		 * source bitmapData 의 일부 영역을 잘라서 가져온다.
		 * @param source 오리지널 bitmapData
		 * @param x 잘라낼 x 위치
		 * @param y 잘라낼 y 위치
		 * @param width 잘라낼 가로 크기
		 * @param height 잘라낼 세로 크기
		 * @param pointX 잘라낼 x 위치 추가값
		 * @param pointY 잘라낼 y 위치 추가값
		 */
		static public function getSlice(source : BitmapData, x : int, y : int, width : int, height : int, pointX : int = 0, pointY : int = 0) : BitmapData
		{	
			var rect : Rectangle = new Rectangle(x, y, width, height);
			var pt : Point = new Point(pointX, pointY);
			var bmd : BitmapData = new BitmapData(width, height);
			bmd.copyPixels(source, rect, pt);
			return bmd;
		}

		static public const ROTATE_180 : int = 180;
		static public const ROTATE_90 : int = 90;
		static public const ROTATE_N90 : int = -90;
		static public const FLIP_VERTICAL : int = 1;
		static public const FLIP_HORIZONTAL : int = 2;

		static public function flip(source : BitmapData, direction : int) : BitmapData
		{
			var bmd : BitmapData = new BitmapData(source.width, source.height, true, 0x000000);
			var mat : Matrix = new Matrix();
			switch (direction) {
				case FLIP_VERTICAL :
					mat.scale(1, -1);
					mat.translate(0, source.height);
					break;
				case FLIP_HORIZONTAL :
					mat.scale(-1, 1);
					mat.translate(source.width, 0);
					break;
			}
			bmd.draw(source, mat);
			return bmd;
		}
		static public function rotate(source : BitmapData, angle : int = 90) : BitmapData
		{
			var width : int;
			var height : int;
			var x : Number;
			var y : Number;
			
			switch (angle) {
				case ROTATE_180 :
					width = source.width;
					height = source.height;
					x = width;
					y = height;
					break;
				case ROTATE_90 :
					width = source.height;
					height = source.width;
					x = width;
					y = 0;
					break;
				case ROTATE_N90 :
					width = source.height;
					height = source.width;
					x = 0;
					y = height;
					break;
			}
			
			var bmd : BitmapData = new BitmapData(width, height, true, 0x000000);
			var mat : Matrix = new Matrix();
			mat.createBox(1, 1, MathEx.deg2rad(angle), x, y);
			bmd.draw(source, mat);
			return bmd;
		}
	}
}
