package ssen.core.events
{
	import flash.events.Event;	
	/**
	 * 기본 이벤트 셋트
	 * @author SSen
	 */
	public class SSenEvent extends Event 
	{
		/** 활성 될때 */
		static public const ENABLE : String = "enable";
		/** 비활성 될때 */
		static public const DISABLE : String = "disable";
		/** 사이즈에 변경이 있을때 */
		static public const RESIZE : String = "resize";
		/** 닫힐때 */
		static public const CLOSE : String = "close";
		/** 초기화 완료 */
		static public const INITIALIZE : String = "initialize";
		/** 입력시작 */
		static public const INPUT_START : String = "inputStart";
		/** 입력종료 */
		static public const INPUT_END : String = "inputEnd";
		/** Enter Key 입력 */
		static public const INPUT_ENTER : String = "inputEnter";

		public function SSenEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		/** toString() */
		override public function toString() : String
		{
			return '[SSenEvent type="' + type + '"]';
		}
	}
}
