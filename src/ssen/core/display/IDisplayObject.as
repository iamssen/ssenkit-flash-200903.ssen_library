package ssen.core.display
{
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.display.Shader;
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.geom.Vector3D;	
	/**
	 * DisplayObject Interface
	 * @author SSen
	 */
	public interface IDisplayObject extends IEventDispatcher
	{
		function get visible() : Boolean;
		function get rotation() : Number;
		function localToGlobal(point : Point) : Point;
		function get name() : String;
		function set width(value : Number) : void;
		function globalToLocal(point : Point) : Point;
		function get blendMode() : String;
		function get scale9Grid() : Rectangle;
		function set name(value : String) : void;
		function get rotationX() : Number;
		function get rotationY() : Number;
		function set scaleX(value : Number) : void;
		function set scaleY(value : Number) : void;
		function set scaleZ(value : Number) : void;
		function get accessibilityProperties() : AccessibilityProperties;
		function set scrollRect(value : Rectangle) : void;
		function get rotationZ() : Number;
		function get height() : Number;
		function set blendMode(value : String) : void;
		function set scale9Grid(innerRectangle : Rectangle) : void;
		function getBounds(targetCoordinateSpace : DisplayObject) : Rectangle;
		function set blendShader(value : Shader) : void;
		function get opaqueBackground() : Object;
		function get parent() : DisplayObjectContainer;
		function get cacheAsBitmap() : Boolean;
		function set rotationX(value : Number) : void;
		function set rotationY(value : Number) : void;
		function set rotationZ(value : Number) : void;
		function local3DToGlobal(point3d : Vector3D) : Point;
		function set alpha(value : Number) : void;
		function globalToLocal3D(point : Point) : Vector3D;
		function set accessibilityProperties(value : AccessibilityProperties) : void;
		function get width() : Number;
		function hitTestPoint(x : Number, y : Number, shapeFlag : Boolean = false) : Boolean;
		function set cacheAsBitmap(value : Boolean) : void;
		function get scaleX() : Number;
		function get scaleY() : Number;
		function get scaleZ() : Number;
		function get scrollRect() : Rectangle;
		function get mouseX() : Number;
		function get mouseY() : Number;
		function set height(value : Number) : void;
		function set mask(value : DisplayObject) : void;
		function getRect(targetCoordinateSpace : DisplayObject) : Rectangle;
		function get alpha() : Number;
		function set transform(value : Transform) : void;
		function get loaderInfo() : LoaderInfo;
		function get root() : DisplayObject;
		function set visible(value : Boolean) : void;
		function set opaqueBackground(value : Object) : void;
		function hitTestObject(obj : DisplayObject) : Boolean;
		function get mask() : DisplayObject;
		function set x(value : Number) : void;
		function set y(value : Number) : void;
		function get transform() : Transform;
		function set z(value : Number) : void;
		function set filters(value : Array) : void;
		function get x() : Number;
		function get y() : Number;
		function get z() : Number;
		function get filters() : Array;
		function set rotation(value : Number) : void;
		function get stage() : Stage;
	}
}
