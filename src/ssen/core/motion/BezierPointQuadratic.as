package ssen.core.motion 
{
	import flash.geom.Point;
	/**
	 * 2차 베지어 포인트를 계산한다
	 * @author SSen
	 */
	public class BezierPointQuadratic 
	{
		private var _p1 : Point;
		private var _p2 : Point;
		private var _c : Point;

		public function BezierPointQuadratic(p1 : Point, p2 : Point, c : Point)
		{
			_p1 = p1;
			_p2 = p2;
			_c = c;
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
		/** 곡점 */
		public function get c() : Point
		{
			return _c;
		}
		public function set c(c : Point) : void
		{
			_c = c;
		}
		/**
		 * 시간점에 따른 베지어 포인트를 계산한다
		 * @param now 현재 시간점
		 * @param total 총 시간
		 */
		public function getPoint(now : int, all : int) : Point
		{			
			var p : Point = new Point();			
			var s : Number = now / all;
			var s1 : Number = 1 - s;
			
			p.x = _getPoint(_p1.x, _p2.x, _c.x, s, s1);
			p.y = _getPoint(_p1.y, _p2.y, _c.y, s, s1);
			
			return p;
		}
		// 계산기
		private function _getPoint(p1 : Number, p2 : Number, c : Number, s : Number, s1 : Number) : Number
		{			
			return p1 * s1 * s1 + c * 2 * s * s1 + p2 * s * s;
		}
	}
}
