package ssen.core.convert 
{
	import ssen.core.text.SSenTextField;
	import ssen.core.text.TextStyle;		
	/**
	 * string, textfield 에 관련된 object 들을 변환시키는 유틸
	 * @author SSen
	 */
	public class TextConverter 
	{
		/**
		 * 문자열을 TextField 로 변환시킨다
		 * @param string 문자열
		 * @param html 문자열이 HTML 형식인지 판별
		 * @param textStyle 문자스타일
		 * @param multiline 여러줄일지 판별
		 * @param wordWrap 
		 */
		public static function stringToTextField(string : String, width : int = 400, height : int = 200, textStyle : TextStyle = null, html : Boolean = false, multiline : Boolean = true, wordWrap : Boolean = true) : SSenTextField
		{
			var txt : SSenTextField = new SSenTextField();
			if (html) {
				txt.htmlText = string;
			} else {
				txt.text = string;
			}
			txt.multiline = multiline;
			txt.wordWrap = wordWrap;
			txt.width = width;
			txt.height = height;
			if (textStyle != null) {
				txt.defaultTextFormat = textStyle;
			}
			return txt;
		}
	}
}
