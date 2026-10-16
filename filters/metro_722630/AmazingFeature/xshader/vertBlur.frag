precision highp float;
varying vec2 TexCoords;
uniform sampler2D u_horzBlurTexture;

uniform float horizontal;
uniform float radius;
uniform int BlurSize;

uniform vec4 u_ScreenParams;

float gaussianWeight(float dist, float stdDev)
{
    return exp(-dist / (2.0 * stdDev));
}

vec4 gaussianBlur(sampler2D inputTexture, vec2 textureCoordinate, int blurRadius, float stepUV, vec2 screenSize)
{
    vec2 unitUV         = vec2(0.0, stepUV*screenSize.x/screenSize.y)/720.;
    float stdDev        = 112.0;
    float sumWeight     = gaussianWeight(0.0,stdDev);
    vec4 curColor       = texture2D(inputTexture, textureCoordinate);
    vec4 sumColor       = curColor*sumWeight;
    vec2 textureCoordinateA;
    vec2 textureCoordinateB;
    vec4 colorA;
    vec4 colorB;
    float curWeight;
    for(int i=1;i<=6;i++)
    {
        if (i > blurRadius)
        {
            break;
        }
        textureCoordinateA = textureCoordinate+float(i)*unitUV;
        textureCoordinateB = textureCoordinate+float(-i)*unitUV;
        colorA = texture2D(inputTexture,textureCoordinateA);
        colorB = texture2D(inputTexture,textureCoordinateB);
        curWeight = gaussianWeight(float(i),stdDev);
        sumColor += colorA*curWeight;
        sumColor += colorB*curWeight;
        sumWeight+= curWeight*2.0;
    }
    vec4 resultColor = sumColor/sumWeight;
    return resultColor;
}

void main()
{
    gl_FragColor = gaussianBlur(u_horzBlurTexture, TexCoords, BlurSize, radius, u_ScreenParams.xy);
}