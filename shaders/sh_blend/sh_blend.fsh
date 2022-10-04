//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float Red;
uniform float Green;
uniform float Blue;

void main()
{
	vec4 Blend;
	
	Blend.r=Red/100.0;
	Blend.g=Green/100.0;
	Blend.b=Blue/100.0;
	Blend.a=1.0;
	
    gl_FragColor = v_vColour * Blend * texture2D( gm_BaseTexture, v_vTexcoord );
}
