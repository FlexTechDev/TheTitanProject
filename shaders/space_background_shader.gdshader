shader_type canvas_item;

uniform vec4 background_color: source_color;
uniform vec4 star_color: source_color;
uniform sampler2D noise_texture;

void fragment() {
	if(round(texture(noise_texture, UV).r) == 1.0)
	{
		COLOR = star_color;
	}
	else
	{
		COLOR = background_color;
	}
}
