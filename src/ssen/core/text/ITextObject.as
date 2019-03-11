package ssen.core.text 
{
	import ssen.core.display.IInteractiveObject;		
	/**
	 * Text 의 형태를 띈 Object
	 * @author SSen
	 */
	public interface ITextObject extends IInteractiveObject
	{
		/** TextObject 의 문자 수 */
		function get length() : int;
		/** TextObject 의 문자 */
		function get text() : String;
		function set text(value : String) : void;
		/** TextObject 문자의 끝에 새로운 문자를 추가한다 */
		function appendText(newText : String) : void;
		/** 지정된 구간의 문자를 새로운 문자로 교체한다 */
		function replaceText(beginIndex : int, endIndex : int, newText : String) : void;
	}
}
