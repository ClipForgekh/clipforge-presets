precision highp float;

varying vec2 uv0;
uniform sampler2D inputTexture;
uniform float blurSize;

void main()
{
    vec2 uv1 = uv0;
    vec4 col = vec4(0.0);
    //vec2 offset = normalize(uv1-0.5)/u_ScreenParams.xy;
    for(int i= 1;i<16;i++){
        float j = float(i);
        vec2 tempUV = (uv1-0.5)/mix(1.0,blurSize,j/11.)+0.5;
        vec4 res_r = texture2D(inputTexture, tempUV);
        col+=res_r;
    }
    col/=15.;

    vec4 res = vec4(col);
    gl_FragColor = res;
}