precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputTexture;
// uniform vec4 u_ScreenParams;

uniform float u_outboxSize;
uniform float u_outboxAngle;
uniform float u_inboxSize;
uniform float u_inboxAngle;
uniform float u_color;

mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}

float box(in vec2 _st, in vec2 _size){
    _size = vec2(0.5) - _size*0.5;
    vec2 uv = smoothstep(_size,
                        _size+vec2(0.001),
                        _st);
    uv *= smoothstep(_size,
                    _size+vec2(0.001),
                    vec2(1.0)-_st);
    return uv.x*uv.y;
}

void main()
{
    // box outside
    vec2 outboxUV = uv0;
    // float ratio = u_ScreenParams.y / u_ScreenParams.x;

    // outboxUV -= 0.5;
    // if(ratio > 1.0)
    // {
    //     outboxUV.y *= u_ScreenParams.y / u_ScreenParams.x;
    // }
    // else
    // {
    //     outboxUV.x *= u_ScreenParams.x / u_ScreenParams.y;
    // }
    // outboxUV = rotate2d(-u_outboxAngle) * outboxUV;
    // outboxUV += 0.5;

    vec3 outboxColor = vec3(0.0);
    outboxColor += vec3(box(outboxUV, vec2(u_outboxSize, u_outboxSize)));
    outboxColor *= u_color;

    // box inside
    // vec2 inboxUV = uv0;
    // inboxUV -= 0.5;
    // if(ratio > 1.0)
    // {
    //     inboxUV.y *= u_ScreenParams.y / u_ScreenParams.x;
    // }
    // else
    // {
    //     inboxUV.x *= u_ScreenParams.x / u_ScreenParams.y;
    // }
    // inboxUV = rotate2d(-u_inboxAngle) * inboxUV;
    // inboxUV += 0.5;
    
    // vec3 inboxColor = vec3(0.0);
    // inboxColor += vec3(box(inboxUV, vec2(u_inboxSize, u_inboxSize)));

    // final box
    // vec3 finalboxColor = clamp(outboxColor - inboxColor, 0.0, 1.0);

    gl_FragColor = vec4(outboxColor, outboxColor.r);

}
