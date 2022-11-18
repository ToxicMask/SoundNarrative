shader_type canvas_item;

// RGB aberation
uniform float rgbOffset : hint_range(0.0, 0.05) = 0;
uniform bool rgbTimeOffset = false;


void fragment(){

	// RGB ABERATION
	vec4 rPixel = vec4(1);
	vec4 gPixel = vec4(1);
	vec4 bPixel = vec4(1);
	if (rgbTimeOffset){
		float timeFactor = max(abs(cos(TIME)), .2) ;
		rPixel = texture(SCREEN_TEXTURE, SCREEN_UV+ vec2(-rgbOffset * timeFactor , 0));
		gPixel = texture(SCREEN_TEXTURE, SCREEN_UV);
		bPixel = texture(SCREEN_TEXTURE, SCREEN_UV + vec2(+rgbOffset * timeFactor, 0));
	}else{
		rPixel = texture(SCREEN_TEXTURE, SCREEN_UV+ vec2(-rgbOffset, 0));
		gPixel = texture(SCREEN_TEXTURE, SCREEN_UV);
		bPixel = texture(SCREEN_TEXTURE, SCREEN_UV + vec2(+rgbOffset, 0));
	}
	
	COLOR = vec4(rPixel.r, gPixel.g, bPixel.b, 1.0);
}