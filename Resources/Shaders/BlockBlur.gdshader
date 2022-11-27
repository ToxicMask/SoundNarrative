shader_type canvas_item;

uniform int pixelRange : hint_range(1, 50, 1) = 1;

vec4 gauss_blur( sampler2D _texture, vec2 _uv, vec2 _pixel_size ){
	
	float pixelRatio = 1.0 / pow(float(pixelRange * 2), 2.0);
	vec4 finalPixel = vec4(0);
	
	for (int x = -pixelRange; x < pixelRange; x ++){
		for (int y = -pixelRange; y < pixelRange; y ++){
			vec2 gauss_uv = _uv + ( vec2(float(x), float(y)) * _pixel_size );
			finalPixel += texture(_texture, gauss_uv) * pixelRatio;
		}
	}
	finalPixel.a = min(1.0, 1.0);
	
	return finalPixel;
}


void fragment(){
	COLOR = gauss_blur(TEXTURE, UV, TEXTURE_PIXEL_SIZE);
}
