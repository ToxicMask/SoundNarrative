shader_type canvas_item;

uniform float interFactor : hint_range(0.0, 1.0) = 0;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

void fragment(){
	vec4 texturePixel = texture(TEXTURE, UV);
	vec4 screenPixel = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 noisePixel = vec4(vec3(random(UV)), 1);//texture(noiseTexture, UV);
	
	// Dead Pixel
	if (noisePixel.r >= (1.0 -interFactor)){
		COLOR = texturePixel;
	}
	// Transition Pixel
	else {
		COLOR = mix(screenPixel, noisePixel * texturePixel, interFactor);
	}
	
	
}