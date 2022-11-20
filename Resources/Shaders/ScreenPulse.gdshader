shader_type canvas_item;

uniform vec4 colorModulate : hint_color = vec4(1);

uniform vec2 pulseCenter = vec2(0.5);
uniform float force = 0.0;
uniform float radius = 0.0;
uniform float thick : hint_range(0.001, 1.0) = 1.0;
uniform float innerBlur : hint_range(0.01, 1.0)= 1.0;
uniform float blur : hint_range(0.01, 1.0) = 0.1;

void fragment(){
	float ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
	vec2 scaleUV = ( SCREEN_UV - vec2(0.5, 0.0) ) / vec2 (ratio, 1.0) + vec2(0.5, 0.0);
	float mask = (1.0 - smoothstep(radius - blur, radius, length(scaleUV - pulseCenter))) *
			smoothstep(radius - thick -(blur+innerBlur), radius - thick - blur, length(scaleUV - pulseCenter));
	vec2 disp = normalize(scaleUV - pulseCenter) *  force * mask;
	
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV- disp);
	COLOR *= mix( vec4(1), colorModulate, mask);
	//COLOR = vec4( SCREEN_UV -disp, 0.0, 1.0 );
	//COLOR.rgb = vec3(mask);
}