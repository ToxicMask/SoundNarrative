shader_type canvas_item;

// Images
uniform sampler2D anomalyMask;
uniform sampler2D maskGradient;
uniform sampler2D noiseTexture;

// Rotation
uniform float radiansPerSecond = 0.05;
const float PI = 3.14159;

// Wave
uniform float waveFactor: hint_range(0.0, 1.0) = 0.0;

// Tint Color
uniform sampler2D tintGradient;
uniform float tintBright = 1;


vec2 rotateUV(vec2 uv, vec2 pivot, float rotation) {
    float cosa = cos(rotation);
    float sina = sin(rotation);
    uv -= pivot;
    return vec2(
        cosa * uv.x - sina * uv.y,
        cosa * uv.y + sina * uv.x 
    ) + pivot;
}

void fragment(){
	
	// Distortion Mask
	vec2 rotatedUV = rotateUV(UV, vec2(0.5), (radiansPerSecond * PI) * TIME );
	vec4 anomalyPixel = texture(anomalyMask, rotatedUV);
	vec2 gradientUV = vec2(anomalyPixel.r, 0);
	float maskFactor = 1.0-texture(maskGradient, gradientUV).r;
	
	// Screen Pixel
	vec4 screenPixel = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	// Wave Distortion
	float noiseFactor = 2.0*(texture(noiseTexture, vec2(UV.x, TIME) ).r) - 1.0;
	vec2 waveOffset = vec2(SCREEN_PIXEL_SIZE.x, 0) * (120.0 * noiseFactor) ;
	vec4 wavePixel = texture(SCREEN_TEXTURE, SCREEN_UV +  waveOffset * waveFactor );
	
	// Color Gradient
	vec4 tintPixel = texture(tintGradient, vec2(maskFactor,0));
	
	// Final Mix
	COLOR = mix(screenPixel, wavePixel * (tintPixel * tintBright) , maskFactor);
}