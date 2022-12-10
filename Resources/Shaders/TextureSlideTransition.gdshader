shader_type canvas_item;

uniform vec4 transitionColor : hint_color = vec4(  vec3(0), 1.0);
uniform float interFactor : hint_range(0.0, 1.0) = 0;
uniform float screenMix : hint_range(0.0, 1.0, 0.1) = 0.0;

void fragment(){
	vec4 texturePixel = texture(TEXTURE, UV) * MODULATE;
	vec4 screenPixel = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	vec4 transition_layer = mix ( transitionColor, screenPixel,  screenMix);
	COLOR = mix(texturePixel, transition_layer, float(UV.x <= interFactor) );
}