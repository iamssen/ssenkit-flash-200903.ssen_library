package ssen.core.date 
{
	import ssen.core.events.DateEvent;

	import flash.events.EventDispatcher;	

	/**
	 * ssen.core.events.DateEvent.CHANGE_CALENDAR
	 * @see ssen.core.events.DateEvent#CHANGE_CALENDAR */
	[Event(name="change calendar", type="ssen.core.events.DateEvent")]
	/**
	 * Calendar module base
	 * @author SSen
	 */
	public class CalendarBase extends EventDispatcher 
	{
		private var _date : Date;
		private var _min : Date;
		private var _max : Date;

		public function CalendarBase(yearOrTimevalue : Object = null, month : Number = 0, date : Number = 1, min : Date = null, max : Date = null, hour : Number = 0, minute : Number = 0, second : Number = 0, millisecond : Number = 0)
		{
			_date = new Date(yearOrTimevalue, month, date, hour, minute, second, millisecond);
			setMinMax(min, max);
		}
		/** 달력이 넘어가서는 안될 최소 범위 */
		public function get min() : Date
		{
			return _min;
		}
		public function set min(min : Date) : void
		{
			setMinMax(min, _max);
		}
		/** 달력이 넘어가서는 안될 최대 범위 */
		public function get max() : Date
		{
			return _max;
		}
		public function set max(max : Date) : void
		{
			setMinMax(_min, max);
		}
		/**
		 * 달력의 최소, 최대 범위를 셋팅한다.
		 * @param min 최소범위
		 * @param max 최대범위
		 */
		public function setMinMax(min : Date = null, max : Date = null) : void
		{
			if (min != null && max != null && min.time > max.time) {
				_max = min;
				_min = max;
			} else {
				_min = min;
				_max = max;
			}
			
			if (!checkMinMax()) dispatchEvent(new DateEvent(DateEvent.CHANGE_CALENDAR, _date));
		}
		/** 
		 * 현재 시간이 최소, 최대 범위안에 있는지를 체크한다
		 * @param autoModify 자동으로 수정할지 여부
		 */
		public function checkMinMax(autoModify : Boolean = true) : Boolean
		{
			var bool : Boolean = true;
			if (_min != null && _date.time < min.time) {
				bool = false; 
				if (autoModify) _date.time = min.time;
			}
			if (_max != null && _date.time > max.time) {
				bool = false;
				if (autoModify) _date.time = max.time;
			}
			return bool;
		}
		/**
		 * 현재 시간이 특정한 최소, 최대 범위안에 있는지를 체크한다, 시대등을 체크하거나 한다.
		 * @param min 최소범위
		 * @param max 최대범위
		 */
		public function checkMinMaxDate(min : Date, max : Date) : Boolean
		{
			return _date.time > min.time && _date.time < max.time;
		}
		/** 현재 월의 마지막 날짜를 반환 */
		public function get lastdayOfMonth() : int
		{
			var lastday : int;
			if (_date.month != 1) {
				lastday = DateEx.LAST_DAYS[_date.month];
			} else {
				if(((_date.fullYear % 4 == 0) && (_date.fullYear % 100 != 0)) || (_date.fullYear % 400 == 0)) {
					lastday = 29;
				} else {
					lastday = DateEx.LAST_DAYS[_date.month];
				}
			}
			return lastday;
		}
		/** 현재 달의 첫째 날짜 요일을 반환 */
		public function get firstDayOfWeek() : int
		{
			var date : Date = new Date(_date.fullYear, _date.month);
			return date.getDay();
		}
		// 날이 변경될 경우에 알린다.
		private function dispatchDate() : void
		{
			checkMinMax();
			dispatchEvent(new DateEvent(DateEvent.CHANGE_CALENDAR, _date));
		}
		/**
		 * 달력을 다음달로 넘김
		 * @param isFirstDay 날짜를 1일로 바꿀것인가?
		 */
		public function nextMonth(isFirstDay : Boolean = false) : void
		{
			if (_date.month >= 11) {
				_date.month = 0;
				_date.fullYear++;
			} else {
				_date.month++;
			}
			if (isFirstDay) {
				_date.date = 1;
			}
			dispatchDate();
		}
		/**
		 * 달력을 이전달로 넘김
		 * @param isFirstDay 날짜를 1일로 바꿀것인가?
		 */
		public function preMonth(isFirstDay : Boolean = false) : void
		{
			if (_date.month <= 0) {
				_date.month = 11;
				_date.fullYear--;
			} else {
				_date.month--;
			}
			if (isFirstDay) {
				_date.date = 1;
			}
			dispatchDate();
		}
		/**
		 * 달력을 다음주로 넘림
		 * @param isFirstDay 날짜를 첫째날인 일요일로 바꿀것인가?
		 */
		public function nextWeek(isFirstDay : Boolean = false) : void
		{
			_date.time += 604800000;
			if (isFirstDay) {
				_date.time -= 86400000 * (_date.day);
			}
			dispatchDate();
		}
		/**
		 * 달력을 이전주로 넘김
		 * @param isFirstDay 날짜를 첫째날인 일요일로 바꿀것인가?
		 */
		public function preWeek(isFirstDay : Boolean = false) : void
		{
			_date.time -= 604800000; 
			// 1000*60*60*24*7
			if (isFirstDay) {
				_date.time -= 86400000 * (_date.day);
			}
			dispatchDate();
		}
		/**
		 * 달력을 다음년으로 넘김
		 * @param isFirstMonth 월을 1월로 바꿀것인가?
		 * @param isFirstDay 날짜를 1일로 바꿀것인가?
		 */
		public function nextYear(isFirstMonth : Boolean = false, isFirstDay : Boolean = false) : void
		{
			_date.fullYear++;
			if (isFirstMonth) {
				_date.month = 0;
			}
			if (isFirstDay) {
				_date.date = 1;
			}
			dispatchDate();
		}
		/**
		 * 달력을 이전년으로 넘김
		 * @param isFirstMonth 월을 1월로 바꿀것인가?
		 * @param isFirstDay 날짜를 1일로 바꿀것인가?
		 */
		public function preYear(isFirstMonth : Boolean = false, isFirstDay : Boolean = false) : void
		{
			_date.fullYear--;
			if (isFirstMonth) {
				_date.month = 0;
			}
			if (isFirstDay) {
				_date.date = 1;
			}
			dispatchDate();
		}
		/**
		 * 달력을 다음일로 넘김
		 * @param much 몇일후로 넘길것인가?
		 *
		 */
		public function nextDay(much : int = 1) : void
		{
			_date.time += 86400000 * much;
			dispatchDate();
		}
		/**
		 * 달력을 이전일로 넘김
		 * @param much 몇일전으로 넘길것인가?
		 */
		public function preDay(much : int = 1) : void
		{
			_date.time -= 86400000 * much; 
			// 1000*60*60*24
			dispatchDate();
		}
		/** Date */
		public function get date() : Date
		{
			return _date;
		}
		public function set date(date : Date) : void
		{
			_date = date;
			checkMinMax();
		}
	}
}
