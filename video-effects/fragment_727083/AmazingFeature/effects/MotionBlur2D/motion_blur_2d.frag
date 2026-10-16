precision highp float;
varying highp vec2 uv0;

uniform sampler2D inputImageTexture;
uniform vec4 u_ScreenParams;

uniform vec2 PrevScale;
uniform vec2 PrevOffset;
uniform float PrevRotate;
uniform vec2 CurrScale;
uniform vec2 CurrOffset;
uniform float CurrRotate;
uniform float vIntensity;
uniform float vCenter;
uniform float minSamples;
uniform float maxSamples;
uniform vec2 offsetPoints[17];
uniform float curveOffset;

#define kSamplesPerFrame 256.0
#define PI 3.1415926
vec2 Affine(vec2 uv, float theta, vec2 offset, vec2 scale)
{
    // offset
    uv -= offset;
    // rotate
    uv -= 0.5;
    uv.y *= u_ScreenParams.y / u_ScreenParams.x;
    float sint = sin(theta);
    float cost = cos(theta);
    mat2 rot = mat2(
        cost, sint,
        -sint, cost
    );
    uv = rot * uv;
    uv.y *= u_ScreenParams.x / u_ScreenParams.y;
    // scale
    uv = uv * (1. / scale);
    uv += 0.5;
    return uv;
}


vec2 getOffsetPoints(int index)
{
    vec2 res = offsetPoints[16];
    for (int i = 0; i < 17; i++)
    {
        if (index == i)
        {
            res = offsetPoints[i];
            break;
        }
    }
    return res;
}


vec2 interOffset(float k)
{
    float idx = (k+2.0) * 4.0;
    vec2 res = vec2(0.0);
    if (idx < 0.0)
    {
        vec2 a = getOffsetPoints(0);
        vec2 b = getOffsetPoints(1);
        res = a - idx * (a-b);
    }
    else if(idx >= 16.0)
    {
        vec2 a = getOffsetPoints(16);
        vec2 b = getOffsetPoints(15);
        res = a + (idx-16.0) * (a-b);
    }
    else
    {
        float idx_1 = floor(idx);
        float idx_2 = fract(idx);
        vec2 a = getOffsetPoints(int(idx_1));
        vec2 b = getOffsetPoints(int(idx_1+1.0));
        res = mix(a, b, idx_2);
    }

    return res;
}

uniform float u_Intensity;
uniform float final_alpha;

void Exposure(inout vec4 col, float _intensity, float _offset, float _gray_scale_correct, float _no_linear){
    if(_no_linear<0.5) col.rgb = pow(col.rgb, vec3(2.2));
    col.rgb *= pow(2.0, _intensity);
    col.rgb += _offset;
    vec3 s = sign(col.rgb);
    col.rgb = pow(abs(col.rgb), vec3(1.0 / _gray_scale_correct)) * s;
    s = sign(col.rgb);
    if (_no_linear<0.5) col.rgb = pow(abs(col.rgb), vec3(0.454545454545)) * s;
}

uniform float motion_tile_flag;

void MotionTile(
    inout vec2 io_u, 
    vec2 _tile_center, vec2 _tile_size, vec2 _output_size,
    float _mirror_edges,float _phase,float _horizontal_phase_shift, 
    out float o_mask)
{
    vec2 ori_uv = io_u;
    io_u -= 0.5;
    io_u /= _tile_size;
    io_u += 0.5;
    io_u -= _tile_center - 0.5;

    vec2 phase_uv = io_u;

    o_mask = step(0.5-_output_size.x*0.5, ori_uv.x)*step(ori_uv.x, _output_size.x*0.5+0.5)
            *step(0.5-_output_size.y*0.5, ori_uv.y)*step(ori_uv.y, _output_size.y*0.5+0.5);

    float offset = sin(_phase/180.*PI);

    float inner_mask = 0.;
    if(_horizontal_phase_shift > 0.5){
        phase_uv.x -= offset;
        inner_mask = step(0., io_u.y)*step(io_u.y, 1.);
    }else{
        phase_uv.y += offset;
        inner_mask = step(0., io_u.x)*step(io_u.x, 1.);
    }

    if(_mirror_edges > 0.5){
        io_u = abs(mod(io_u-1., 2.)-1.);
        phase_uv = abs(mod(phase_uv-1., 2.)-1.);
    }else{
        io_u = fract(io_u);
        phase_uv = fract(phase_uv);
    }

    io_u = mix(phase_uv, io_u, inner_mask);
}
float cut(vec2 u) {return step(0., u.x)*step(u.x, 1.)*step(0., u.y)*step(u.y, 1.); }

void main() {
    vec2 currUV = Affine(uv0, CurrRotate * PI / 180.0, CurrOffset, CurrScale);
    vec2 PrevUV = Affine(uv0, PrevRotate * PI / 180.0, PrevOffset, PrevScale);
    vec2 velocity = (PrevUV-currUV)*vIntensity;
    float distance = length(velocity);
    float mins = max(minSamples, 2.0);
    float maxs = max(maxSamples, mins);
    // float samples = floor(mins + (maxs - mins)*smoothstep(0.0, 0.2, distance));
    float samples = maxs;

    vec4 result = vec4(0.0);
    vec2 target = vec2(0.0);
    for (float i = 0.0; i < kSamplesPerFrame; i+=1.0) {
        if (i >= samples) break;
        float rotate = CurrRotate + (PrevRotate - CurrRotate) * (vIntensity * (i / (samples - 1.0)-1.0) - vCenter);
        vec2 offset;
        if (curveOffset < 0.5)
        {
            offset = CurrOffset + (PrevOffset - CurrOffset) * (vIntensity * (i / (samples - 1.0)-1.0) - vCenter);
        }
        else
        {
            offset = interOffset(vIntensity * (i / (samples - 1.0)-1.0) - vCenter);
        }
        vec2 scale = CurrScale + (PrevScale - CurrScale) * (vIntensity * (i / (samples - 1.0)-1.0) - vCenter);

        target = Affine(uv0, rotate * PI / 180.0, offset, scale);

        float mask = 1.;
        if(motion_tile_flag > 0.5){
            MotionTile(target, vec2(0.5), vec2(1.), vec2(1.5), 1., 0., 0., mask);
        }else{
            mask = cut(target);
        }
        result += texture2D(inputImageTexture, target) * mask;
    }
    result = result / (samples);

    float no_use_linear_light = 0.;
    Exposure(result, u_Intensity, 0., 1., no_use_linear_light);
    result *= final_alpha;

    // if (result.a > 0.0) result.rgb /= result.a;
    gl_FragColor = result;
}