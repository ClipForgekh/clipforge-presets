precision highp float;
precision highp int;

uniform int u_inputTexture2;
uniform float u_gamma;
uniform sampler2D u_inputTexture;


varying vec2 uv0;



void main()
{
    vec4 Img1 = texture2D(u_inputTexture, uv0);
    vec4 Img2 = texture2D(u_inputTexture, uv0);
    vec4 result = mix(Img1,Img2,Img1.a);
    gl_FragData[0] = result;
}

