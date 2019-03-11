package ssen.core.text
{
	/**
	 * String Extension
	 * @author SSen
	 */
	public class StringEx
	{
		/**
		 * 특정 문자를 모두 교체해준다
		 * @param original 바꿔줄 문자 ex "남자"
		 * @param replace 바꿀 문자 ex "여자"
		 * @param target 바꿔줄 대상 문자열
		 */
		public static function replace(original : String, replace : String, target : String) : String
		{
			var originalReg : RegExp = new RegExp(original, "g");
			return target.replace(originalReg, replace);
		}
		/**
		 * callback 을 통해서 정규식 문자열을 처리한다
		 * @param regStr 정규식 대상 문자
		 * @param callback 콜백함수
		 * @param target 바꿔줄 대상 문자열
		 */
		public static function regex_callback(regStr : String, callback : Function, target : String) : String
		{
			var sets : Array = target.match(new RegExp(regStr, "g"));
			var regEx : RegExp = new RegExp(regStr, "");

			for each(var f:* in sets) {
				var obj : Object = regEx.exec(f);
				var parsed : String = callback(obj);
				var regChange : RegExp = new RegExp(obj[0], "");
				trace("SSEN//", regStr, obj, f, parsed);
				target = target.replace(regChange, parsed);
			}

			return target;
		}
		/**
		 * 공백을 제거한다.
		 * @param original 바꿔줄 문자
		 */
		public static function removeBlank(original : String) : String
		{
			var strs : Array = original.split("");
			var s : String = "";
			var ch : String;
			for each (ch in strs) {
				if (ch != " ") {
					s += ch;
				}
			}
			return s;
		}
	}
}