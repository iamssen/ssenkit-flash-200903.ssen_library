package ssen.core.array 
{
	import ssen.core.number.MathEx;		
	/**
	 * Array Extension
	 * @author SSen
	 */
	public class ArrayEx
	{
		/** 벡터를 배열로 변환한다 */
		static public function vectorToArray(vec : Object) : Array
		{
			var arr : Array = new Array();
			var i : int;
			for (i = 0;i < vec.length; i++) {
				arr.push(vec[i]);
			}
			return arr; 
		}
		/**
		 * 배열을 무작위로 섞는다.
		 * @param arr 원본 배열
		 */
		static public function shake(arr : Array) : Array 
		{
			var fixed : Array = new Array();
			var out : Array = new Array();
			var bool : Boolean = true;
			while(bool) {
				var r : int = MathEx.rand(0, arr.length - 1);
				if (!findElement(r, fixed)) {
					fixed.push(r);
					out.push(arr[r]);
					if (arr.length == out.length) {
						bool = false;
					}
				}
			}
			return out;
		}
		/**
		 * 배열안에 특정 요소가 있는지 확인한다.
		 * @param el 검색할 요소
		 * @param arr 대상 배열
		 */
		static public function findElement(el : *, arr : Array) : Boolean 
		{
			var bool : Boolean = false;
			for each (var x:* in arr) {
				if (el == x) {
					bool = true;
				}
			}
			return bool;
		}
		/**
		 * 배열안에 특정 요소를 삭제한다.
		 * @param el 삭제할 요소
		 * @param arr 대상 배열
		 */
		public static function delElement(el : *, arr : Array) : Array 
		{
			var f : *;
			var out : Array = new Array();

			for each (f in arr) {
				if (f !== el) {
					out.push(f);
				}
			}
			return out;
		}
		/**
		 * 배열의 요소의 갯수를 센다.
		 * @param arr 대상 배열
		 */
		public static function n(arr : Array) : int 
		{
			var f : *;
			var cnt : int = 0;

			for each (f in arr) {
				cnt++;
				trace("SSEN//", String(f));
			}

			return cnt;
		}
		/**
		 * 교집합, 두 집합간의 공통항목을 반환한다.
		 */
		public static function setsIntersection(...sets) : Array 
		{
			var f : *;
			var s : *;
			var cnt : int;
			var setX : Array = sets[0];
			var target : Array;
			var temp : Array;
			
			for (cnt = 1;cnt <= sets.length - 1; cnt++) {
				target = sets[cnt];
				temp = new Array();
				for each (f in target) {
					for each (s in setX) {
						if (f === s && !findElement(s, temp)) {
							temp.push(s);
							break;
						}
					}
				}
				setX = temp;
			}
			
			return setX;
		}
		/**
		 * 합집합, 두 집합의 요소를 합해서 반환한다 (공통항목은 병합)
		 */
		public static function setsSum(...sets) : Array 
		{
			var f : *;
			var s : *;
			var cnt : int;
			var same : Boolean;
			var setX : Array = sets[0];
			var target : Array;
			
			for (cnt = 1;cnt <= sets.length - 1; cnt++) {
				target = sets[cnt];
				for each (f in target) {
					same = false;
					for each (s in setX) {
						if (f === s) {
							same = true;
						}
					}
					if (!same) {
						setX.push(f);
					}
				}
			}
			
			return setX;
		}
		/**
		 * 차집합, 집합A 에서 집합B 를 뺀 후 반환한다.
		 * @param setA 기준 집합체
		 * @param setB 삭제할 대상들의 집합
		 */
		public static function setsDifference(setA : Array, setB : Array) : Array 
		{
			var f : *;
			var s : *;
			var setX : Array = new Array();

			for each (f in setA) {
				var same : Boolean = false;

				for each (s in setB) {
					if (f === s) {
						same = true;
					}
				}

				if (!same) {
					setX.push(f);
				}
			}

			return setX;
		}
		/**
		 * 여집합, 전체가 될 유한집합에서 부분집합B 를 제외한 부분을 반환한다.
		 * @param setU 기준이 되는 전체집합
		 * @param setB 제외될 부분집합
		 */
		public static function setsComplementary(setU : Array, setB : Array) : Array 
		{
			setB = setsIntersection(setU, setB);

			var f : *;
			var s : *;
			var setX : Array = new Array();

			for each (f in setU) {
				var same : Boolean = false;

				for each (s in setB) {
					if (f === s) {
						same = true;
					}
				}

				if (!same) {
					setX.push(f);
				}
			}

			return setX;
		}
	}
}