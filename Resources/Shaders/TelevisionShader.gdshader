shader_type canvas_item;

uniform sampler2D noiseTexture;

uniform float staticOffset = 0;
uniform bool grayscaleFactor = true;
uniform float noiseFactor : hint_range(0, 1) = 0.3;
uniform float noiseBright : hint_range(-1.0, 1.0) = 0;
uniform vec4 tint : hint_color;


float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}


void fragment() {
	vec2 noiseUV = vec2(UV.y + staticOffset, 1);
	vec4 texturePixel = texture(TEXTURE, UV);
	vec4 noisePixel = texture(noiseTexture, noiseUV);
	

	vec4 mixColor = vec4(1);
	
	if (grayscaleFactor) {
		vec4 grayscale = vec4( vec3((texturePixel.r + texturePixel.g + texturePixel.b) / 3.0), 1);
		grayscale.a = 1.0;
		mixColor = grayscale;
	}
	else{
		mixColor = texturePixel;
	}
	

	// Noise Factor
	if (noiseFactor > 0.0){
		vec4 whiteNoise = vec4(vec3(random(UV * TIME / 1.0)), 1);
		vec4 staticTexture = ((noisePixel + whiteNoise)/ 2.0) ;
		mixColor = mixColor + vec4(vec3(noiseBright), 1);
		mixColor = mix(mixColor, staticTexture, noiseFactor);
		mixColor = mixColor * tint;
	}
	else{
		// Just Tint Grayscale
		mixColor = mixColor * tint;
	}
	
	// Set Color
	COLOR = mixColor;
}

