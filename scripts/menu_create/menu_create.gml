/**
 * Menu
 * @param {string} ... Name(s) of menu button(s).
 */
function menu_create() constructor {

	if argument_count < 1 {	exit; }
	
	__menu_array = [];
	__menu_data = {
		x : 0,
		y : 0,
		height : 0,
		offset_height : 10,
		font : undefined,
		halign : undefined,
		valign : undefined,
		hover : -1,
		hover_option : -1
	};
	
	__option_bool = ["Disabled", "Enabled"];
	__option_resolutions = []
	__option_struct = {};
	
	for (var i = 0; i < argument_count; ++i) {
	    var _arg = argument[i];
		__menu_array[i] = _arg;
		__menu_data[$ _arg] = {
			x : 0,
			y : 0,
			x1 : 0,
			y1 : 0,
			x2 : 0,
			y2 : 0,
			width : 0,
			height : 0,
			func : undefined,
			option : undefined,
			option_data : undefined,
			option_width : 0
		}
	}
	
	__menu_length = array_length(__menu_array);
	
	/// @ignore
	static initialise = function(_font, _halign, _valign) {
		
		__menu_data.font = _font;
		draw_set_font(_font);
		__menu_data.height = string_height("|");
		__menu_data.halign = _halign;
		__menu_data.valign = _valign;
			
		for (var i = 0; i < __menu_length; ++i) {
				
			var _menu = __menu_array[i];
			var _button = __menu_data[$ _menu];
			
			if _button.option != undefined {
				
				_button.option_width = display_get_gui_width() * 0.125;
				
				var _value = _button.option_data.value;

				_button.option_data.width  = string_width(__option_bool[0]);
				_button.option_data.height = string_height(__option_bool[0]);

								
			} else {
				_button.option_width = 0;	
			}
			
			_button.width  = string_width(_menu);
			_button.height = string_height(_menu);
			
			_button.x = __menu_data.x - _button.option_width;
			_button.y = __menu_data.y + __menu_data.offset_height + _button.height * i;
			
			if _button.option != undefined {
				_button.option_data.x = __menu_data.x + _button.option_width;
			}
				
			if __menu_data.halign == fa_center {
				
				_button.x1 = _button.x - _button.width * 0.5;
				_button.x2 = _button.x + _button.width * 0.5;
				
				if _button.option != undefined {
					_button.option_data.x1 = _button.option_data.x - _button.option_data.width * 0.5;
					_button.option_data.x2 = _button.option_data.x + _button.option_data.width * 0.5;
				}
				
			}
				
			if __menu_data.halign == fa_left {
				
				_button.x1 = _button.x;
				_button.x2 = _button.x + _button.width;
				
				if _button.option != undefined {
					
					_button.x = __menu_data.x;
					_button.option_data.x = __menu_data.x + _button.option_width * 2;
					
					_button.option_data.x1 = _button.option_data.x;
					_button.option_data.x2 = _button.option_data.x + _button.option_data.width;
				}
			}
				
			if __menu_data.halign == fa_right {
				
				_button.x1 = _button.x - _button.width;
				_button.x2 = _button.x;
				
				if _button.option != undefined {
					
					_button.x = __menu_data.x - _button.option_width * 2;
					_button.option_data.x = __menu_data.x;
					
					_button.option_data.x1 = _button.option_data.x - _button.option_data.width;
					_button.option_data.x2 = _button.option_data.x;
				}
			}
			
			if __menu_data.valign == fa_middle {
				
				_button.y1 = _button.y - _button.height * 0.5;
				_button.y2 = _button.y + _button.height * 0.5;
				
				if _button.option != undefined {
					_button.option_data.y1 = _button.y - _button.option_data.height * 0.5;
					_button.option_data.y2 = _button.y + _button.option_data.height * 0.5;
				}
			} 
				
			if __menu_data.valign == fa_top {

				_button.y1 = _button.y;
				_button.y2 = _button.y + _button.height;
				
				if _button.option != undefined {
					_button.option_data.y1 = _button.y;
					_button.option_data.y2 = _button.y + _button.option_data.height;
				}
	
			}
				
			if __menu_data.valign == fa_bottom {

				_button.y1 = _button.y - _button.height;
				_button.y2 = _button.y;
				
				if _button.option != undefined {
					_button.option_data.y1 = _button.y - _button.option_data.height;
					_button.option_data.y2 = _button.y;
				}
	
			}
			
		}		
	
	}
	/// @ignore	
	static draw = function(_x, _y) {
		
		static _menus = "";
		static _xx = _x;
		static _yy = _y;
		static _x1 = _x;
		static _y1 = _y;
		static _x2 = _x;
		static _y2 = _y;
		static _option_x1 = 0;
		static _option_x2 = 0;
		static _colour = __MENU_COLOUR;
		
		draw_set_font(__menu_data.font);
		draw_set_halign(__menu_data.halign);
		draw_set_valign(__menu_data.valign);
		
		for (var i = 0; i < __menu_length; ++i) {
			
			_menus = __menu_array[i];
			
			var _menu = __menu_data[$ _menus];
						
			_xx = _x + _menu.x;
			_yy = _y + _menu.y;
			
			if _menu.option != undefined {
				
				var _option_data = _menu.option_data;
				var _option_value = _option_data.value;
				
				if _menu.option == "bool" {
					_option_value = __option_bool[_option_value];	
				}
				
				var _option_x = _x + _option_data.x;
				
				var _ox1 = _x + _option_data.x1;
				var _oy1 = _y + _option_data.y1;
				var _ox2 = _x + _option_data.x2;
				var _oy2 = _y + _option_data.y2;
			
				if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _ox1, _oy1, _ox2, _oy2) {
					__menu_data.hover_option = i;
					
					_colour = __MENU_COLOUR_HOVER;
					
				} else if _colour != __MENU_COLOUR {
					
					_colour = __MENU_COLOUR;
				}
				
				draw_text_colour(_option_x, _yy, _option_value, _colour, _colour, _colour, _colour, 1);
				
			}
			
			_x1 = _x + _menu.x1;
			_y1 = _y + _menu.y1;
			_x2 = _x + _menu.x2;
			_y2 = _y + _menu.y2;
			
			if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x1, _y1, _x2, _y2) and _menu.option_data == undefined {
				__menu_data.hover = i;
				
				_colour = __MENU_COLOUR_HOVER;
				
			} else if _colour != __MENU_COLOUR {
				
				_colour = __MENU_COLOUR;
			}
			
			draw_text_colour(_xx, _yy, _menus, _colour, _colour, _colour, _colour, 1);
		}
		
	}
	
	///@ignore
	static on_click = function(_button) {
		
		var _hover = __menu_data.hover;
		var _hover_option = __menu_data.hover_option;
				
		if mouse_check_button_released(_button) {
		
			var _menus = _hover != -1 ? __menu_array[_hover] : -1;
			var _menus_option = _hover_option != -1 ? __menu_array[_hover_option] : -1;
						
			__menu_data.hover = -1;
			__menu_data.hover_option = -1;
			
			if _menus != -1 and is_callable(__menu_data[$ _menus].func) {
				
				__menu_data[$ _menus].func();
				exit;
			}
			
			if _menus_option != -1 and is_callable(__menu_data[$ _menus_option].option_data.func1) {
				
				__menu_data[$ _menus_option].option_data.func1(_menus_option);
				
				if is_callable(__menu_data[$ _menus_option].option_data.func2) {
					__menu_data[$ _menus_option].option_data.func2();
				}
				
				exit;
			}

			return string_lower(_menus);
			
		}
		
		__menu_data.hover = -1;
		__menu_data.hover_option = -1;
		exit;
	}
	
	/**
	 * Set function for button.
	 * @param {string} _button Button name.
	 * @param {function} _func Function.
	 */
	static set_button_function = function(_button, _func) {
		var _menu = __menu_data[$ _button];

		if !struct_exists(_menu, "func") {
			exit;
		}
		__menu_data[$ _button].func = _func;
	}

	/**
	 * Set options for button.
	 * @param {string} _button Button name.
	 * @param {string} _type Set "bool", "slider", "array", or "key".
	 * @param {bool | array | real} _value Set value. Use an array for "slider" values: [low_value, high_value], and Unicode code for "key".
	 * @param {function} _func Optional. Set function to call.
	 */
	static set_button_option = function(_button, _type, _value, _func = undefined) {
		
		__menu_data[$ _button].option = _type;
		
		__menu_data[$ _button].option_data = {
			x : 0,
			y : 0,
			x1 : 0,
			y1 : 0,
			x2 : 0,
			y2 : 0,
			width : 0,
			height : 0,
			hover : -1,
			value : is_array(_value) ? undefined : _value,
			value_array : is_array(_value) ? _value : undefined,
			value_array_index : 0,
			func1 : undefined,
			func2 : _func

		};
		
		if _type == "bool" {
			
			__option_struct[$ _button] = _value;
			
			__menu_data[$ _button].option_data.func1 = function(_button) {
				
				__menu_data[$ _button].option_data.value = !__menu_data[$ _button].option_data.value;
				
				__option_struct[$ _button] = __menu_data[$ _button].option_data.value;
			}
		
		}
		
		if _type == "array" {
			
			var _get_resolution = $"{window_get_width()}x{window_get_height()}";
			var _get_index = array_get_index(_value, _get_resolution);
			
			__option_struct[$ _button] = _value[_get_index];
			
			__menu_data[$ _button].option_data.value = _value[_get_index];
			
			__menu_data[$ _button].option_data.func1 = function(_button) {
				
				static _array_length = array_length(__menu_data[$ _button].option_data.value_array) - 1;
				
				static _index = array_get_index(__menu_data[$ _button].option_data.value_array, __menu_data[$ _button].option_data.value);
				
				_index = _index < _array_length ? _index + 1 : 0;

				__menu_data[$ _button].option_data.value = __menu_data[$ _button].option_data.value_array[_index];
				
				__option_struct[$ _button] = __menu_data[$ _button].option_data.value;
			}
		
		}

	}
}