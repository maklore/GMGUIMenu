display_set_gui_size(1920, 1080);

menu = new menu_system("MAIN");

menu.main = new menu_create("START", "LOAD", "OPTIONS", "EXIT");
	menu.main.set_button_function("START", function() { 
		room_goto(room_example_2); 
	});
	menu.main.set_button_function("EXIT", function() { 
		game_end(); 
	});

menu.load = new menu_create("SAVE", TINY_MENU_RETURN);
	menu.load.set_button_function("SAVE", function() {
	show_debug_message("SAVE HAS BEEN SELECTED!")
});

menu.options = new menu_create("GRAPHICS", "SOUND", "KEYBIND", TINY_MENU_RETURN);

	menu.graphics = new menu_create("FULLSCREEN", "RESOLUTION", "APPLY", TINY_MENU_RETURN); 
		menu.graphics.set_button_option("FULLSCREEN", "bool", false);
		menu.graphics.set_button_option("RESOLUTION", "array", ["360x180", "640x360", "960x540", "1280x720", "1920x1080", "2560x1440"], undefined, 3);
		menu.graphics.set_button_function("APPLY", function() {
			menu.options_set();
	
			window_set_fullscreen(menu.options_get().FULLSCREEN);
	
			var _res = menu.options_get().RESOLUTION;
			var _res_split = string_split(_res, "x");
			var _res_w = real(_res_split[0]);
			var _res_h = real(_res_split[1]);
			camera_set_view_size(view_get_camera(0), _res_w, _res_h);
			window_set_size(_res_w, _res_h);
			window_center();
	
		});
		menu.graphics.set_button_function(TINY_MENU_RETURN, function() {
			menu.options_cancel();	
		});

	menu.keybind = new menu_create("UP", "DOWN", "LEFT", "RIGHT", "INTERACT", "APPLY", TINY_MENU_RETURN);
		menu.keybind.set_button_option("UP", "key", "W");
		menu.keybind.set_button_option("DOWN", "key", "S");
		menu.keybind.set_button_option("LEFT", "key", "A");
		menu.keybind.set_button_option("RIGHT", "key", "D");
		menu.keybind.set_button_option("INTERACT", "key", "E");
		menu.keybind.set_button_function("APPLY", function() {
			menu.options_set();
		});
		menu.keybind.set_button_function(TINY_MENU_RETURN, function() {
			menu.options_cancel();	
		});

menu.initialise(font_asset_example, fa_center, fa_middle);

