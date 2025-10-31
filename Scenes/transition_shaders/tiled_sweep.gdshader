shader_type canvas_item;

uniform float progress: hint_range(0.0, 1);
uniform bool reverse = true;
uniform vec2 numberOfTiles = vec2(15, 8.4375);

void fragment() {
	vec2 positionInSquare = UV * numberOfTiles;
	vec2 frac = fract(positionInSquare);
	if ( frac.x + frac.y > progress * 2.0 ){
		if(!reverse){
			discard;
		}
	}
	else if(reverse){
		discard;
	}
}
