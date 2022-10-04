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
	vec4 oColor;
	oColor=texture2D( gm_BaseTexture, v_vTexcoord );
	
	if (oColor.r==0.0 && oColor.g==0.0 && oColor.b==0.0 && oColor.a!=0.0)
	{
		oColor.r=Red;
		oColor.g=Green;
		oColor.b=Blue;
		gl_FragColor = oColor;
	}
	else
	{
		gl_FragColor = v_vColour * oColor;
	}
}
