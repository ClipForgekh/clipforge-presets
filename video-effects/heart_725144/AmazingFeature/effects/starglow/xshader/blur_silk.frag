precision highp float;

varying vec2 uv0;
uniform sampler2D inputTex;
uniform float individual_len;
uniform vec3 colormap_hightlight;
uniform vec3 colormap_midtones;
uniform vec3 colormap_shadows;
uniform vec2 individual_dir;
uniform vec4 u_ScreenParams;

float normpdf(in float x, in float sigma)
{
	return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
}
vec4 gaussianBlur(sampler2D i_InputTex, vec2 i_Uv, vec2 i_Dir)
{
    const int  radius = 32;
    float sigma = 4.0;
    float first = normpdf(0.0, sigma);
    float weight = 0.5 * 1.02 + 0.5;

    vec4 sum            = vec4(0.0);
    vec4 result         = vec4(0.0);
    vec4 curColor       = texture2D(i_InputTex, i_Uv);
    vec4 centerPixel    = pow(curColor, vec4(2.2))*weight;
    float sum_weight    = weight;
    // #ifdef GLOWSAMPLE
    // float s = float(GLOWSAMPLE);
    const float SAMPLE_COUNT = 128.;
    for(float i=1.;i<=SAMPLE_COUNT;i+=1.0)
    {
        vec2 curRightCoordinate = mix(i_Uv, i_Uv+i*i_Dir*individual_len*0.1, i/SAMPLE_COUNT);
        // vec2 curLeftCoordinate  = i_Uv+float(-i)*unit_uv;
        vec4 rightColor = texture2D(i_InputTex, curRightCoordinate);
        // vec4 leftColor = texture2D(i_InputTex, curLeftCoordinate);
        weight = (normpdf(float(i) / SAMPLE_COUNT * 15.0, sigma) / first - 0.5) * 1.02 + 0.5;
        sum+=pow(rightColor, vec4(2.2))*weight;
        // sum+=pow(leftColor, vec4(2.2))*weight;
        sum_weight+=weight;
    }
    // #endif
    result = (sum+centerPixel)/sum_weight; 
    return pow(clamp(result, 0.0, 1.0), vec4(1.0 / 2.2));
}

void main()
{
    vec2 dir = normalize(individual_dir);
    dir.x *= u_ScreenParams.x/u_ScreenParams.y;
    vec4 res = gaussianBlur(inputTex, uv0, dir);

    float shadows_region = smoothstep(0.0, 1./3., res.r);
    float midtones_region = smoothstep(1./3., 2./3., res.r);
    float hightlight_region = smoothstep(2./3., 3./3., res.r);

    res.rgb = mix(colormap_shadows, colormap_midtones, shadows_region);
    res.rgb = mix(res.rgb, colormap_hightlight, hightlight_region);
    res.rgb *= res.a;

    gl_FragColor = res;
}
