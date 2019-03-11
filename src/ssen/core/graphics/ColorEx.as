package ssen.core.graphics 
{
	/**
	 * Color Utils
	 * @author SSen
	 */
	public class ColorEx 
	{
		/** 
		 * rgb 를 [r,g,b] 로 분리한다.
		 * @param rgb 대상 rgb
		 */
		public static function parseRGB(rgb : uint) : Vector.<uint>
		{
			var vec : Vector.<uint> = new Vector.<uint>();
			vec.push((rgb & 0xff0000) >> 16);
			vec.push((rgb & 0x00ff00) >> 8);
			vec.push((rgb & 0x0000ff));
			
			return vec;
		}
		/**
		 * [r,g,b] 를 rgb 로 결합한다.
		 * @param r red
		 * @param g green
		 * @param b blue
		 */
		public static function deparseRGB(r : uint, g : uint, b : uint) : uint
		{
			var rgb : uint = r;
			rgb = g + (rgb << 8);
			rgb = b + (rgb << 8);
			
			return rgb;
		}
		/**
		 * rgb 와 rgb 사이의 gradation color 들을 뽑아낸다.
		 * @param start 시작색
		 * @param end 끝색
		 * @param division 나눌 단계수
		 * @param ease Easing function
		 */
		public static function gradate(start : uint, end : uint, division : int, ease : Function) : Vector.<uint>
		{
			var s1 : Vector.<uint> = parseRGB(start);
			var e1 : Vector.<uint> = parseRGB(end);
			e1[0] = e1[0] - s1[0];
			e1[1] = e1[1] - s1[1];
			e1[2] = e1[2] - s1[2];
			var out : Vector.<uint> = new Vector.<uint>();
			var division2 : int = division - 1;
			var f : int;
			var r : uint;
			var g : uint;
			var b : uint;
			
			for (f = 0;f < division; f++) {
				r = ease(f, s1[0], e1[0], division2);
				g = ease(f, s1[1], e1[1], division2);
				b = ease(f, s1[2], e1[2], division2);
				out.push(deparseRGB(r, g, b));
			}
			
			return out;
		}
	}
}
