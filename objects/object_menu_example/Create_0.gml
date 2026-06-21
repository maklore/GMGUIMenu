display_set_gui_size(1920, 1080);

menu = new menu_system("MAIN");

menu.main = new menu_create("START", "LOAD", "OPTIONS", "EXIT");
menu.main.set_button_function("START", function() { room_goto(room_example_2); });

menu.load = new menu_create("SAVE1", "SAVE2", "MAIN");

menu.options = new menu_create("FULLSCREEN", "RESOLUTION", "APPLY", "MAIN");
menu.options.set_button_option("FULLSCREEN", "bool", false);
menu.options.set_button_option("RESOLUTION", "array", ["360x180", "640x360", "960x540", "1280x720", "1920x1080"]);

menu.options.set_button_function("APPLY", function() { 
	window_set_fullscreen(menu.options_get().FULLSCREEN);
	
	var _res = menu.options_get().RESOLUTION;
	var _res_split = string_split(_res, "x");
	var _res_w = real(_res_split[0]);
	var _res_h = real(_res_split[1]);
	var _cam = view_get_camera(0);
	view_set_wport(_cam, _res_w);
	view_set_hport(_cam, _res_h);
	window_set_size(_res_w, _res_h);
	//window_center();

	show_debug_message(menu.options_get())
})


menu.main.set_button_function("EXIT", function() { game_end(); });

menu.initialise(font_asset_example, fa_center, fa_middle);

