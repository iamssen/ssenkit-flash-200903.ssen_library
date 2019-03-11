package ssen.core.skinObject 
{
	import ssen.core.skinObject.ISkinObject;

	import flash.display.FrameLabel;
	import flash.display.MovieClip;	
	/**
	 * flash MovieClip 에 연결해서 사용할 수 있다.
	 * @author SSen
	 */
	public class McSkinMovieClip extends MovieClip implements ISkinObject 
	{
		public function McSkinMovieClip()
		{
			stop();
		}
		public function skinning(modeName : String = "default") : void
		{
			if (currentLabel != modeName) {
				gotoAndStop(modeName);
			}
		}
		public function get flag() : String
		{
			return currentLabel;
		}
		public function get skinList() : Array
		{
			var list : Array = new Array();
			var labels : Array = currentLabels;
			var label : FrameLabel;

			for (var i : uint = 0;i < labels.length; i++) {
				label = labels[i];
				list.push(label.name);
			}
			
			return list;
		}	
	}
}
