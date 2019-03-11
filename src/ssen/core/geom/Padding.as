package ssen.core.geom 
{
	import ssen.core.events.PaddingEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;	
	/**
	 * 공간속의 여백을 조절한다
	 * @author SSen
	 */
	public class Padding implements IEventDispatcher 
	{
		private var _top : Number;
		private var _right : Number;
		private var _bottom : Number;
		private var _left : Number;
		private var _dispatcher : EventDispatcher;

		public function Padding(top : Number = 0, right : Number = 0, bottom : Number = 0, left : Number = 0)
		{
			_dispatcher = new EventDispatcher();
			
			_top = top;
			_right = right;
			_bottom = bottom;
			_left = left;
		}
		/** clone */
		public function clone() : Padding
		{
			return new Padding(_top, _right, _bottom, _left);
		}
		/** top */
		public function get top() : Number
		{
			return _top;
		}
		public function set top(top : Number) : void
		{
			setPadding(top, _right, _bottom, _left);
		}
		/** right */
		public function get right() : Number
		{
			return _right;
		}
		public function set right(right : Number) : void
		{
			setPadding(_top, right, _bottom, _left);
		}
		/** bottom */
		public function get bottom() : Number
		{
			return _bottom;
		}
		public function set bottom(bottom : Number) : void
		{
			setPadding(_top, _right, bottom, _left);
		}
		/** left */
		public function get left() : Number
		{
			return _left;
		}
		public function set left(left : Number) : void
		{
			setPadding(_top, _right, _bottom, left);
		}
		/** padding 요소들을 한꺼번에 수정한다 */
		public function setPadding(top : Number, right : Number, bottom : Number, left : Number) : void
		{
			_top = top;
			_right = right;
			_bottom = bottom;
			_left = left;
			dispatchEvent(new PaddingEvent(PaddingEvent.PADDING_CHANGE, _top, _right, _bottom, _left));
		}
		/** 
		 * Object 가 위치해야 할 x, y 좌표 point 를 계산한다
		 * @param position 썸네일의 위치
		 * @param containerWidth 썸네일이 위치할 박스의 가로 크기
		 * @param containerHeight 썸네일이 위치할 박스의 세로 크기
		 * @param objectWidth 썸네일의 가로 크기
		 * @param objectHeight 썸네일의 세로 크기
		 */ 
		public function getPosition(position : String, containerWidth : Number, containerHeight : Number, objectWidth : Number, objectHeight : Number) : Point
		{
			var x : int;
			var y : int;
			
			switch (position) {
				case Position9.TL :
				case Position9.ML :
				case Position9.BL :
					x = left;
					break;
				case Position9.TC :
				case Position9.MC :
				case Position9.BC :
					x = (containerWidth >> 1) - (objectWidth >> 1);
					break;
				case Position9.TR :
				case Position9.MR :
				case Position9.BR :
					x = containerWidth - right - objectWidth;
					break;
			}
			switch (position) {
				case Position9.TL :
				case Position9.TC :
				case Position9.TR :
					y = top;
					break;
				case Position9.ML :
				case Position9.MC :
				case Position9.MR :
					y = (containerHeight >> 1) - (objectHeight >> 1);
					break;
				case Position9.BL :
				case Position9.BC :
				case Position9.BR :
					y = containerHeight - bottom - objectHeight;
					break;
			}
			
			return new Point(x, y);
		}
		/** toString */
		public function toString() : String
		{
			return '[Padding top="' + _top + '" right="' + _right + '" bottom="' + _bottom + '" left="' + _left + '"]';
		}
		/*
		 * implement IEventDispatcher
		 */
		public function dispatchEvent(event : Event) : Boolean
		{
			return _dispatcher.dispatchEvent(event);
		}
		public function hasEventListener(type : String) : Boolean
		{
			return _dispatcher.hasEventListener(type);
		}
		public function willTrigger(type : String) : Boolean
		{
			return _dispatcher.willTrigger(type);
		}
		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			_dispatcher.removeEventListener(type, listener, useCapture);
		}
		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		} 
	}
}
