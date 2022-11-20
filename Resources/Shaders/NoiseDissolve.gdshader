
// Disapear Shader
shader_type canvas_item;

uniform sampler2D noiseTexture;
uniform sampler2D gradientTexture;

uniform float disappearFactor : hint_range(0.0, 1.0, 0.01) = 0;

void fragment(){
	vec4 texturePixel = texture(TEXTURE, UV);
	vec4 noisePixel = texture( noiseTexture, UV);
	
	float gradientFactor = smoothstep(0.0, noisePixel.r, disappearFactor);
	vec4 gradientPixel = texture( gradientTexture, vec2( gradientFactor, 0));
	
	COLOR =  texturePixel * gradientPixel;
}
