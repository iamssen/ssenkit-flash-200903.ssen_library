package ssen.core.display 
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.text.TextSnapshot;	
	/**
	 * DisplayObjectContainer Interface
	 * @author SSen
	 */
	public interface IDisplayObjectContainer extends IInteractiveObject 
	{
		function get mouseChildren() : Boolean;
		function get numChildren() : int;
		function contains(child : DisplayObject) : Boolean;
		function swapChildrenAt(index1 : int, index2 : int) : void;
		function getChildByName(name : String) : DisplayObject;
		function removeChildAt(index : int) : DisplayObject;
		function getChildIndex(child : DisplayObject) : int;
		function addChildAt(child : DisplayObject, index : int) : DisplayObject;
		function set tabChildren(enable : Boolean) : void;
		function get textSnapshot() : TextSnapshot;
		function swapChildren(child1 : DisplayObject, child2 : DisplayObject) : void;
		function get tabChildren() : Boolean;
		function getObjectsUnderPoint(point : Point) : Array;
		function set mouseChildren(enable : Boolean) : void;
		function removeChild(child : DisplayObject) : DisplayObject;
		function getChildAt(index : int) : DisplayObject;
		function addChild(child : DisplayObject) : DisplayObject;
		function areInaccessibleObjectsUnderPoint(point : Point) : Boolean;
		function setChildIndex(child : DisplayObject, index : int) : void;
	}
}
