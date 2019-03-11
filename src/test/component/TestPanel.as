package  
test.component
{
	import ssen.component.panels.IPanelObject;
	import ssen.component.panels.Panel;
	import ssen.core.display.SSenSprite;
	import ssen.core.graphics.FavoriteColorMatrix;
	import ssen.debug.TestBoxes;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;	
	/**
	 * @author SSen
	 */
	public class TestPanel extends SSenSprite 
	{
		private var alert : IPanelObject;

		public function TestPanel()
		{
			var d : DisplayObject = TestBoxes.createColorBox(0xffffff, stage.stageWidth, stage.stageHeight);
			canvas.addChildAt(d, 0);
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		private function addedToStage(event : Event) : void
		{
			addEventListener(MouseEvent.CLICK, click);
		}
		private function click(event : MouseEvent) : void
		{
			Panel.stage = stage;
			alert = Panel.alert(TestMcPanelObject1, close, {text:"hello panel"}, [new ColorMatrixFilter(FavoriteColorMatrix.DARK_LOW), new BlurFilter()]);
		}
		private function close() : void
		{
			trace("close ok");
			Panel.close(alert);
		}
	}
}
