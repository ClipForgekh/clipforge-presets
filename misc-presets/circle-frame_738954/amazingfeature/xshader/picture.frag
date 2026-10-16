precision highp float;
varying vec2 uv0;
varying vec2 samp;
uniform sampler2D u_albedo;
uniform float u_aspect;
uniform vec2 u_size;
uniform float u_diff;
uniform float u_invert;
void main()
{
    float a = u_size.x * u_aspect;
    float b = u_size.y;
    float alpha = samp.x * samp.x / (a * a) + samp.y * samp.y / (b * b);
    alpha = clamp(smoothstep(0.995 - u_diff, 1.005 + u_diff, alpha), 0.0, 1.0);
    if (u_invert < 1.0)
    {
        alpha = 1.0 - alpha;
    }
    gl_FragColor = texture2D(u_albedo, uv0) * alpha;
}
