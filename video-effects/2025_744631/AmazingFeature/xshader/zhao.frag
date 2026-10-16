precision lowp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTexture;
uniform sampler2D inputImg;
uniform sampler2D PNG_2024;


void main()
{
    
    
    vec4 PNG_2024Color = texture2D(PNG_2024,vec2(uv0.x,uv0.y));
    vec4 inputColor = texture2D(inputImg,vec2(uv0.x,uv0.y ));
    vec4 mixColor = texture2D(u_InputTexture, uv0);

    mixColor  = mix(mixColor,PNG_2024Color ,PNG_2024Color.r );
    inputColor.rgb = mix(mixColor.rgb, inputColor.rgb,mixColor.a );
    gl_FragColor = vec4(inputColor.rgb, mixColor.a);
}
