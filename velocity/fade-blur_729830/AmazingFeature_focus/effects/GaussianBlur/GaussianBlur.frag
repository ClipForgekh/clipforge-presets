precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTex;
uniform float u_Angle;
uniform float u_Strength;
uniform float u_SizeScale;
uniform vec4 u_ScreenSize;
vec4 gaussianBlur(sampler2D i_InputTex, vec2 i_Uv, vec2 i_Dir, float i_Strength)
{
    const int  radius = 8;
    float half_gaussian_weight[9];
    half_gaussian_weight[0]= 0.20;//0.137401;
    half_gaussian_weight[1]= 0.19;//0.125794;
    half_gaussian_weight[2]= 0.17;//0.106483;
    half_gaussian_weight[3]= 0.15;//0.080657;
    half_gaussian_weight[4]= 0.13;//0.054670;
    half_gaussian_weight[5]= 0.11;//0.033159;
    half_gaussian_weight[6]= 0.08;//0.017997;
    half_gaussian_weight[7]= 0.05;//0.008741;
    half_gaussian_weight[8]= 0.02;//0.003799;
    vec4 sum            = vec4(0.0);
    vec4 result         = vec4(0.0);
    vec2 unit_uv        = i_Dir * i_Strength;
    vec4 curColor       = texture2D(i_InputTex, i_Uv);
    vec4 centerPixel    = curColor*half_gaussian_weight[0];
    float sum_weight    = half_gaussian_weight[0];
    for(int i=1;i<=radius;i++)
    {
        vec2 curRightCoordinate = i_Uv+float(i)*unit_uv;
        vec2 curLeftCoordinate  = i_Uv+float(-i)*unit_uv;
        vec4 rightColor = texture2D(i_InputTex, curRightCoordinate);
        vec4 leftColor = texture2D(i_InputTex, curLeftCoordinate);
        sum+=rightColor*half_gaussian_weight[i];
        sum+=leftColor*half_gaussian_weight[i];
        sum_weight+=half_gaussian_weight[i]*2.0;
    }
    result = (sum+centerPixel)/sum_weight; 
    return result;
}

void main()
{
    float theta = u_Angle * 3.1415926 / 180.;
    vec2 rect = vec2(min(720.0, 720.0 * u_ScreenSize.x / u_ScreenSize.y), min(720.0, 720.0 * u_ScreenSize.y / u_ScreenSize.x));
    vec2 dir = vec2(cos(theta), sin(theta)) / rect.xy;
    vec4 color = gaussianBlur(u_InputTex, uv0, dir, u_Strength * u_SizeScale);
    gl_FragColor = color;
}
