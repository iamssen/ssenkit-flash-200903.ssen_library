package test.component 
{
	import ssen.component.panels.PanelObjectBase;
	import ssen.core.array.Values;

	import flash.events.Event;
	import flash.text.TextField;		
	/**
	 * @author SSen
	 */
	public class TestMcPanelObject extends PanelObjectBase 
	{
		public function TestMcPanelObject()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		private function addedToStage(event : Event) : void
		{
			setCancelButtons(getChildByName("close_mc"));
			setMoveObjects(getChildByName("move_mc"));
		}
		/* 필수로 상속구현 해야할 것들 */
		// 활성화 : 스킨구현 및 마우스 등의 이벤트 차단
		override public function set enable(enable : Boolean) : void
		{
			super.enable = enable;
		}
		// 초기화
		override public function initialize() : void
		{
			var txt : TextField = getChildByName("content_txt") as TextField;
			txt.text = options["text"];
		}
		// prompt 모드에서 데이터의 수집을 담당
		override protected function getPromptData() : Values
		{
			return null;
		}
	}
}
