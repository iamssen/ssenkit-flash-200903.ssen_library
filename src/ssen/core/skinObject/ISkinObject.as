package ssen.core.skinObject 
{
	import ssen.core.display.IDisplayObject;		
	/**
	 * SkinMode 를 가지는 Object 들의 interface
	 * @author SSen
	 */
	public interface ISkinObject extends IDisplayObject
	{
		/** skin 을 교체한다 */
		function skinning(modeName : String = "default") : void;
		/** skin 의 현재 상태를 본다 */
		function get flag() : String;
		/** 포함된 skin mode 들을 본다 */
		function get skinList() : Array;
	}
}
