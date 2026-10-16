precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_albedo;
uniform sampler2D blurTex;
uniform sampler2D edgeTex;
uniform float quantity;

float rgb2grey(vec3 rgbColor){
    return (rgbColor.r*0.299 + rgbColor.g*0.587 + rgbColor.b*0.114);
}

void main()
{
    vec4 edgeColor = texture2D(edgeTex, uv0);
    float greyEdge = pow(edgeColor.r, .4545);
    vec4 blurColor = texture2D(blurTex, uv0);
    vec4 inputColor = texture2D(u_albedo, uv0);
    float greyInput = rgb2grey(inputColor.rgb);
    greyInput = pow(greyInput, .4545);
    greyEdge *= greyInput;
    vec4 resultColor = inputColor;
    resultColor.rgb += (inputColor.rgb - blurColor.rgb) * greyEdge * quantity;
    gl_FragColor = resultColor;
}
