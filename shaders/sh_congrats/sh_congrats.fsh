//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float time;

void main()
{
	vec4 oColor;
	oColor=texture2D( gm_BaseTexture, v_vTexcoord );
	
	if (oColor.r==oColor.g && oColor.g==oColor.b && oColor.a==1.0 && oColor.r>0.0)
	{
		float value;
		value=mod(oColor.r+(time/20.0),1.0);
		oColor.r=1.0;
		oColor.g=value;
		oColor.b=value;
		gl_FragColor = oColor;
	}
	else
	{
		gl_FragColor = v_vColour * oColor;
	}
}
