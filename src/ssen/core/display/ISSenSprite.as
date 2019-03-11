package ssen.core.display 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;	
	/**
	 * SSenSprite Interface
	 * @author SSen
	 */
	public interface ISSenSprite extends ISprite 
	{
		function get hover() : Boolean
		function set hover(hover : Boolean) : void
		function get canvas() : Sprite
		function addChildTo(child : DisplayObject, dummy : DisplayObject, ...option) : void
		function addChildren(...children : Array) : void
		function removeChildren(...children : Array) : void
		function get globalPosition() : Point
		function set globalPosition(point : Point) : void
		function get globalX() : Number
		function set globalX(value : Number) : void
		function get globalY() : Number
		function set globalY(value : Number) : void
		function get position() : Point
		function set position(point : Point) : void
		function nextX(spaceX : int = 0) : Number
		function nextY(spaceY : int = 0) : Number
		function get index() : int
		function set index(index : int) : void
		function nextPosition(spaceX : int = 5) : Point
		function nextPositionBr(spaceY : int = 5) : Point
	}
}
