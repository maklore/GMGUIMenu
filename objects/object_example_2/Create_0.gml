menu = new menu_system("main");

menu.main = new menu_create("BG Colour");
menu.main.set_button_option("BG Colour", "custom", layer_background_get_blend(layer_background_get_id("Background")), function() {
	var _bckg_layer = layer_background_get_id("Background");
	var _colour = make_colour_rgb(irandom(255), irandom(255), irandom(255));
	layer_background_blend(_bckg_layer, _colour);
	layer_background_get_blend(layer_background_get_id("Background"))
	return _colour
})

menu.build(font_asset_example, fa_left, fa_top)