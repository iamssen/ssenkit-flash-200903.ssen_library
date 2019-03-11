package ssen.core.date
{
	import ssen.core.number.NumberEx;	
	/**
	 * Date Extension
	 * @author SSen
	 */	
	public class DateEx
	{
		/** 12개월의 마지막 날들을 저장 */
		static public const LAST_DAYS : Array = [31,28,31,30,31,30,31,31,30,31,30,31];
		/** microtime 1000 */
		static public const MICROTIME_1SECOND : int = 1000;
		/** microtime 1000 * 60 */
		static public const MICROTIME_1MINUTE : int = 60000;
		/** microtime 1000 * 60 * 60 */
		static public const MICROTIME_1HOUR : int = 3600000;
		/** microtime 1000 * 60 * 60 * 24 */
		static public const MICROTIME_1DAY : int = 86400000;
		/** microtime 1000 * 60 * 60 * 24 * 7 */
		static public const MICROTIME_1WEEK : int = 604800000;

		/** 오늘 날짜 Date 타입 반환 */
		static public function today() : Date
		{
			var date : Date = new Date();
			return date;
		}
		/** date 객체를 19800721 형식으로 바꾼다 */
		public static function dateToYyyymmdd(date : Date) : int
		{
			return (date.fullYear * 10000) + ((date.month + 1) * 100) + (date.date);
		}
		/** 
		 * date 객체를 1980-07-21 형식으로 바꾼다
		 * @param delimiter 끼워넣을 중간 구분자
		 */
		public static function dateToDelimiter(date : Date, delimiter : String = "-") : String
		{
			var str : String = String(date.fullYear);
			str += delimiter;
			str += NumberEx.fixed0(date.month + 1);
			str += delimiter;
			str += NumberEx.fixed0(date.date);
			return str;
		}
		/**
		 * date 객체를 ["1980", "07", "21"] 형식으로 바꾼다
		 */
		public static function dateToStrings(date : Date) : Array
		{
			var str : String = dateToDelimiter(date);
			var arr : Array = str.split("-");
			return arr;
		}
		/**
		 * date 객체를 [1980, 7, 21] 형식으로 바꾼다
		 */
		public static function dateToNumbers(date : Date) : Array
		{
			var arr : Array = dateToStrings(date);
			return [Number(arr[0]), Number(arr[1]), Number(arr[2])];
		}
		/**
		 * 19800721 형식을 date 객체로 바꾼다
		 */
		public static function dateFromYyyymmdd(yyyymmdd : int) : Date
		{
			var str : String = yyyymmdd.toString();
			return toDate(str.substring(0, 4), str.substring(4, 6), str.substring(6, 8));
		}
		/**
		 * 1980-07-21 형식을 date 객체로 바꾸다
		 * @param delimiter 끼워넣을 중간 구분자
		 */
		public static function dateFromDelimiter(dateString : String, delimiter : String) : Date
		{
			var arr : Array = dateString.split(delimiter);
			return toDate(arr[0], arr[1], arr[2]);
		}
		// String 이나 Number 로 된 구성들을 date 로 바꿔서 리턴한다.		
		private static function toDate(year : Object, month : Object, day : Object) : Date
		{
			var date : Date = new Date();
			date.fullYear = Number(year);
			date.month = Number(month);
			date.date = Number(day);
			return date;
		}
		/**
		 * Date1 과 Date2 사이가 몇 달 인지 확인한다.
		 */
		public static function periodMonth(start : Date, end : Date) : int
		{
			return ((end.fullYear - start.fullYear) * 12) + ((end.month - start.month));
			/*
			 * 증명
			 * 10 --> 11월 부터
			 * 11, 12, 1, 2, 3, 4, 5 = 7개월
			 */
		}
		/**
		 * Date1 과 Date2 사이의 microtime 차를 확인한다.
		 * @see #MICROTIME_1SECOND
		 */
		public static function periodMicroTime(start : Date, end : Date) : int
		{
			return end.time - start.time;
		}
		/** Date1 과 Date2 사이에 몇번의 월납일이 발생하는지 체크 */
		public static function monthlyInstallmentCount(start : Date, end : Date, day : int) : int
		{
			// 몇달 차이인지 계산하고, 최초월 스스로를 계산해 넣기 위해 1을 더한다
			var x : int = periodMonth(start, end) + 1;
			// d1 최초일이 이미 지났다면 1을 빼고
			if (start.date < day) x--; 
			// d2 의 마감일이 날보다 작아 그 이전에 먼저 끝난다면 1을 더 뺀다
			if (end.date < day) x--; 
			return x;
		}
		/** Date1 에서부터 특정 횟수의 월납금을 낼 때, 월납이 끝나는 날 */
		public static function mothlyInstallmentEnd(start : Date, day : int, much : int) : Date
		{
			var end : Date = new Date(start.fullYear, start.month, day);
			// d1 의 날짜가 이미 지나갔으면 (end 보다 더 크다면) 월을 다음달로 넘긴다
			if (start.date > end.date) end.month++;
			// 최초월 스스로를 카운트 해야 하기 때문에 1을 뺀다
			end.month += much - 1;
			return end;
		}
	}
}