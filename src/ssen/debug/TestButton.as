package ssen.debug
{
	import ssen.core.display.SSenSprite;
	import ssen.core.number.MathEx;
	
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;	
	/**
	 * 단순 테스트 버튼
	 */
	public class TestButton extends SSenSprite
	{
		private var _txt : TextField;
		private var _listener : Function;

		/**
		 * 버튼을 만든다
		 * @param str 버튼의 제목
		 * @param listener 클릭시 실행할 콜백함수
		 */
		public function TestButton(str : String, listener : Function)
		{
			_listener = listener;
			
			buttonMode = true;
			
			_txt = getTextfield(str);
			
			var w : int = _txt.width + 10;
			var h : int = _txt.height + 10;
			var m : int = 5;
			 
			var g : Graphics = graphics;
			var mat : Matrix = new Matrix();
			mat.createGradientBox(w, h, MathEx.deg2rad(270));
			g.beginGradientFill(GradientType.LINEAR, [0x333333,0x888888], null, [1,255], mat);
			g.moveTo(0, m);
			g.curveTo(0, 0, m, 0);
			g.lineTo(w - m, 0);
			g.curveTo(w, 0, w, m);
			g.lineTo(w, h - m);
			g.curveTo(w, h, w - m, h);
			g.lineTo(m, h);
			g.curveTo(0, h, 0, h - m);
			g.lineTo(0, m);
			g.endFill();
			
			_txt.x = m;
			_txt.y = m;
			
			addChild(_txt);
			
			addEventListener(MouseEvent.CLICK, click);
		}
		private function click(event : MouseEvent) : void
		{
			_listener();
		}
		private function getTextfield(str : String) : TextField
		{
			var tf : TextFormat = new TextFormat("돋움", 11, 0xffffff, true);
			tf.align = TextFormatAlign.CENTER;
			
			var txt : TextField = new TextField();
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.defaultTextFormat = tf;
			txt.text = str;
			txt.selectable = false;
			txt.mouseEnabled = false;
			
			return txt;
		}
	}
}