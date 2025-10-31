shader_type canvas_item;

uniform float progress: hint_range(0.0, 1);
uniform bool reverse = true;

void fragment() {
	if ( UV.x > progress ){
		if(!reverse){
			discard;
		}
	}
	else if(reverse){
		discard;
	}
}
