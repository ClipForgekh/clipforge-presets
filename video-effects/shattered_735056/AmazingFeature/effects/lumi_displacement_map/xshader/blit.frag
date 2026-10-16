precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTexture;
uniform sampler2D _MainTex;

uniform sampler2D u_verticalImage;
uniform sampler2D u_horizontalImage;
uniform vec4 u_ScreenParams;
uniform float u_horizontalFlag;
uniform float u_verticalFlag;
uniform float u_horizontalIntensity;
uniform float u_verticalIntensity;
uniform float u_horizontalType;
uniform float u_verticalType;
uniform float u_edgeType;


float uvProtect(vec2 uv)
{
    vec2 uvp = step(vec2(0.0), uv) * step(uv, vec2(1.0));
    return uvp.x * uvp.y;
}

vec4 texture2Dmirror(sampler2D tex, vec2 uv) {
    // return texture2D(tex, fract(uv));
    uv = mod(uv, 2.0);
    uv = mix(uv, 2.0 - uv, step(vec2(1.0), uv));
    return texture2D(tex, fract(uv));
}

float getDis(vec4 color, float type)
{
    if (type < 0.5) {
        return color.r;
    } else if (type < 1.5) {
        return color.g;
    } else if (type < 2.5) {
        return color.b;
    }
    return color.a;
}

void main()
{
    // vec4 horizontalColor = texture2D(u_horizontalImage, uv0);
    // vec4 verticalColor = texture2D(u_verticalImage, uv0);
    vec2 inv_uv0 = vec2(uv0.x, 1.0-uv0.y);
    vec2 rotate_inv_uv0 = vec2(1.0)-inv_uv0;
    vec4 horizontalColor = texture2D(_MainTex, rotate_inv_uv0);
    vec4 verticalColor   = texture2D(_MainTex, rotate_inv_uv0);

    if (u_horizontalFlag < 0.5) horizontalColor = vec4(0.5);
    if (u_verticalFlag < 0.5) verticalColor = vec4(0.5);
    float horizontal = (getDis(horizontalColor, u_horizontalType)-0.5) * 2.0 * u_horizontalIntensity;
    float vertical = (getDis(verticalColor, u_verticalType)-0.5) * 2.0 * u_verticalIntensity * u_ScreenParams.x/u_ScreenParams.y;
    vec2 new_uv = vec2(uv0.x+horizontal, uv0.y+vertical);
    if (u_edgeType < 0.5) {
        gl_FragColor = texture2D(u_InputTexture, new_uv) * uvProtect(new_uv);
    } else {
        gl_FragColor = texture2Dmirror(u_InputTexture, new_uv);
    }
}
