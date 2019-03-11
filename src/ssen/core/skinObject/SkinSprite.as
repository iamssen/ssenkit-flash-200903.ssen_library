package ssen.core.skinObject 
{
	import ssen.core.display.SSenSprite;
	import ssen.core.skinObject.ISkinObject;
	import ssen.core.skinObject.SkinMode;
	
	import flash.display.DisplayObject;		
	/**
	 * SkinObject : 여러장의 DisplayObject 를 SkinMode 에 따라 보여준다
	 * @author SSen
	 */
	public class SkinSprite extends SSenSprite implements ISkinObject 
	{
		private var _display : DisplayObject;
		private var _skins : Array;
		private var _flag : String;

		public function SkinSprite(skins : Array)
		{
			_display = skins[SkinMode.DEFAULT];
			_skins = skins;
			_flag = SkinMode.DEFAULT;
			addChild(_display);
		}
		/** @copy ssen.component.skin.ISkinObject#skinning() */
		public function skinning(modeName : String = SkinMode.DEFAULT) : void
		{
			if (_flag != modeName) {
				var child : DisplayObject = _skins[modeName];
				addChildTo(child, _display);
				_display = child;
				_flag = modeName;
			}
		}
		/** @copy ssen.component.skin.ISkinObject#flag */
		public function get flag() : String
		{
			return _flag;
		}
		/** @copy ssen.component.skin.ISkinObject#skinList */
		public function get skinList() : Array
		{
			var arr : Array = new Array();
			var name : String;
			for (name in _skins) {
				arr.push(name);
			}
			return arr;
		}
	}
}
