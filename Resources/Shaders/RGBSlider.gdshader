shader_type canvas_item;

uniform float timeScale : hint_range( 0, 10) = 1;
uniform float scaleA : hint_range(0, 1) = 0;
uniform float scaleB : hint_range(0, 1) = 0;
uniform vec4 modulateA : hint_color = vec4(0, 0, 0, 1);
uniform vec4 modulateB : hint_color = vec4(0, 0, 0, 1);
uniform vec4 modulateC : hint_color = vec4(0, 0, 0, 1);


void fragment() {
	
	vec2 offset = vec2(0,0);
	offset.x = sin(TIME * timeScale) * 0.5;
	offset.y = sin(TIME * timeScale) * 0.5;
	
	vec4 pixel = texture(TEXTURE, UV + offset);
	
	if (UV.x < scaleA){
		COLOR = pixel * modulateA;
	}
	else if (UV.y < scaleB){
		COLOR = pixel * modulateB;
	}
	else{
		COLOR = pixel * modulateC;
	}
}