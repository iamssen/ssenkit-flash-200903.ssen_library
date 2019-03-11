package  
test.component{
	import ico.PaperIcon;
	
	import skin.ButtonBitmap;
	import skin.SimpleSkinButtonBitmap;
	
	import ssen.component.buttons.ButtonSkinModes;
	import ssen.component.buttons.ButtonType;
	import ssen.component.buttons.ILabelButtonSkin;
	import ssen.component.buttons.LabelButton;
	import ssen.component.buttons.LabelButtonSkin;
	import ssen.component.buttons.SimpleSkinButton;
	import ssen.core.convert.GraphicsConverter;
	import ssen.core.display.SSenSprite;
	import ssen.core.events.OnOffEvent;
	import ssen.core.skinObject.SkinSprite;
	import ssen.core.text.TextStyle;
	import ssen.debug.TestButtonGroup;
	
	import flash.events.MouseEvent;		
	/**
	 * @author SSen
	 */
	public class TestButtons extends SSenSprite 
	{
		private var ss : SkinSprite;
		private var ssb : SimpleSkinButton;
		private var lbs : ILabelButtonSkin;
		private var ts : TextStyle;
		private var lb : LabelButton;

		public function TestButtons()
		{
			ss = GraphicsConverter.bitmapDataToSkinSprite(new SimpleSkinButtonBitmap(0, 0), 48, 21, ButtonSkinModes.MODES);
			ssb = new SimpleSkinButton(ss);
			ssb.x = ssb.y = 10;
			ssb.addEventListener(MouseEvent.CLICK, click);
			ssb.addEventListener(OnOffEvent.ONOFF, onoff);
			
			lbs = new LabelButtonSkin(new ButtonBitmap(0, 0));
			ts = new TextStyle();
			lb = new LabelButton(lbs, "hello button", ts, GraphicsConverter.objectToDisplayObject(PaperIcon), false);
			lb.position = ssb.nextPosition();
			lb.addEventListener(MouseEvent.CLICK, click);
			lb.addEventListener(OnOffEvent.ONOFF, onoff);
			
			var tg : TestButtonGroup = new TestButtonGroup("enable toggle", t1, "type toggle", t2);
			tg.width = 500;
			tg.position = ssb.nextPositionBr(20);
			
			addChildren(ssb, tg, lb);
		}
		private function onoff(event : OnOffEvent) : void
		{
			trace(event.target, "onoff");
		}
		private function click(event : MouseEvent) : void
		{
			trace(event.target, "click");
		}
		private function t1() : void
		{
			ssb.enable = (ssb.enable) ? false : true; 
			lb.enable = (lb.enable) ? false : true;
		}
		private function t2() : void
		{
			ssb.buttonType = (ssb.buttonType == ButtonType.NORMAL) ? ButtonType.TOGGLE : ButtonType.NORMAL;
			lb.buttonType = (lb.buttonType == ButtonType.NORMAL) ? ButtonType.TOGGLE : ButtonType.NORMAL;
			trace(ssb.buttonType, lb.buttonType);
		}
	}
}
