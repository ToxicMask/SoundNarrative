shader_type canvas_item;

uniform bool active = true;
uniform float amount = 0.3;

// Return 0 to 1
float rand(vec2 co){
    return fract(cos(dot(co.xy ,vec2(4.5465465,37.918283))) * 7657.2367);
}

// Return -1 to 1
float rand_rang(vec2 co){
	float rand_product = rand(co); 
    return (rand_product * 2.0) -1.0;
}

void fragment() {
	
	vec4 screenPixel = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 finalPixel = vec4(1);
	
	// set active or not
	if (active){
		float rng = rand_rang(UV + abs(sin(TIME)));
		vec2 offsetUV = vec2( 0, - fract(TIME * rng) ) ;
		
		finalPixel = screenPixel + (rng *  amount);
	
	}
	else {
		finalPixel = screenPixel;
	}
	
	COLOR = finalPixel;
}