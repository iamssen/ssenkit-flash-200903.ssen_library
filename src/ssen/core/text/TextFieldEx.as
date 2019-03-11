package ssen.core.text 
{
	import flash.text.TextField;	
	/**
	 * Text Utilities
	 * @author SSen
	 */
	public class TextFieldEx 
	{
		/**
		 * TextField 의 영역을 벗어나는 문자를 축약 처리한다.
		 * @param textField 대상 TextField
		 * @param replaceText 축약을 대체할 문자열
		 * @param replaceWidth 끝에서 얼마만큼의 가로길이를 축약할 것인지
		 */
		public static function replaceOverText(textField : TextField, replaceText : String = "...", replaceWidth : int = 15) : void
		{
			var maxX : Number = 0;
			var maxY : Number = 4;
			var replace : Boolean = false;
			if (!textField.multiline) {
				if (textField.textWidth - replaceWidth > textField.width) {
					maxX = textField.width - replaceWidth;
					maxY = textField.getLineMetrics(0).height >> 1;
					replace = true;
				}
			} else {
				var i : int;
				var metricHeight : Number;
				for (i = 0;i < textField.numLines; i++) {
					metricHeight = textField.getLineMetrics(i).height;
					if (maxY + metricHeight < textField.height) {
						maxY += metricHeight;
					} else {
						maxX = textField.width - replaceWidth;
						maxY -= 10;
						replace = true;
						break;
					}
				}
			}
			if (replace) {
				var end : int = textField.getCharIndexAtPoint(maxX, maxY);
				if (end > 0) {
					textField.replaceText(end, textField.length, replaceText);
				}
			}
		}
	}
}
