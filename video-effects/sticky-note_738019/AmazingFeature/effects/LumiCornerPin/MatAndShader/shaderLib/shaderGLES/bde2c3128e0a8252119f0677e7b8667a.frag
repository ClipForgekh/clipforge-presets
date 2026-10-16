precision highp float;
precision highp int;

uniform vec2 u_downLeftVertex;
uniform vec2 u_downRightVertex;
uniform vec2 u_upRightVertex;
uniform vec2 u_upLeftVertex;
uniform mediump int u_motionTileType;
uniform mediump sampler2D u_InputTex;

varying vec2 v_uv;

void main()
{
    vec3 _454 = mat3(vec3(u_downRightVertex.y - u_upRightVertex.y, u_upRightVertex.y - u_downLeftVertex.y, u_downLeftVertex.y - u_downRightVertex.y), vec3(u_upRightVertex.x - u_downRightVertex.x, u_downLeftVertex.x - u_upRightVertex.x, u_downRightVertex.x - u_downLeftVertex.x), vec3(u_downRightVertex.x * u_upRightVertex.y + (-(u_upRightVertex.x * u_downRightVertex.y)), u_upRightVertex.x * u_downLeftVertex.y + (-(u_downLeftVertex.x * u_upRightVertex.y)), u_downLeftVertex.x * u_downRightVertex.y + (-(u_downRightVertex.x * u_downLeftVertex.y)))) * vec3(u_upLeftVertex, 1.0);
    mat3 _479 = mat3(vec3(u_downLeftVertex, 1.0), vec3(u_downRightVertex, 1.0), vec3(u_upRightVertex, 1.0)) * mat3(vec3(_454.x, 0.0, 0.0), vec3(0.0, _454.y, 0.0), vec3(0.0, 0.0, _454.z));
    float _782 = _479[1].y;
    float _784 = _479[2].z;
    float _787 = _479[2].y;
    float _789 = _479[1].z;
    float _795 = _479[0].z;
    float _798 = _479[0].y;
    float _816 = _479[2].x;
    float _821 = _479[1].x;
    float _827 = _479[0].x;
    vec3 _903 = ((mat3(vec3(0.0, 0.0, 1.0), vec3(1.0, 0.0, 1.0), vec3(1.0)) * mat3(vec3(1.0, 0.0, 0.0), vec3(0.0, -1.0, 0.0), vec3(0.0, 0.0, 1.0))) * mat3(vec3(_782 * _784 + (-(_787 * _789)), _787 * _795 + (-(_798 * _784)), _798 * _789 + (-(_782 * _795))), vec3(_816 * _789 + (-(_821 * _784)), _827 * _784 + (-(_816 * _795)), _821 * _795 + (-(_827 * _789))), vec3(_821 * _787 + (-(_816 * _782)), _816 * _798 + (-(_827 * _787)), _827 * _782 + (-(_821 * _798))))) * vec3(v_uv, 1.0);
    vec2 _909 = _903.xy / vec2(_903.z);
    vec2 _1056;
    float _1059;
    if (u_motionTileType == 0)
    {
        float _913 = _909.x;
        float _920 = _909.y;
        _1059 = ((step(0.0, _913) * step(_913, 1.0)) * step(0.0, _920)) * step(_920, 1.0);
        _1056 = _909;
    }
    else
    {
        vec2 _1057;
        if (u_motionTileType == 1)
        {
            _1057 = abs(mod(_909 - vec2(1.0), vec2(2.0)) - vec2(1.0));
        }
        else
        {
            vec2 _1058;
            if (u_motionTileType == 2)
            {
                _1058 = fract(_909);
            }
            else
            {
                _1058 = _909;
            }
            _1057 = _1058;
        }
        _1059 = 1.0;
        _1056 = _1057;
    }
    gl_FragData[0] = texture2D(u_InputTex, _1056) * _1059;
}

