package ssen.debug
{
	/**
	 * RegExp 를 작업하는데 필요한 디버그 도구
	 * @author SSen
	 */
	public class DebugRegExp 
	{
		/** 특정 문자가 메타캐릭터 인지 확인한다 */
		public static function isMetaCharacter(char : String) : Boolean
		{
			switch (char) {
				case "/" : 
					;
				case "^" : 
					;
				case "$" : 
					;
				case "." : 
					;
				case "*" : 
					;
				case "+" : 
					;
				case "?" : 
					;
				case "(" : 
					;
				case ")" : 
					;
				case "[" : 
					;
				case "]" : 
					;
				case "{" : 
					;
				case "}" : 
					;
				case "|" : 
					return true; 
					break;
				default : 
					return false; 
					break;
			}              
		}
	}
}
