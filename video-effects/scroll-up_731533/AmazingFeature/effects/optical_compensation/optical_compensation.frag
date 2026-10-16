precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_Albedo;
uniform sampler2D inputTex;
uniform float u_Strength;
uniform vec4 u_ScreenParams;
uniform vec2 wh;
uniform float w;
uniform float h;

uniform vec2 tile_centr;

vec2 flip_uv(vec2 uv)
{
    return abs(mod(uv + 1., 2.) - 1.0);
}

float uvProtect(vec2 uv)
{
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
    // return step(0.0, uv.y) * step(uv.y, 1.0) * step(0.0, uv.x) * step(uv.x, 1.0);
}

// vec2 flip_uv(vec2 uv)
// {
//     return abs(mod(uv + 1., 2.) - 1.0);
// }

void main()
{

    vec2 uv = uv0;
    // vec2 ratio = (u_ScreenParams.xy / max(u_ScreenParams.x, u_ScreenParams.y));
    vec2 ratio = (wh / max(w, h));
    for (int i = 1; i < 16; ++i)
    {
        uv -= 0.5;
        uv *= ratio;
        float d = length(uv * 2.0);
        // uv = uv * pow((d*d) + 1.0, -pow(u_Strength * 0.0059375, 3.0));
        uv = uv * pow((d*d) + 1.0, -pow(u_Strength * 0.0033475, 1.9));
        uv /= ratio;

        uv += 0.5;
    }
    vec4 resultCol = texture2D(u_Albedo, uv) * uvProtect(uv);

    uv -= tile_centr;
    // vec4 inputCol = texture2D(inputTex, flip_uv(uv));

    // // gl_FragColor = texture2D(u_Albedo, uv) * uvProtect(uv);
    // resultCol.a = inputCol.a;
    gl_FragColor = resultCol;
}