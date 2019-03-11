package ssen.debug 
{
	import ssen.core.display.SSenSprite;				
	/**
	 * 간단한 입력으로 TestButton 을 여러개 사용할 수 있다.
	 * @author SSen
	 */
	public class TestButtonGroup extends SSenSprite 
	{
		private var _width : Number;
		private var _group : Vector.<TestButton>;

		/**
		 * 새로운 TestButtonGroup 을 생성함
		 * @param test 홀수 인자는 테스트 제목, 짝수 인자는 테스트 함수로 입력해야 한다
		 */
		public function TestButtonGroup(...test)
		{
			_group = new Vector.<TestButton>();
			_width = 450;
			
			var f : int;
			var btn : TestButton;
			for (f = 0;f < test.length; f += 2) {
				btn = new TestButton(test[f], test[f + 1]);
				addChild(btn);
				_group.push(btn);
			}
			
			align();
		}
		/** @private */
		override public function get width() : Number
		{
			return _width;
		}
		override public function set width(width : Number) : void
		{
			_width = width;
			align();
		}
		/** @private */
		override public function set height(height : Number) : void
		{
			trace("SSEN// TestButtonGroup 은 height 를 조절할 수 없습니다.", height);
		}
		/**
		 * 새로운 테스트들을 추가한다
		 * @param test 홀수 인자는 테스트 제목, 짝수 인자는 테스트 함수로 입력해야 한다
		 */
		public function addTest(...test) : void
		{
			var f : int;
			var btn : TestButton;
			for (f = 0;f < test.length; f += 2) {
				btn = new TestButton(test[f], test[f + 1]);
				addChild(btn);
				_group.push(btn);
			}
			
			align();
		}
		// 정렬
		private function align() : void
		{
			var f : int;
			var pre : TestButton;
			var btn : TestButton;
			for (f = 1;f < _group.length;f++) {
				pre = _group[f - 1];
				btn = _group[f];
				
				if (pre.nextX() + btn.width + 5 > _width) {
					btn.x = 0;
					btn.y = pre.nextY(5);
				} else {
					btn.position = pre.nextPosition();
				}
			}
		}
	}
}
