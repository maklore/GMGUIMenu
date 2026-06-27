A small barebones GUI menu system with a lot of possibilites.

See the [wiki](https://github.com/maklore/GMGUIMenu/wiki) for how to start using it!

<img width="350" height="175" alt="Screenshot_20260623_230428" src="https://github.com/user-attachments/assets/c7c5871d-831f-4f33-b0fc-a50eeeea6a5a" />

Example code:
```gml
//Create Event
menu = new menu_system("MAIN");

menu.main = new menu_create("START", "OPTIONS", "EXIT");
	menu.main.set_button_function("START", function() { 
		room_goto(room_game); 
	});
	menu.main.set_button_function("EXIT", function() { 
		game_end(); 
	});

menu.options = new menu_create("GRAPHICS", GMGUI_MENU_RETURN);

  menu.graphics = new menu_create("FULLSCREEN", "APPLY", GMGUI_MENU_RETURN); 
		menu.graphics.set_button_option("FULLSCREEN", "bool", false);
		menu.graphics.set_button_function("APPLY", function() {
			var _changed = menu.options_set();
			if !_changed { exit; }
			window_set_fullscreen(menu.options_get().FULLSCREEN);
		});
		menu.graphics.set_button_function(GMGUI_MENU_RETURN, function() {
			menu.options_cancel();	
		});

menu.build(font_asset, fa_center, fa_middle);

//Step Event
menu.on_click(mb_left);

//Draw GUI Event
menu.draw(display_get_gui_width() * 0.5, display_get_gui_height() * 0.2)
```
