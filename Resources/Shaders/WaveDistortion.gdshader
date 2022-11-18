shader_type canvas_item;

// Images
uniform sampler2D noiseTexture;

// Wave
uniform float waveFactor: hint_range(0.0, 1.0) = 0.0;


void fragment(){
	
	// Wave Distortion
	float noiseFactor = 2.0*(texture(noiseTexture, vec2(UV.x, TIME) ).r) - 1.0;
	vec2 waveOffset = vec2(SCREEN_PIXEL_SIZE.x, 0) * (120.0 * noiseFactor) ;
	vec4 wavePixel = texture(SCREEN_TEXTURE, SCREEN_UV +  waveOffset * waveFactor );

	COLOR = wavePixel;
}