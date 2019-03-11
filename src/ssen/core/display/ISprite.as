package ssen.core.display 
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;	
	/**
	 * Sprite Interface
	 * @author SSen
	 */
	public interface ISprite extends IDisplayObjectContainer
	{
		function get dropTarget() : DisplayObject;
		function get soundTransform() : SoundTransform;
		function get hitArea() : Sprite;
		function set buttonMode(value : Boolean) : void;
		function get graphics() : Graphics;
		function get useHandCursor() : Boolean;
		function set hitArea(value : Sprite) : void;
		function get buttonMode() : Boolean;
		function stopDrag() : void;
		function set useHandCursor(value : Boolean) : void;
		function set soundTransform(sndTransform : SoundTransform) : void;
		function startDrag(lockCenter : Boolean = false, bounds : Rectangle = null) : void;
	}
}
