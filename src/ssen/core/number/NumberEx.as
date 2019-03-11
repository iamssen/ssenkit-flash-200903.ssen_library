package ssen.core.number
{
	/**
	 * Number Extension
	 * @author SSen
	 */
	public class NumberEx
	{
		/**
		 * 1 을 01 혹은 001 형태로 만들어서 반환한다
		 * @param i 대상 숫자
		 * @param fixed 고정할 0 의 갯수, 2 일 경우엔 01, 3일 경우엔 001
		 */
		static public function fixed0(i : int, fixed : int = 2) : String
		{
			var x : String = String(i);
			if (x.length < fixed) {
				for (var f : int = x.length;f <= fixed - 1; f++) {
					x = "0" + x;
				}
			}
			return x;
		}
		/**
		 * 12345 의 숫자를 12,345 혹은 12,345원 형식으로 바꾸고, 0 의 경우 - 형태로도 바꿀수 있다.
		 * @param x 대상숫자
		 * @param unit 마지막에 붙일 단위 ex : 원, km, Mb
		 * @param zeroUnit 0 을 특정한 형태로 변환함 ex : -
		 */
		static public function comma(x : Object, unit : String = null, zeroUnit : String = null) : String
		{
			// dot 을 분리한다.
			var strs : Array = x.toString().split(".");

			// 파싱 시작
			var s : String = "";
			var arr : Array = strs[0].toString().split("");
			var cnt : int = 0;
			var max : int = arr.length - 1;
			for (var f : Number = max;f >= 0; f--) {
				var p : String = arr[f];
				if (cnt < 3) {
					s = p + s;
					cnt++;
				} else {
					s = p + "," + s;
					cnt = 1;
				}
			}
			
			// dot 병합 및 unit 넣기
			s = (strs[1] != undefined) ? s + "." + strs[1] : s;
			s = (zeroUnit != null) ? NumberEx.zeroUnit(s, zeroUnit) : s;
			s = (unit != null) ? s + unit : s;
			return s;
		}
		/**
		 * 123,456.45 형태의 숫자를 123456.45 로 바꿔서 돌려준다.
		 * @param x 대상숫자
		 */
		static public function commaClear(x : Object) : String
		{
			var s : String = "";
			var arr : Array = x.toString().split("");
			var ch : String;
			for each(ch in arr) {
				if (!isNaN(Number(ch)) || ch == ".") {
					s += ch;
				}
			}
			return s;
		}
		/**
		 * x 가 숫자인지 파악한다.
		 * @param x 대상숫자
		 */
		static public function isNumber(x : Object) : Boolean
		{
			var arr : Array = x.toString().split("");
			var ch : String;
			for each(ch in arr) {
				if (isNaN(Number(ch)) && ch != ".") {
					return false;
				}
			}
			return true;
		}
		/**
		 * 0 을 특정한 형태로 바꾼다
		 * @param i 대상 숫자, 혹은 문자
		 * @param unit 0을 특정한 형태로 변환 ex : -
		 */
		static public function zeroUnit(i : Object, unit : String) : String
		{
			var out : String;
			if (Number(i) == 0) {
				out = unit;
			} else {
				out = i.toString();
			}
			return out;
		}
	}
}