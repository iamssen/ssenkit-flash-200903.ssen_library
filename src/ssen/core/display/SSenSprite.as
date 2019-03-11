package ssen.core.display
{
	import ssen.core.array.ArrayEx;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;	
	/**
	 * SSen Sprite
	 * @author SSen
	 */
	public class SSenSprite extends Sprite implements ISSenSprite
	{
		private var _hover : Boolean;
		private var _hoverPreX : Number;
		private var _hoverPreY : Number;
		private var _hoverIndex : int;
		private var _hoverContainer : DisplayObjectContainer;

		public function SSenSprite()
		{ 
		}
		/** 위치를 Stage 위로 올리거나 내린다 */
		public function get hover() : Boolean
		{
			return _hover;
		}
		public function set hover(hover : Boolean) : void
		{
			if (hover) {
				if (parent != stage && !_hover) {
					_hoverPreX = x;
					_hoverPreY = y;
					_hoverContainer = parent;
					_hoverIndex = index;
					
					x = globalX;
					y = globalY;
					stage.addChild(this);
				} 
			} else {
				if (parent == stage && _hover) {
					x = _hoverPreX;
					y = _hoverPreY;
					_hoverContainer.addChildAt(this, _hoverIndex);
				}
			}
			_hover = hover;
		}
		/** stage 아래의 최상단 root 를 가져온다 */
		public function get canvas() : Sprite
		{
			return stage.getChildByName("root1") as Sprite;
		}
		/**
		 * dummy 의 index, width, height, x, y 등을 승계받아서 addChild 시킨다.
		 * @param child 추가할 자식
		 * @param dummy 대체할 자식
		 * @param option 승계할 옵션들 , 기본 = x, y, index, width, height
		 */
		public function addChildTo(child : DisplayObject, dummy : DisplayObject, ... option) : void
		{
			if (contains(dummy)) {
				if (option.length <= 0) option = ["x", "y", "index", "width", "height"];
				if (ArrayEx.findElement("index", option)) {
					addChildAt(child, getChildIndex(dummy));
					option = ArrayEx.delElement("index", option);
				} else {
					addChild(child);
				}
				var f : int;
				for (f = 0;f < option.length; f++) {
					child[option[f]] = dummy[option[f]];
				}
				removeChild(dummy);
			} else {
				throw new Error("SSenContainer#addChildTo : dummy 는 container 의 자식이 아닙니다.");
			}
		}
		/** 복수의 자식을 addChild 시킨다 */
		public function addChildren(...children : Array) : void
		{
			var child : DisplayObject;
			for each (child in children) {
				addChild(child);
			}
		}
		/** 복수의 자식을 removeChild 시킨다 */
		public function removeChildren(...children : Array) : void
		{
			var child : DisplayObject;
			for each (child in children) {
				removeChild(child);
			}
		}
		/** Stage 기준 position point */
		public function get globalPosition() : Point
		{
			var point : Point = parent.localToGlobal(new Point(x, y));
			return point;
		}
		public function set globalPosition(point : Point) : void
		{
			var p : Point = parent.globalToLocal(point);
			x = p.x;
			y = p.y;
		}
		/** Stage 기준 X position */
		public function get globalX() : Number
		{
			return globalPosition.x;
		}
		public function set globalX(value : Number) : void
		{
			var p : Point = parent.globalToLocal(new Point(value, 0));
			x = p.x;
		}
		/** Stage 기준 Y position */
		public function get globalY() : Number
		{
			return globalPosition.y;
		}
		public function set globalY(value : Number) : void
		{
			var p : Point = parent.globalToLocal(new Point(0, value));
			y = p.y;
		}
		/** x, y 위치 */
		public function get position() : Point
		{
			var point : Point = new Point();
			point.x = x;
			point.y = y;
			return point;
		}
		public function set position(point : Point) : void
		{
			x = point.x;
			y = point.y;
		}
		/** 다음 X 위치 */
		public function nextX(spaceX : int = 0) : Number
		{
			return x + width + spaceX;
		}
		/** 다음 Y 위치 */
		public function nextY(spaceY : int = 0) : Number
		{
			return y + height + spaceY;
		}
		/** index */
		public function get index() : int
		{
			if (parent != null) {
				return parent.getChildIndex(this);
			} else {
				return -10;
			}
		}
		public function set index(index : int) : void
		{
			if (parent != null) {
				if (index > parent.numChildren - 1) {
					index = parent.numChildren - 1;
				} else if (index < 0) {
					index = 0;
				}
				parent.setChildIndex(this, index);
			}
		}
		/** 오른쪽 다음 위치 */
		public function nextPosition(spaceX : int = 5) : Point
		{
			var point : Point = new Point();
			point.x = x + width + spaceX;
			point.y = y;
			return point;
		}
		/** 아랫 라인 다음 위치 */
		public function nextPositionBr(spaceY : int = 5) : Point
		{
			var point : Point = new Point();
			point.x = x;
			point.y = y + height + spaceY;
			return point;
		}
		/* *********************************************************************
		 * Util Methods
		 ********************************************************************* */
		/**
		 * mousePointer 가 Rectangle 안에 위치하는지를 확인
		 * @param where 영역체크의 기준이 될 DisplayObject
		 * @param rect 영역체크에 사용될 Rectangle
		 */
		protected function isPointerInRect(where : DisplayObject, rect : Rectangle) : Boolean
		{
			var sx : Number = where.mouseX;
			var sy : Number = where.mouseY;
			if (sx > rect.x && sx < rect.x + rect.width && sy > rect.y && sy < rect.y + rect.height) {
				return true;
			} else {
				return false;
			}
		}
		
		/** 위치값들로 계산했을때 스테이지 밖으로 벗어나는지를 확인 X */
		protected function isObjectBehindX(stageX : int, width : int, stageWidth : int) : Boolean
		{
			if (stageX < 0 || stageX + width > stageWidth) {
				return true;
			}
			return false;
		}
		/** 위치값들로 계산했을때 스테이지 밖으로 벗어나는지를 확인 Y */
		protected function isObjectBehindY(stageY : int, height : int, stageHeight : int) : Boolean
		{
			if (stageY < 0 || stageY + height > stageHeight) {
				return true;
			}
			return false;
		} 
		/** bitmap asset 을 가져온다 */
		protected function getBitmapDefinition(name : String) : BitmapData
		{
			var cl : Class = getDefinition(name);
			var bmd : BitmapData;
			bmd = new cl(0, 0);
			return bmd;
		}
		/** asset 을 가져온다 */
		protected function getDefinition(name : String) : Class
		{
			var cl : Class;
			if (root != null && root.loaderInfo.applicationDomain.hasDefinition(name)) {
				cl = root.loaderInfo.applicationDomain.getDefinition(name) as Class;
			} else {
				cl = getDefinitionByName(name) as Class;
			}
			return cl;
		}
	}
}
