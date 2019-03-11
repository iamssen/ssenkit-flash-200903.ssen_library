package ssen.component.buttons 
{
	import ssen.component.buttons.ButtonBase;
	import ssen.core.skinObject.SkinSprite;		
	/**
	 * SkinSprite 를 넣어서 간단하게 만드는 Button
	 * @author SSen
	 */
	public class SimpleSkinButton extends ButtonBase 
	{
		private var _skinSprite : SkinSprite;

		public function SimpleSkinButton(skinSprite : SkinSprite, buttonType : String = "normal")
		{
			_width = skinSprite.width;
			_height = skinSprite.height;
			_buttonType = buttonType;
			_skinSprite = skinSprite;
			addChild(skinSprite);
			
			enable = true;
		}
		/* *********************************************************************
		 * Interface Properties and Methods 
		 ********************************************************************* */
		/** @private */
		override public function set width(value : Number) : void
		{
			super.width = value;
			_skinSprite.width = value;
		}
		/** @private */
		override public function set height(value : Number) : void
		{
			super.height = value;
			_skinSprite.height = value;
		}
		override public function resourceKill() : void
		{
			super.resourceKill();
			_skinSprite = null;
		}
		override protected function skinning() : void
		{
			super.skinning();
			_skinSprite.skinning(skinMode);
		}
	}
}
