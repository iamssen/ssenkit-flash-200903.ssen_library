package  
test.core{
	import ssen.core.display.SSenSprite;
	import ssen.debug.TestButtonGroup;	
	/**
	 * @author SSen
	 */
	public class TestButtonTest extends SSenSprite 
	{
		public function TestButtonTest()
		{
			super();
			
			var test : TestButtonGroup = new TestButtonGroup("aaa", t1f, "bbb", t1f, "ccc", t1f, "ddd", t1f, "eeeeeee", t1f);
			test.x = test.y = 10;
			test.addTest("ffffff", t1f, "ggggggggggg", t1f, "cccccccccccccccc", t1f);
			addChild(test);
		}
		private function t1f() : void
		{
			trace("???");
		}
	}
}
