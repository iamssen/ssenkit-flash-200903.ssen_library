package ssen.component.buttons 
{
	import ssen.core.convert.GraphicsConverter;
	import ssen.core.display.GridBitmap;
	import ssen.core.geom.Padding;
	import ssen.core.graphics.BitmapEx;
	import ssen.core.skinObject.ISkinObject;
	import ssen.core.skinObject.SkinGridSprite;
	import ssen.core.skinObject.SkinMode;

	import flash.display.BitmapData;
	import flash.geom.Rectangle;	
	/**
	 * LabelButton 에 사용되는 Skin
	 * @author SSen
	 */
	public class LabelButtonSkin implements ILabelButtonSkin 
	{
		private var _button_9grid : Rectangle;
		private var _button_padding : Padding;
		private var _button_fontColor_default : uint;
		private var _button_fontColor_over : uint;
		private var _button_fontColor_action : uint;
		private var _button_fontColor_disable : uint;
		private var _button_fontColor_selected : uint;
		private var _button_bg_default : BitmapData;
		private var _button_bg_over : BitmapData;
		private var _button_bg_action : BitmapData;
		private var _button_bg_disable : BitmapData;
		private var _button_bg_selected : BitmapData;

		public function LabelButtonSkin(buttonBitmap : BitmapData)
		{
			_button_9grid = GraphicsConverter.getScale9GridFromBitmapData(buttonBitmap, 50, 0, 50, 50);
			_button_padding = GraphicsConverter.getPaddingFromBitmapData(buttonBitmap, 50, 0, 50, 50);
			_button_fontColor_default = GraphicsConverter.getColor(buttonBitmap, 102, 52);
			_button_fontColor_over = GraphicsConverter.getColor(buttonBitmap, 152, 52);
			_button_fontColor_action = GraphicsConverter.getColor(buttonBitmap, 202, 52);
			_button_fontColor_disable = GraphicsConverter.getColor(buttonBitmap, 252, 52);
			_button_fontColor_selected = GraphicsConverter.getColor(buttonBitmap, 302, 52);
			_button_bg_default = BitmapEx.getSlice(buttonBitmap, 100, 0, 50, 50);
			_button_bg_over = BitmapEx.getSlice(buttonBitmap, 150, 0, 50, 50);
			_button_bg_action = BitmapEx.getSlice(buttonBitmap, 200, 0, 50, 50);
			_button_bg_disable = BitmapEx.getSlice(buttonBitmap, 250, 0, 50, 50);
			_button_bg_selected = BitmapEx.getSlice(buttonBitmap, 300, 0, 50, 50);
		}
		/** button bg */
		public function button_bg() : ISkinObject
		{
			var skins : Array = new Array();
			skins[SkinMode.DEFAULT] = new GridBitmap(_button_bg_default, 100, 100, _button_9grid);
			skins[SkinMode.OVER] = new GridBitmap(_button_bg_over, 100, 100, _button_9grid);
			skins[SkinMode.ACTION] = new GridBitmap(_button_bg_action, 100, 100, _button_9grid);
			skins[SkinMode.DISABLE] = new GridBitmap(_button_bg_disable, 100, 100, _button_9grid);
			skins[SkinMode.SELECTED] = new GridBitmap(_button_bg_selected, 100, 100, _button_9grid);
			return new SkinGridSprite(skins);
		}
		/** button 의 scale9Grid */
		public function get button_9grid() : Rectangle
		{
			return _button_9grid;
		}
		/** button 의 innerGrid */
		public function get button_innerGrid() : Padding
		{
			return _button_padding;
		}
		/** button 의 font colors */
		public function get button_fontColors() : Array
		{
			var colors : Array = new Array();
			colors[SkinMode.DEFAULT] = _button_fontColor_default;
			colors[SkinMode.OVER] = _button_fontColor_over;
			colors[SkinMode.ACTION] = _button_fontColor_action;
			colors[SkinMode.DISABLE] = _button_fontColor_disable;
			colors[SkinMode.SELECTED] = _button_fontColor_selected;
			return colors;
		}
	}
}
