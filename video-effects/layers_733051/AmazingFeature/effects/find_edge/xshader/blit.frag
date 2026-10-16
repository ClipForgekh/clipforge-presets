precision highp float;

varying vec2 uv;
uniform sampler2D inputImageTexture;
uniform vec4 u_ScreenParams;
uniform float brightness;
uniform float grayColor;
uniform float upperLimit;
uniform float lowerLimit;

void main()
{
    vec2 mySize = u_ScreenParams.xy/min(u_ScreenParams.x,u_ScreenParams.y)*720.;
    vec2 unit = 0.5/mySize;
    vec4 gx = vec4(0.0);
    gx += -1.0 * texture2D(inputImageTexture, uv+vec2(-1.0*unit.x, -1.0*unit.y));
    gx += -2.0 * texture2D(inputImageTexture, uv+vec2(-1.0*unit.x,  0.0*unit.y));
    gx += -1.0 * texture2D(inputImageTexture, uv+vec2(-1.0*unit.x,  1.0*unit.y));
    gx +=  1.0 * texture2D(inputImageTexture, uv+vec2( 1.0*unit.x, -1.0*unit.y));
    gx +=  2.0 * texture2D(inputImageTexture, uv+vec2( 1.0*unit.x,  0.0*unit.y));
    gx +=  1.0 * texture2D(inputImageTexture, uv+vec2( 1.0*unit.x,  1.0*unit.y));
    vec4 gy = vec4(0.0);
    gy += -1.0 * texture2D(inputImageTexture, uv+vec2(-1.0*unit.x, -1.0*unit.y));
    gy += -2.0 * texture2D(inputImageTexture, uv+vec2( 0.0*unit.x, -1.0*unit.y));
    gy += -1.0 * texture2D(inputImageTexture, uv+vec2( 1.0*unit.x, -1.0*unit.y));
    gy +=  1.0 * texture2D(inputImageTexture, uv+vec2(-1.0*unit.x, 1.0*unit.y));
    gy +=  2.0 * texture2D(inputImageTexture, uv+vec2( 0.0*unit.x, 1.0*unit.y));
    gy +=  1.0 * texture2D(inputImageTexture, uv+vec2( 1.0*unit.x, 1.0*unit.y));
    vec4 g = vec4(0.0);
    if (grayColor > 0.5)
    {
        float x = 0.333*gx.r+0.333*gx.g+0.333*gx.b;
        float y = 0.333*gy.r+0.333*gy.g+0.333*gy.b;
        g = vec4(x*x + y*y);
    }
    else
    {
        g = gx*gx + gy*gy;
    }
    g = g* brightness;
    g = mix(vec4(.3), g, g.r);
    g.a = 1.0;
    gl_FragColor = g;
}
