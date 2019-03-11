package ssen.debug 
{
	import flash.display.Graphics;	
	import flash.display.Sprite;	
	/**
	 * Description
	 * @author SSen
	 */
	public class TestBoxes 
	{
		public static function createTransparentBox(width : Number = 100, height : Number = 100) : Sprite
		{
			var sprite : Sprite = new Sprite();
			var g : Graphics = sprite.graphics;
			g.beginFill(0x000000, 0);
			g.drawRect(0, 0, width, height);
			g.endFill();
			
			return sprite;
		}
		public static function createColorBox(color : uint = 0xffffff, width : Number = 100, height : Number = 100) : Sprite
		{
			var sprite : Sprite = new Sprite();
			var g : Graphics = sprite.graphics;
			g.beginFill(color);
			g.drawRect(0, 0, width, height);
			g.endFill();
			
			return sprite; 
		}
	}
}
