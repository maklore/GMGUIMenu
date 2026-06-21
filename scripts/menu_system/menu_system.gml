/**
 * Menu system. 
 *
 * All menu names will be added as lowercase string. 
 * Please use lowercase characters for menu structs.
 * @param {string} _starting_menu_name First menu to display.
 */
function menu_system(_menu_name) constructor {
	
	static __current_menu = string_lower(_menu_name);
	
	/**
	 * Set up font and alignment.
	 * @param {asset.font} _font Font.
	 * @param {constant.align} _halign Horizontal alignment.
	 * @param {constant.align} _valign Vertical alignment.
	 */
	static initialise = function(_font, _halign, _valign) {
		
		var _remove = ["initialise", "on_click", "draw", "__current_menu", "options_get", "options_set"];
		
		var _struct_names = struct_get_names(self);
		
		for (var i = 0; i < array_length(_remove); ++i) {

			var _get_index = array_get_index(_struct_names, _remove[i]);
			
			if _get_index != -1 and _get_index < array_length(_struct_names) {
				array_delete(_struct_names, _get_index, 1);
			}
		}
		
		var _struct_count = array_length(_struct_names);

		if _struct_count < 1 { exit; }
		
		for (var i = 0; i < _struct_count; ++i) {
		    var _name = _struct_names[i];
			self[$ _name].initialise(_font, _halign, _valign);
		}
		
	}
	
	/**
	 * Draw the menu.
	 * @param {real} _x The x position.
	 * @param {real} _y The y position.
	 */
	static draw = function(_x, _y) {
		self[$ __current_menu].draw(_x, _y);	
	}
	
	/**
	 * On click go to set menu or call set function for that button.
	 * @param {constant.mousebutton} _button The button.
	 */
	static on_click = function(_button) {
		var _result = self[$ __current_menu].on_click(_button);
		if _result != undefined and struct_exists(self, _result) {
			
			__current_menu = _result;	
		}
	}
	
	/**
	 * Returns a struct of set options.
	 * @returns {struct}
	 */
	static options_get = function() {
		return self[$ __current_menu].__option_struct;
	}
	
	/**
	 * Sets the current options from a struct. Must be applied after.
	 * @param {struct} _struct Options struct.
	 */
	static options_set = function(_struct) {
		self[$ __current_menu].__option_struct = _struct;
	}
	
}