package ssen.core.events 
{
	import flash.events.Event;
	/**
	 * DateEvent
	 * @author SSen
	 */
	public class DateEvent extends Event
	{
		/** 달력의 날짜가 변경되었을 경우 */
		static public const CHANGE_CALENDAR : String = "change calendar";
		private var _date : Date;

		public function DateEvent(type : String, date : Date, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			_date = date;
		}
		/** Date */
		public function get date() : Date
		{
			return _date;
		}
		public override function toString() : String
		{
			return '[CalendarEvent type="' + type + '"]' + _date + '[/CalendarEvent]';
		}
	}
}