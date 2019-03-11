package ssen.core.date 
{
	import ssen.core.number.NumberEx;		
	/**
	 * Date 를 특정 형식으로 표현해주는 역활을 한다
	 * @author SSen
	 */
	public class DateFormatter 
	{
		static private var _MMM : String = "Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec";
		static private var _MMMM : String = "January|February|March|April|May|June|July|August|September|October|November|December";
		static private var _EEE : String = "Sun|Mon|Tue|Wed|Thu|Fri|Sat";
		static private var _EEEE : String = "Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday";
		static private var _A : String = "AM|PM";

		/** 월 표시 MMM 의 문자를 교체할 수 있다 */
		public static function setMMM(str : String = "Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec") : void
		{
			_MMM = str;
		}
		/** 월 표시 MMMM 의 문자를 교체할 수 있다 */
		public static function setMMMM(str : String = "January|February|March|April|May|June|July|August|September|October|November|December") : void
		{
			_MMMM = str;
		}
		/** 요일 표시 EEE 의 문자를 교체할 수 있다 */
		public static function setEEE(str : String = "Sun|Mon|Tue|Wed|Thu|Fri|Sat") : void
		{
			_EEE = str;
		}
		/** 요일 표시 EEEE 의 문자를 교체할 수 있다 */
		public static function setEEEE(str : String = "Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday") : void
		{
			_EEEE = str;
		}
		/** 오전, 오후 표시 A 의 문자를 교체할 수 있다 */
		public static function setA(str : String = "AM|PM") : void
		{
			_A = str;
		}
		public static function formatting(date : Date, format : String = "YYYY-MM-DD") : String
		{
			var str : String = format;
			var df : DateFormatter = new DateFormatter(date);
			var listA : Array = ["YYYY", "YY", "MMMM", "MMM", "MM", "M", "DD", "D", "EEEE", "EEE", "EE", "E", "A", "JJ", "J", "HH", "H", "KK", "K", "LL", "L", "NN", "N", "SS", "S"];
			var listB : Array = ["#y4#", "#y3#", "#m4#", "#m3#", "#m2#", "#m1#", "#d2#", "#d1#", "#e4#", "#e3#", "#e2#", "#e1#", "#a1#", "#j2#", "#j1#", "#h2#", "#h1#", "#k2#", "#k1#", "#l2#", "#l1#", "#n2#", "#n1#", "#s2#", "#s1#"];
			var f : int;
			var reg : RegExp;
			for (f = 0;f < listA.length; f++) {
				reg = new RegExp(listA[f], "g");
				str = str.replace(reg, listB[f]);
			}
			for (f = 0;f < listA.length; f++) {
				reg = new RegExp(listB[f], "g");
				str = str.replace(reg, df[listA[f]]);
			}
			return str;
		}

		private var _date : Date;

		public function DateFormatter(date : Date)
		{
			_date = date;
		}
		/** Date 객체 */
		public function get date() : Date
		{
			return _date;
		}
		public function set date(date : Date) : void
		{
			_date = date;
		}
		/** 1980 네자리 년도 */
		public function get YYYY() : String
		{
			return _date.fullYear.toString();
		}
		/** 80 두자리 년도 */
		public function get YY() : String
		{
			return _date.fullYear.toString().substring(2, 4);
		}
		/** 7 자릿수 고정되지 않은 월 */
		public function get M() : String
		{
			return String(_date.month + 1);
		}
		/** 07 자릿수 고정된 월 */
		public function get MM() : String
		{
			return NumberEx.fixed0(_date.month + 1);
		}
		/** 
		 * 짧은 영문형 월 (Jan, Feb ~ Dec) setMMM() 을 통해 교체가 가능하다
		 */ 
		public function get MMM() : String
		{
			var arr : Array = _MMM.split("|");
			return arr[_date.month];
		}
		/** 
		 * 긴 영문형 월 (January, February ~ December) setMMMM() 을 통해 교체가 가능하다
		 */
		public function get MMMM() : String
		{
			var arr : Array = _MMMM.split("|");
			return arr[_date.month];
		}
		/** 5 자릿수 고정되지 않은 일 */
		public function get D() : String
		{
			return _date.date.toString();
		}
		/** 05 자릿수 고정되지 않은 일 */
		public function get DD() : String
		{
			return NumberEx.fixed0(_date.date);
		}
		/** 0 숫자형의 요일표시 */
		public function get E() : String
		{
			return _date.day.toString();
		}
		/** 00 고정된 숫자의 요일표시 */
		public function get EE() : String
		{
			return NumberEx.fixed0(_date.day);
		}
		/** 
		 * 짧은 영문형 요일 (Sun, Mon ~ Sat) setEEE() 를 통해 교체가 가능하다
		 */
		public function get EEE() : String
		{
			var arr : Array = _EEE.split("|");
			return arr[_date.day];
		}
		/** 
		 * 긴 영문형 요일 (Sunday, Monday ~ Saturday) setEEEE() 를 통해 교체가 가능하다
		 */
		public function get EEEE() : String
		{
			var arr : Array = _EEEE.split("|");
			return arr[_date.day];
		}
		/** 
		 * 영문형 오전, 오후 표시 (AM, PM) setA() 를 통해 교체가 가능하다
		 */
		public function get A() : String
		{
			var arr : Array = _A.split("|");
			return (_date.hours < 12) ? arr[0] : arr[1]; 
		}
		/** 0 ~ 23 시간 표시 */
		public function get J() : String
		{
			return _date.hours.toString();
		}
		/** 00 ~ 23 고정된 시간 표시 */
		public function get JJ() : String
		{
			return NumberEx.fixed0(_date.hours);
		}
		/** 1 ~ 24 시간 표시 */
		public function get H() : String
		{
			return String(_date.hours + 1);
		}
		/** 01 ~ 24 고정된 시간 표시 */
		public function get HH() : String
		{
			return NumberEx.fixed0(_date.hours + 1);
		}
		/** 0 ~ 11 시간 표시 */
		public function get K() : String
		{
			return String(_date.hours % 12);
		}
		/** 00 ~ 11 고정된 시간 표시 */
		public function get KK() : String
		{
			return NumberEx.fixed0(_date.hours % 12);
		}
		/** 1 ~ 12 시간 표시 */
		public function get L() : String
		{
			return String((_date.hours % 12) + 1);
		}
		/** 01 ~ 12 고정된 시간 표시 */
		public function get LL() : String
		{
			return NumberEx.fixed0((_date.hours % 12) + 1);
		}
		/** 0 ~ 59 분 표시 */
		public function get N() : String
		{
			return _date.minutes.toString();
		}
		/** 0 ~ 59 고정된 분 표시 */
		public function get NN() : String
		{
			return NumberEx.fixed0(_date.minutes);
		}
		/** 0 ~ 59 초 표시 */
		public function get S() : String
		{
			return _date.seconds.toString();
		}
		/** 0 ~ 59 고정된 초 표시 */
		public function get SS() : String
		{
			return NumberEx.fixed0(_date.seconds);
		}
	}
}
