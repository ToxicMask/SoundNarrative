shader_type canvas_item;


// Crude Noise Texture
uniform sampler2D colorGradient;
uniform float gradientOffset = 0.0;
uniform sampler2D noiseTexture;

// Wave
uniform float waveSpeed = 1.0;
uniform float waveScale = 1.0;
uniform float waveStrength = 50.0;
uniform float waveFactor: hint_range(0.0, 1.0) = 0.1;

// OUTLINE FACTORS
uniform vec4 line_color : hint_color = vec4(1,0.0,0.0,1.0);
uniform float mask_thickness : hint_range(0, 10) = 1.0;

// Return 0 to 1
float rand(vec2 co){
    return fract(cos(dot(co.xy ,vec2(4.5465465,37.918283))) * 7657.2367);
}

// Outline Mask in Float
float outline_mask( sampler2D _texture , vec2 _uv, vec2 size){
	
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
	vec2 size = TEXTURE_PIXEL_SIZE * mask_thickness;
	
	
	vec4 whiteNoisePixel = vec4(vec3(rand(vec2(UV.x* TIME, UV.y* -TIME))), 1.0);
	vec4 naturalNoisePixel = texture(noiseTexture, UV + vec2(TIME* .01));
	
	float center_distance = smoothstep(0.0, 0.5, distance(UV, vec2(0.5)));
	vec4 gradPixel = texture(colorGradient, vec2( 1.0-center_distance+gradientOffset,0.0));
	
	
	// Wave Distortion
	float noiseFactor = 2.0*(texture(noiseTexture, vec2(UV.y* waveScale, TIME * waveSpeed) ).r) - 1.0;
	vec2 waveOffset = vec2(TEXTURE_PIXEL_SIZE.x, 0) * (waveStrength * noiseFactor) ;
	vec4 wavePixel = texture(TEXTURE, UV +  waveOffset * waveFactor);
	
	float outline_mask = outline_mask(TEXTURE, UV +  waveOffset * waveFactor, size);
	vec4 outline_color = line_color * whiteNoisePixel;
	float only_outline = outline_mask - wavePixel.a;
	
	// Render
	texturePixel = wavePixel;
	texturePixel = mix(texturePixel, texturePixel * (gradPixel), 1.0);
	texturePixel = mix (texturePixel, vec4(outline_mask) * outline_color, only_outline);
	COLOR = texturePixel;
	
}