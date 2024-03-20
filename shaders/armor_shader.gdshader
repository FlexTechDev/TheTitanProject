shader_type canvas_item;

uniform vec4 primary_color: source_color;
uniform vec4 secondary_color: source_color;
uniform vec4 tertiary_color: source_color;
uniform vec4 visor_color: source_color;

void fragment() {
	if(COLOR.r == COLOR.g && COLOR.r == COLOR.b)
	{
		COLOR = visor_color;
	}
	else if(COLOR.r > COLOR.g && COLOR.r == COLOR.b)
	{
		COLOR = primary_color;
	}
	else if(COLOR.g > COLOR.r && COLOR.g > COLOR.b)
	{
		COLOR = secondary_color;
	}
	else if(COLOR.b > COLOR.r && COLOR.b > COLOR.g)
	{
		COLOR = tertiary_color;
	}
}
