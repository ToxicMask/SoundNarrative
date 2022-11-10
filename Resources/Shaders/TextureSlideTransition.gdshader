shader_type canvas_item;

uniform float interFactor : hint_range(0.0, 1.0) = 0;

void fragment(){
	vec4 texturePixel = texture(TEXTURE, UV);
	vec4 screenPixel = texture(SCREEN_TEXTURE, SCREEN_UV);
	// Dead Pixel
	if (UV.x <= (interFactor)){
		COLOR = texturePixel;
	}
	// Transition Pixel
	else {
		COLOR = screenPixel;
	}
}