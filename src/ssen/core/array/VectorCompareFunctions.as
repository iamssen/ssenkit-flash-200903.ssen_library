package ssen.core.array 
{
	import ssen.core.number.MathEx;
	/**
	 * Vector 를 사용하는데 있어 필요한 기능들
	 * @author SSen
	 */
	public class VectorCompareFunctions
	{
		/** sort compare function : 무작위로 섞는다 */
		public static function SHAKE(a : Number, b : Number) : Number
		{
			return MathEx.rand(0, 1000000);
		}
		/** sort compare function : 숫자형을 역순정렬 한다 */
		public static function DESC_NUMBER(a : Number, b : Number) : Number
		{
			return b - a;
		}
		/** sort compare function : 숫자형을 순정렬 한다 */
		public static function ASC_NUMBER(a : Number, b : Number) : Number
		{
			return a - b;
		}
		/** sort compare function : 문자형을 역순정렬 한다 */
		public static function DESC_STRING(a : String, b : String) : Number
		{
			var a1 : int;
			var b1 : int;
			var i : int = 0;
			while (true) {
				a1 = a.charCodeAt(i);
				b1 = b.charCodeAt(i);
				if (b1 - a1 != 0) {
					return b1 - a1;
				} else {
					i++;
				}
			}
			return 0;
		}
		/** sort compare function : 문자형을 순정렬 한다 */
		public static function ASC_STRING(a : String, b : String) : Number
		{
			var a1 : int;
			var b1 : int;
			var i : int = 0;
			while (true) {
				a1 = a.charCodeAt(i);
				b1 = b.charCodeAt(i);
				if (a1 - b1 != 0) {
					return a1 - b1;
				} else {
					i++;
				}
			}
			return 0;
		}
	}
}
