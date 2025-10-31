shader_type canvas_item;

uniform float progress: hint_range(0.0, 1);

void fragment() {
	COLOR.a = progress;
}
