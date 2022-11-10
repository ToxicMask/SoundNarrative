shader_type canvas_item;

uniform sampler2D distortionTexture;
uniform float distortionScale : hint_range(0.0, 0.1, 0.01);
const vec4 mask1 = vec4(1);

void fragment() {
	
	vec4 distColor = texture(distortionTexture, UV);
	vec2 distUV = SCREEN_UV + distColor.r * distortionScale;
	vec4 screenColor = texture(SCREEN_TEXTURE, distUV);
	vec4 pixel = texture(TEXTURE, UV);
	
	if (pixel == mask1){
		COLOR = screenColor;
	}
	else{
		COLOR = vec4(0.85, 0.3, 0.1, 1);
	}
	
	//COLOR = distColor;
	
}