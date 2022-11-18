shader_type canvas_item;

uniform vec4 line_color : hint_color = vec4(1);
uniform float mask_thickness : hint_range(0, 10) = 1.0;


float outile_mask( sampler2D _texture , vec2 _uv, vec2 size){
	float outline = texture(_texture, _uv + vec2(-size.x, 0)).a;
	outline += texture(_texture, _uv + vec2(0, size.y)).a;
	outline += texture(_texture, _uv + vec2(size.x, 0)).a;
	outline += texture(_texture, _uv + vec2(0, -size.y)).a;
	outline += texture(_texture, _uv + vec2(-size.x, size.y)).a;
	outline += texture(_texture, _uv + vec2(size.x, size.y)).a;
	outline += texture(_texture, _uv + vec2(-size.x, -size.y)).a;
	outline += texture(_texture, _uv + vec2(size.x, -size.y)).a;
	outline = min(outline, 1.0);
	return outline;
}

void fragment() {
	vec2 size = TEXTURE_PIXEL_SIZE * mask_thickness;
	float outline_mask = outile_mask(TEXTURE, UV, size);
	
	vec4 color = texture(TEXTURE, UV);
	COLOR = mix(color, line_color, outline_mask - color.a);
	//COLOR = vec4(outline_mask);
}

