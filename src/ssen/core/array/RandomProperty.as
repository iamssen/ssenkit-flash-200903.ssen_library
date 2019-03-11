package ssen.core.array 
{
	import ssen.core.array.ArrayEx;
	import ssen.core.number.MathEx;	
	/**
	 * 리스트를 구성하고, 리스트 중 랜덤한 하나를 뽑아쓴다.
	 * @author SSen
	 */
	public class RandomProperty
	{
		private var _arr : Array;
		private var _excludeList : Array;

		public function RandomProperty(...args : Array)
		{
			_arr = args;
			_excludeList = new Array();
		}
		/**
		 * 요소를 랜덤하게 가져온다
		 * @param exclude 가져온 요소를 제외리스트에 포함시킬지를 결정한다
		 */
		public function random(exclude : Boolean = false) : *
		{
			var rand : int;
			var bool : Boolean = true;
			while (bool) {
				rand = MathEx.rand(0, _arr.length - 1);
				if (!isExclude(rand)) {
					bool = false;
					if (exclude) addExclude(rand);
					return _arr[rand];
				}
			}
		}
		/**
		 * 배열의 키넘버를 제외리스트에 포함시킨다
		 */
		public function addExclude(num : int) : void
		{
			if (!isExclude(num) && num < _arr.length) {
				_excludeList.push(num);
				if (_excludeList.length >= _arr.length) {
					trace("SSEN// arr 의 모든 구성원이 excludeList 에 등록되어서 excludeList 를 초기화시켜줍니다.");
					clearExcludeList();
				}
			}
		}
		/**
		 * 배열의 키넘버를 제외리스트에서 제외시킨다
		 */
		public function removeExclude(num : int) : void
		{
			_excludeList = ArrayEx.delElement(num, _excludeList);
		}
		/**
		 * 제외리스트를 초기화시킨다
		 */
		public function clearExcludeList() : void
		{
			_excludeList = new Array();
		}
		/**
		 * 특정 키넘버가 제외리스트에 포함되어 있는지 확인한다
		 */
		public function isExclude(num : int) : Boolean
		{
			var i : int;
			for (i = 0;i < _arr.length; i++) {
				if (_excludeList[i] == num) {
					return true;
				}
			}
			return false;
		}
		/**
		 * 제외리스트를 가져온다
		 */
		public function get excludeList() : Array
		{
			return _excludeList;
		}
		/**
		 * 제외리스트를 바꿔준다
		 */
		public function setExcludeList(excludeList : Array) : void
		{
			_excludeList = excludeList;
		}
	}
}
