package ssen.core.events 
{
	import flash.events.Event;
	/**
	 * toggle 등의 on/off 시스템에서 사용할 수 있다
	 * @author SSen
	 */
	public class OnOffEvent extends Event 
	{
		/** on, off 상태가 변경될때 */
		static public const ONOFF : String = "onoff";
		private var _onoff : Boolean;

		public function OnOffEvent(type : String, onoff : Boolean, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			_onoff = onoff;
		}
		/** 켜져있는지 꺼져있는지 확인 */
		public function get onoff() : Boolean
		{
			return _onoff;
		}
		override public function toString() : String
		{
			return '[OnOffEvent type="' + type + '" onoff="' + _onoff + '"]';
		}
	}
}
