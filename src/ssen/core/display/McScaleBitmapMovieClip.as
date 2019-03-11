package ssen.core.display 
{
	import ssen.core.skinObject.ISkinObject;

	import org.bytearray.display.ScaleBitmap;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;		
	/**
	 * Flash 의 MovieClip 상에서 여러컷으로 구성된 ScaleBitmap 을 설정할 수 있음
	 * @author SSen
	 */
	public class McScaleBitmapMovieClip extends MovieClip implements ISkinObject 
	{
		private var _scaleBitmaps : Vector.<ScaleBitmap>;
		private var _scaleBitmap : ScaleBitmap;
		private var _width : Number;
		private var _height : Number;
		private var _currentFrame : int;
		private var _labels : Dictionary;

		public function McScaleBitmapMovieClip()
		{
			_width = width;
			_height = height;
			_labels = new Dictionary(true);
			
			var f : int;
			var w : int;
			var h : int;
			var grid : Rectangle = scale9Grid;
			var shape : DisplayObject;
			var bmd : BitmapData;
			var scaleBitmap : ScaleBitmap;
			
			_scaleBitmaps = new Vector.<ScaleBitmap>();
			
			for (f = 1;f <= totalFrames; f++) {
				super.gotoAndStop(f);
				
				if (super.currentLabel != "" && _labels[super.currentLabel] == undefined) {
					_labels[super.currentLabel] = currentFrame;
				}
				
				w = width;
				h = height;
				
				shape = getChildAt(0);
				bmd = new BitmapData(shape.width, shape.height);
				bmd.draw(shape);
				scaleBitmap = new ScaleBitmap(bmd);
				scaleBitmap.scale9Grid = grid;
				scaleBitmap.width = w;
				scaleBitmap.height = h;
				_scaleBitmaps.push(scaleBitmap);
			}
			
			super.gotoAndStop(1);
			removeChild(getChildAt(0));
			_currentFrame = 1;
			
			_scaleBitmap = _scaleBitmaps[0];
			_scaleBitmap.x = 0;
			_scaleBitmap.y = 0;
			_scaleBitmap.width = _width;
			_scaleBitmap.height = _height;
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
			_width = value;
			_scaleBitmap.width = _width;
			setBlank(_width, _height);
		}
		/** @private */
		override public function set height(value : Number) : void
		{
			_height = value;
			_scaleBitmap.height = _height;
			setBlank(_width, _height);
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
		override public function gotoAndPlay(frame : Object, scene : String = null) : void
		{
			changeBitmap(frame);
		}
		override public function gotoAndStop(frame : Object, scene : String = null) : void
		{
			changeBitmap(frame);
		}
		override public function nextFrame() : void
		{
			var frame : int;
			if (_currentFrame >= _scaleBitmaps.length) {
				frame = _currentFrame;
			} else {
				frame = _currentFrame + 1;
			}
			changeBitmap(frame);
		}
		override public function prevFrame() : void
		{
			var frame : int;
			if (_currentFrame <= 1) {
				frame = _currentFrame;
			} else {
				frame = _currentFrame - 1;
			}
			changeBitmap(frame);
		}
		private function getLabelFrameNumber(labelName : String) : int
		{
			if (_labels[labelName] != undefined) {
				return _labels[labelName];
			} else {
				trace("SSEN// ssen.core.display::McScaleBitmapMovieClip#getLabelFrameNumber() labelName 에 해당하는 label 이 없습니다.");
				return 1;
			}
		}
		private function changeBitmap(frame : Object) : void
		{
			if (frame is String) frame = getLabelFrameNumber(String(frame));
			var f : int = Number(frame);
			_currentFrame = f;
			var scaleBitmap : ScaleBitmap = _scaleBitmaps[f - 1];
			scaleBitmap.x = 0;
			scaleBitmap.y = 0;
			scaleBitmap.width = _width;
			scaleBitmap.height = _height;
			
			removeChild(_scaleBitmap);
			addChild(scaleBitmap);
			
			_scaleBitmap = scaleBitmap;
		}
		public function skinning(modeName : String = "default") : void
		{
			changeBitmap(modeName);
		}
		public function get flag() : String
		{
			for (var name:String in _labels) {
				if (_labels[name] == _currentFrame) return name;
			}
			return null;
		}
		public function get skinList() : Array
		{
			var list : Array = new Array();
			for (var name:String in _labels) {
				list.push(name);
			}
			return list;
		}
	}
}
