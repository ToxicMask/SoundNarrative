shader_type canvas_item;


// Crude Noise Texture
uniform float textureFactor : hint_range(0.0, 1.0) = 0.5;
uniform float outlineFactor : hint_range(0.0, 1.0) = 0.5;
uniform sampler2D colorGradient;

// OUTLINE FACTORS
uniform vec4 line_color : hint_color = vec4(1);
uniform float mask_thickness : hint_range(0, 10) = 1.0;

// Return 0 to 1
float rand(vec2 co){
    return fract(cos(dot(co.xy ,vec2(4.5465465,37.918283))) * 7657.2367);
}

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
	
	vec4 texturePixel = texture(TEXTURE, UV);
	vec4 noisePixel = vec4(vec3(rand(vec2(UV.x* TIME, UV.y* -TIME))), 1.0);
	vec4 gradPixel = texture(colorGradient, vec2( noisePixel.r,0.0));
	
	vec2 size = TEXTURE_PIXEL_SIZE * mask_thickness;
	float outline_mask = outile_mask(TEXTURE, UV, size);
	
	
	// Render
	texturePixel = mix(texturePixel, texturePixel * (gradPixel),  textureFactor);
	vec4 final_line_color = mix (line_color, line_color* gradPixel, outlineFactor);
	texturePixel = mix(texturePixel, final_line_color, outline_mask - texturePixel.a);
	COLOR =  texturePixel;
	//COLOR = vec4(outline_mask);
}