shader_type canvas_item;

uniform float amount = 0;

float rand(vec2 co){
    return fract(cos(dot(co.xy ,vec2(4.5465465,37.3423))) * 7657.2367);
}

void fragment() {
	float rng = rand(UV+ abs(sin(TIME)));
	vec2 offsetUV = vec2( 0, - fract(TIME * rng) ) ;
	vec4 screenPixel = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 finalPixel = vec4(1);
	
	finalPixel = screenPixel + (rng * amount);
	
	COLOR = finalPixel;
}