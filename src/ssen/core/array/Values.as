package ssen.core.array 
{
	import ssen.core.array.ArrayEx;
	import ssen.core.events.ValueEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.utils.getQualifiedClassName;	
	
	use namespace flash_proxy;
	/**
	 * Array 나 Vector 보다 기능이 풍부함, 단 무거울수 있음
	 * @author SSen
	 */
	public dynamic class Values extends Proxy implements IEventDispatcher 
	{
		private var _dispatcher : EventDispatcher;
		private var _values : Array;
		private var _names : Array;

		public function Values()
		{
			_dispatcher = new EventDispatcher();
			_values = new Array();
			_names = new Array();
		}
		/** for in 을 돌릴수 있는 모든 데이터 형식을 덧붙인다 */
		public function concat(obj : Object) : void
		{
			var name : String;
			for (name in obj) {
				this[name] = obj[name];
			}
		}
		/** 요소의 갯수 */
		public function get length() : int
		{
			return _names.length;
		}
		public function set length(length : int) : void
		{
			if (_names.length > length) {
				var list : Array = _names.slice(length);
				var i : int;
				for (i = 0;i < list.length; i++) {
					delete _values[list[i]];
				}
				_names = _names.slice(0, length);
			}
		}
		/** index 를 기준으로 name 을 가져온다 */
		public function getNameAt(index : int) : String
		{
			return _names[index];
		}
		/** name 을 기준으로 index 를 가져온다 */
		public function getIndexByName(name : String) : int
		{
			var i : int;
			for (i = 0;i < _names.length; i++) {
				if (_names[i] == name) {
					return i;
				}
			}
			return -1;
		}
		/** value 를 기준으로 index 들을 가져온다 */
		public function findIndexByValue(value : *) : Vector.<int>
		{
			var vec : Vector.<int> = new Vector.<int>();
			var i : int;
			for (i = 0;i < _names.length; i++) {
				if (_values[_names[i]] === value) {
					vec.push(i);
				}
			}
			return vec;
		}
		/** 데이터들을 node 에 attributes 로 붙여서 내보낸다 */
		public function getXMLAttributes(node : XML) : XML
		{
			var i : int;
			for (i = 0;i < _names.length; i++) {
				node["@" + _names[i]] = _values[_names[i]];
			}
			return node;
		}
		/** 
		 * 데이터들을 XMLList 형식으로 내보낸다 
		 */
		public function getXMLChildren() : XMLList
		{
			var i : int;
			var list : XML = <item />;
			for (i = 0;i < _names.length; i++) {
				list[_names[i]] = _values[_names[i]];
			}
			return list.*;
		}
		/*
		 * overriding Proxy
		 */
		/** @private */
		override flash_proxy function deleteProperty(name : *) : Boolean
		{
			var id : String = String(name);
			delete _values[id];
			if (ArrayEx.findElement(id, _names)) {
				dispatchEvent(new ValueEvent(ValueEvent.VALUE_DELETE, id));
				_names = ArrayEx.delElement(id, _names);
				_names.sort();
				return true;
			}
			return false;
		}
		/** @private */
		override flash_proxy function getProperty(name : *) : *
		{
			if (!isNaN(Number(name))) {
				var i : Number = Number(name);
				if (i > _names.length) {
					i = _names.length;
				} else if (i < 0) {
					i = 0;
				}
				name = _names[i];
			}
			var id : String = String(name);
			return _values[id];
		}
		/** @private */
		override flash_proxy function hasProperty(name : *) : Boolean
		{
			var id : String = String(name);
			return _values[id] != undefined;
		}
		/** @private */
		override flash_proxy function setProperty(name : *, value : *) : void
		{
			var id : String = String(name);
			_values[id] = value;
			if (!ArrayEx.findElement(id, _names)) {
				dispatchEvent(new ValueEvent(ValueEvent.VALUE_ADDED, id, value));
				_names.push(id);
				_names.sort();
			} else {
				dispatchEvent(new ValueEvent(ValueEvent.VALUE_CHANGE, id, value));
			}
		}
		/** @private */
		override flash_proxy function nextName(index : int) : String
		{
			return _names[index - 1];
		}
		/** @private */ 
		override flash_proxy function nextNameIndex(index : int) : int
		{
			return (index >= _names.length) ? 0 : index + 1;
		}
		/** @private */
		override flash_proxy function nextValue(index : int) : *
		{
			return _values[nextName(index)];
		}
		/*
		 * implements EventDispatcher
		 */
		/** EventDispatcher.dispatchEvent */
		public function dispatchEvent(event : Event) : Boolean
		{
			return _dispatcher.dispatchEvent(event);
		}
		/** EventDispatcher.hasEventListener */
		public function hasEventListener(type : String) : Boolean
		{
			return _dispatcher.hasEventListener(type);
		}
		/** EventDispatcher.willTrigger */
		public function willTrigger(type : String) : Boolean
		{
			return _dispatcher.willTrigger(type);
		}
		/** EventDispatcher.removeEventListener */
		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			_dispatcher.removeEventListener(type, listener, useCapture);
		}
		/** EventDispatcher.addEventListener */
		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		/** toString() */
		public function toString() : String
		{
			var attr : String = "";
			var f : int;
			for (f = 0;f < _names.length; f++) {
				attr += ' ' + _names[f] + ':' + getQualifiedClassName(_values[_names[f]]) + '="' + _values[_names[f]] + '"';
			}
			return '[Values' + attr + ']';
		}
	}
}
