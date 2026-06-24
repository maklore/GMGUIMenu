function struct_equals(_structA, _structB){
	
    if (struct_names_count(_structA) != struct_names_count(_structB)) return false;
    
    var _names = struct_get_names(_structA);
    for(var _i = 0, _len = array_length(_names); _i < _len; ++_i) {
        if (!struct_exists(_structB, _names[_i])) return false;
            
        if (_structB[$ _names[_i]] != _structA[$ _names[_i]]) {
            return false;    
        }
    }
    
    return true;
}