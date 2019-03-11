package ssen.core.geom
{ 
	/**
	 * Constants : position 상수모음
	 * @author SSen
	 */
	public class Position9 
	{
		/** 상단 좌측 */
		static public const TL : String = "topLeft";
		/** 상단 중앙 */
		static public const TC : String = "topCenter";
		/** 상단 우측 */
		static public const TR : String = "topRight";
		/** 중단 좌측 */
		static public const ML : String = "middleLeft";
		/** 중앙 */
		static public const MC : String = "middleCenter";
		/** 중단 우측 */
		static public const MR : String = "middleRight";
		/** 하단 좌측 */
		static public const BL : String = "bottomLeft";
		/** 하단 중앙 */
		static public const BC : String = "bottomCenter";
		/** 하단 우측 */
		static public const BR : String = "bottomRight"; 

		/** x 위치를 변환 시킨다 */
		static public function reverseX(position9 : String) : String
		{
			switch (position9) {
				case TL :
					return TR;
					break;
				case TC :
					return TC;
					break;
				case TR :
					return TL;
					break;
				case ML :
					return MR;
					break;
				case MC :
					return MC;
					break;
				case MR :
					return ML;
					break;
				case BL :
					return BR;
					break;
				case BC :
					return BC;
					break;
				case BR :
					return BL;
					break;
				default :
					return MC;
					break;
			}
		}
		/** y 위치를 변환 시킨다 */
		static public function reverseY(position9 : String) : String
		{
			switch (position9) {
				case TL :
					return BL;
					break;
				case TC :
					return BC;
					break;
				case TR :
					return BR;
					break;
				case ML :
					return ML;
					break;
				case MC :
					return MC;
					break;
				case MR :
					return MR;
					break;
				case BL :
					return TL;
					break;
				case BC :
					return TC;
					break;
				case BR :
					return TR;
					break;
				default :
					return MC;
					break;
			}
		}
	}
}
