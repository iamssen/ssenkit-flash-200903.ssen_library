package ssen.component.panels 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;		
	/**
	 * Alert, Confirm, Prompt 등을 담당한다
	 * @author SSen
	 */
	public class Panel 
	{
		/** [사용전 필수 셋팅] stage 를 입력해준다 */
		public static var stage : Stage;
		/** filter 미입력시 기초 작동할 필터 */
		public static var defaultCanvasFilters : Array;

		private static function get canvas() : Sprite
		{
			return stage.getChildByName("root1") as Sprite;
		}
		/**
		 * alert
		 * @param panelClass 사용할 panelObject 의 class
		 * @param closeCallback 닫기 버튼을 누를때 작동할 callback --> cancelCallback
		 * @param options panelObject 에 전달할 option 들, panelObject 마다 틀림
		 * @param canvasFilters 차단효과를 대신할 bitmapFilters
		 * @param panelX 패널의 X 위치 (기본 중앙정렬)
		 * @param panelY 패널의 Y 위치 (기본 중앙정렬)
		 */
		public static function alert(panelClass : Class, closeCallback : Function, options : Object = null, canvasFilters : Array = null, panelX : int = -1, panelY : int = -1) : IPanelObject
		{
			open(canvasFilters);
			
			// creat panel, setting
			var panel : IPanelObject = new panelClass();
			panel.panelMode = PanelMode.ALERT;
			panel.options = options;
			panel.initialize();
			// callbacks
			panel.cancelCallback = closeCallback;
			// addChild, align
			align(panel, panelX, panelY);
			stage.addChild(DisplayObject(panel));
			
			return panel;
		}
		public static function confirm(panelClass : Class, okCallback : Function, cancelCallback : Function, options : Object = null, canvasFilters : Array = null, panelX : int = 0, panelY : int = 0) : IPanelObject
		{
			return null;
		}
		public static function prompt(panelClass : Class, completeCallback : Function, cancelCallback : Function, options : Object = null, canvasFilters : Array = null, panelX : int = 0, panelY : int = 0) : IPanelObject
		{
			return null;
		}
		public static function open(canvasFilters : Array = null) : void
		{
			// canvas event, filter 처리
			canvas.filters = (canvasFilters != null) ? canvasFilters : defaultCanvasFilters;
			canvas.mouseEnabled = false;
			canvas.mouseChildren = false;
		}
		public static function close(panel : IPanelObject) : void
		{
			panel.resourceKill();
			stage.removeChild(DisplayObject(panel));
			
			if (panelLength() <= 0) {
				canvas.filters = null;
				canvas.mouseEnabled = true;
				canvas.mouseChildren = true;
			}
		}
		public static function closeAll() : void
		{
			var f : int;
			var panel : DisplayObject;
			for (f = 0;f < stage.numChildren; f++) {
				panel = stage.getChildAt(f);
				if (panel is IPanelObject) {
					IPanelObject(panel).resourceKill();
					stage.removeChild(panel);
				} 
			}
			canvas.filters = null;
			canvas.mouseEnabled = true;
			canvas.mouseChildren = true;
		}
		public static function panelLength() : int
		{
			var length : int = 0;
			var f : int;
			for (f = 0;f < stage.numChildren; f++) {
				if (stage.getChildAt(f) is IPanelObject) length++;
			}
			return length;
		}
		public static function tooltip(msg : Object, targetMouse : Boolean = false, targetObject : DisplayObject = null, position9 : String = null, panel : IPanelObject = null) : void
		{
		}
		private static function align(panel : IPanelObject, x : int = -1, y : int = -1) : void
		{
			if (x < 0 || y < 0) {
				x = (stage.stageWidth >> 1) - (panel.width >> 1);
				var h : int = stage.stageHeight >> 3;
				y = (h * 3) - (panel.height >> 1);
			}
			panel.x = x;
			panel.y = y;
		}
	}
}
