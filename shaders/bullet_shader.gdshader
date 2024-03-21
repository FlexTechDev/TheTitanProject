shader_type canvas_item;

uniform vec4 base_color: source_color;
uniform float glow = 1.0;

void fragment() {
	if(COLOR.a == 1.0)
	{
		COLOR = base_color * COLOR;
	}
}
