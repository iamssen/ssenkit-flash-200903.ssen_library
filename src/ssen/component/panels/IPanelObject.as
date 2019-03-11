package ssen.component.panels 
{
	import ssen.component.base.ISSenComponent;
	import ssen.core.display.ISprite;		
	/**
	 * PanelObject 의 Interface
	 * @author SSen
	 */
	public interface IPanelObject extends ISSenComponent, ISprite
	{
		/** message 나 module 이 될 Object */
		function get options() : Object;
		function set options(options : Object) : void;
		/** alert, confirm, prompt 등의 panelMode */
		function get panelMode() : String;
		function set panelMode(panelMode : String) : void;
		/** confirm 에서 ok 를 클릭할때 callback function */
		function get okCallback() : Function;
		function set okCallback(callbak : Function) : void;
		/** confirm, prompt 에서 cancel 를 클릭할때 callback function */
		function get cancelCallback() : Function;
		function set cancelCallback(callbak : Function) : void;
		/** 최상위 인덱스로 끌어올린다 */
		function topIndex() : void;
		/** 셋팅을 마치고 초기화를 진행한다 */
		function initialize() : void;
	}
}
