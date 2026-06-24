/**
 * Menu system. 
 *
 * All menu button names will be checked as lowercase string. 
 * Please use lowercase characters when accessing menu structs.
 * @param {string} _starting_menu_name First menu to display.
 */
function menu_system(_menu_name) constructor {
	
	static __main_menu = string_lower(_menu_name);
	static __current_menu = string_lower(_menu_name);
	static __current_menu_stack = [];
	static __options_data = {
		__option_struct : {},
		__option_struct_index : {},
		__option_struct_temp : {},
		__option_struct_temp_index : {}	
	}
	
	/**
	 * Set font and build button alignments.
	 * @param {asset.font} _font Font.
	 * @param {constant.align} _halign Horizontal alignment.
	 * @param {constant.align} _valign Vertical alignment.
	 */
	static build = function(_font, _halign, _valign) {
				
		var _struct_names = struct_get_names(self);
						
		var _struct_count = array_length(_struct_names);

		if _struct_count < 1 { exit; }
		
		for (var i = 0; i < _struct_count; ++i) {
		    var _name = _struct_names[i];
			if struct_exists(self[$ _name], "arrange") {
				self[$ _name].arrange(_font, _halign, _valign);
			}
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

		if string_upper(_result) == GMGUI_MENU_RETURN {
			
			array_shift(__current_menu_stack);
			__current_menu = array_length(__current_menu_stack) > 0 ? __current_menu_stack[0] : __main_menu;
			exit;
		}

		if _result != undefined and struct_exists(self, _result) {

			array_insert(__current_menu_stack, 0, _result)
			__current_menu = __current_menu_stack[0];
		}
	}
	
	/**
	 * Returns a struct of set options.
	 * @returns {struct}
	 */
	static options_get = function() {
		return __options_data.__option_struct;		
	}
	
	/**
	 * Returns true if changed, else false.
	 * @returns {bool}
	 */
	static options_set = function() {
		
		var _check_equals = struct_compare(__options_data.__option_struct_temp, __options_data.__option_struct)
		
		if _check_equals {
			return false;	
		}
		
		__options_data.__option_struct = variable_clone(__options_data.__option_struct_temp);
		__options_data.__option_struct_index = variable_clone(__options_data.__option_struct_temp_index)
		return true;
	}
	
	/**
	 * Sets the temporary set options back to current.
	 */
	static options_cancel = function() {
		
		__options_data.__option_struct_temp = variable_clone(__options_data.__option_struct);
		__options_data.__option_struct_temp_index = variable_clone(__options_data.__option_struct_index);
		self[$ __current_menu].__option_key_listen = false;
		self[$ __current_menu].__option_slider_active = false;
	}
	
	/// @ignore
	static struct_compare = function(_struct1, _struct2){
	
	    if (struct_names_count(_struct1) != struct_names_count(_struct2)) return false;
    
	    var _names = struct_get_names(_struct1);
	    for(var _i = 0, _len = array_length(_names); _i < _len; ++_i) {
	        if (!struct_exists(_struct2, _names[_i])) return false;
            
	        if (_struct2[$ _names[_i]] != _struct1[$ _names[_i]]) {
	            return false;    
	        }
	    }
    
	    return true;
	}
	
}