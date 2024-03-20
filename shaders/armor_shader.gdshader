shader_type canvas_item;

uniform vec4 primary_color: source_color;
uniform vec4 secondary_color: source_color;
uniform vec4 tertiary_color: source_color;
uniform vec4 visor_color: source_color;

void fragment() {
	if(COLOR.a != 1.0)
	{
		discard;
	}
	if(COLOR.r == COLOR.g && COLOR.r == COLOR.b)
	{
		COLOR = visor_color * COLOR;
	}
	else if(COLOR.r > COLOR.g && COLOR.r > COLOR.b)
	{
		COLOR = primary_color * COLOR.r;
	}
	else if(COLOR.g > COLOR.r && COLOR.g > COLOR.b)
	{
		COLOR = secondary_color * COLOR.g;
	}
	else if(COLOR.b > COLOR.r && COLOR.b > COLOR.g)
	{
		COLOR = tertiary_color * COLOR.b;
	}
	
	COLOR.a = 1.0;
}
