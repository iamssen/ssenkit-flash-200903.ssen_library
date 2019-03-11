package ssen.core.motion 
{
	import flash.geom.Point;
	/**
	 * 3차 베지어 포인트를 계산한다
	 * @author SSen
	 */
	public class BezierPointCubic 
	{
		private var _p1 : Point;
		private var _p2 : Point;
		private var _c1 : Point;
		private var _c2 : Point;

		public function BezierPointCubic(p1 : Point, p2 : Point, c1 : Point, c2 : Point)
		{
			_p1 = p1;
			_p2 = p2;
			_c1 = c1;
			_c2 = c2;
		}
		/** 시작점 */
		public function get p1() : Point
		{
			return _p1;
		}
		public function set p1(p1 : Point) : void
		{
			_p1 = p1;
		}
		/** 끝점 */
		public function get p2() : Point
		{
			return _p2;
		}
		public function set p2(p2 : Point) : void
		{
			_p2 = p2;
		}
		/** 곡점 1 */
		public function get c1() : Point
		{
			return _c1;
		}
		public function set c1(c1 : Point) : void
		{
			_c1 = c1;
		}
		/** 곡점 2 */
		public function get c2() : Point
		{
			return _c2;
		}
		public function set c2(c2 : Point) : void
		{
			_c2 = c2;
		}
		/**
		 * 시간점에 따른 베지어 포인트를 계산한다
		 * @param now 현재 시간점
		 * @param total 총 시간
		 */
		public function getPoint(now : int, total : int) : Point
		{
			var p : Point = new Point();
			var s : Number = now / total;
			var s1 : Number = 1 - s;
			
			p.x = _getPoint(_p1.x, _p2.x, _c1.x, _c2.x, s, s1);
			p.y = _getPoint(_p1.y, _p2.y, _c1.y, _c2.y, s, s1);
			
			return p;
		}
		// 계산기
		private function _getPoint(p1 : Number, p2 : Number, c1 : Number, c2 : Number, s : Number, s1 : Number) : Number
		{
			return s1 * s1 * s1 * p1 + 3 * s * s1 * s1 * c1 + 3 * s * s * s1 * c2 + s * s * s * p2;
		}
	}
}
