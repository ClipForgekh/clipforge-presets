precision highp float;
precision highp int;

uniform vec2 u_offset;
uniform vec2 u_moveCenter;
uniform vec2 u_scale;
uniform mediump int u_movingType;
uniform vec2 u_wdsoffset;
uniform vec2 u_wordsOffset;
uniform vec2 u_offset3;
uniform vec2 u_offset2;
uniform vec2 u_wordsCenter;
uniform vec2 u_scale2;
uniform float u_wordsScale;
uniform mediump sampler2D u_inputTexture;
uniform mediump sampler2D u_blurBgTexture;
uniform mediump sampler2D u_maskTexture;
uniform mediump sampler2D u_wordsTexture;

varying vec2 v_uv;

void main()
{
    vec2 _22 = vec2(v_uv.x, 1.0 - v_uv.y);
    vec2 _t2 = vec2(0.0);
    vec2 _t3 = vec2(0.0);
    float _t4 = 1.0;
    float _t5 = 1.0;
    if (u_movingType == 0)
    {
        vec2 _65 = _22 + min(u_wdsoffset - u_wordsOffset, u_offset3);
        _t3 = _65 - u_offset2;
        _t2 = _65 + u_offset2;
        float _79 = 0.5 + u_offset3.y;
        if (_t2.y > _79)
        {
            _t4 = 0.0;
        }
        if (_t3.y < _79)
        {
            _t5 = 0.0;
        }
    }
    else
    {
        vec2 _98 = _22 + max(u_offset - u_wordsOffset, u_offset3);
        _t3 = _98 - u_offset2;
        _t2 = _98 + u_offset2;
        if (_t2.y > 0.5)
        {
            _t4 = 0.0;
        }
        if (_t3.y < 0.5)
        {
            _t5 = 0.0;
        }
    }
    vec2 _117 = _t2;
    vec2 _127 = _t3;
    vec2 _141 = vec2(u_wordsScale);
    vec2 _145 = (((((_117 - u_wordsCenter) / u_scale2) + u_wordsCenter) - vec2(0.5)) / _141) + vec2(0.5);
    _t2 = _145;
    vec2 _155 = (((((_127 - u_wordsCenter) / u_scale2) + u_wordsCenter) - vec2(0.5)) / _141) + vec2(0.5);
    _t3 = _155;
    mediump vec4 _170 = texture2D(u_blurBgTexture, v_uv);
    vec4 _t7 = _170;
    vec3 _174 = _170.xyz * 0.5;
    _t7.x = _174.x;
    _t7.y = _174.y;
    _t7.z = _174.z;
    mediump vec4 _186 = texture2D(u_maskTexture, (((_22 + u_offset) - u_moveCenter) / u_scale) + u_moveCenter);
    vec4 _t8 = _186;
    vec4 _t9 = texture2D(u_wordsTexture, _145 * _t4);
    vec4 _t10 = texture2D(u_wordsTexture, _155 * _t5);
    vec3 _213 = texture2D(u_inputTexture, v_uv).xyz;
    gl_FragData[0] = vec4(mix(mix(mix(_t7, _186, vec4(_t8.w)).xyz, _213, vec3(smoothstep(0.20000000298023223876953125, 0.800000011920928955078125, _t9.x))), _213, vec3(smoothstep(0.20000000298023223876953125, 0.800000011920928955078125, _t10.x))), clamp(_t4 + _t5, 0.0, 1.0));
}

