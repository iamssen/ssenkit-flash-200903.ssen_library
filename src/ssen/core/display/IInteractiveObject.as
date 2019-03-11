package ssen.core.display 
{
	import flash.accessibility.AccessibilityImplementation;
	import flash.ui.ContextMenu;	
	/**
	 * InteractiveObject Interface
	 * @author SSen
	 */
	public interface IInteractiveObject extends IDisplayObject 
	{
		function get accessibilityImplementation() : AccessibilityImplementation;
		function get focusRect() : Object;
		function set focusRect(focusRect : Object) : void;
		function get doubleClickEnabled() : Boolean;
		function set contextMenu(cm : ContextMenu) : void;
		function get tabEnabled() : Boolean;
		function get contextMenu() : ContextMenu;
		function set accessibilityImplementation(value : AccessibilityImplementation) : void;
		function set doubleClickEnabled(enabled : Boolean) : void;
		function set mouseEnabled(enabled : Boolean) : void;
		function set tabIndex(index : int) : void;
		function get mouseEnabled() : Boolean;
		function get tabIndex() : int;
		function set tabEnabled(enabled : Boolean) : void;
	}
}
