shader_type canvas_item;

uniform float fadeFactor : hint_range(0.0, 1.0) = 0.0;
uniform sampler2D brightGradient;

void fragment(){
	
	vec4 texturePixel = texture(TEXTURE, UV);
	float grayscale = ( texturePixel.r + texturePixel.g + texturePixel.b )/3.0;
	
	float gradFactor = smoothstep(0.0, grayscale, fadeFactor);
	vec4 gradPixel = texture(brightGradient, vec2(gradFactor));
	
	COLOR.rgb = texturePixel.rgb + gradPixel.rgb;
	COLOR.a = texturePixel.a * gradPixel.a;
}
