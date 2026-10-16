precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputTex;
uniform float alpha;

uniform vec2 tile_centr;
uniform vec2 tile_size;
uniform vec2 output_size;
uniform float mirror_edges;
uniform float phase;
uniform float horizontal_phase_shift;

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

    const float PI = 3.1415926;
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

void MotionTile_with_sample(
    out vec4 o_col,
    sampler2D _i_tex,
    vec2 _uv,
    vec2 _tile_center, vec2 _tile_size, vec2 _output_size,
    float _mirror_edges, float _phase, float _horizontal_phase_shift
    )
{
    vec2 uv = _uv;
    float mask = 0.;
    MotionTile(uv, 
        _tile_center, _tile_size, _output_size, 
        _mirror_edges, _phase, _horizontal_phase_shift, 
        mask);
    o_col = texture2D(_i_tex, uv) * mask;
    // o_col = vec4(mask, 0,0,1);
    // o_col *= mask;
}

void main()
{
    vec4 res = vec4(0);
    MotionTile_with_sample(res, inputTex, uv0,
        tile_centr, vec2(1,1), output_size, 
        mirror_edges, phase, horizontal_phase_shift);
    gl_FragColor = res;
}
