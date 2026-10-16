precision highp float;

varying vec2 uv0;
uniform sampler2D sourceTex;
uniform sampler2D starglowTex_left;
uniform sampler2D starglowTex_right;
uniform float source_alpha;
uniform float starglow_alpha;
uniform vec4 u_ScreenParams;

// add
float blendAdd(float base, float blend) {
    return min(base+blend,1.0);
}

vec3 blendAdd(vec3 base, vec3 blend) {
    return min(base+blend,vec3(1.0));
}

vec3 blendFunc(vec3 base,vec3 blend,float opacity)  //opacity
{
    vec3 res=blendAdd(base,blend);//
    res=mix(base,res,opacity);
    return res;
}

void main()
{
    vec4 source_col = texture2D(sourceTex, uv0) * source_alpha;
    vec4 sg_left_col = texture2D(starglowTex_left, uv0) * starglow_alpha;
    vec4 sg_right_col = texture2D(starglowTex_right, uv0);

    vec4 sg_col = sg_left_col;
    sg_col = sg_col * (1.-sg_right_col.a) + sg_right_col;
    vec4 res = source_col * 1.;

    res.rgb = blendFunc(source_col.rgb, sg_col.rgb, starglow_alpha);
    res.a = max(res.a, sg_col.a);


    gl_FragColor = res;
}
