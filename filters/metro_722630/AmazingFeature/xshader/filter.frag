#if defined(AE_FRAMEBUFFER_FETCH)
    #if defined(GL_EXT_shader_framebuffer_fetch)
        #extension GL_EXT_shader_framebuffer_fetch : require
    #elif defined(GL_ARM_shader_framebuffer_fetch)
        #extension GL_ARM_shader_framebuffer_fetch : require
    #endif
#endif
#define ae_insert_flip_uniform // FlipPatch will insert flip uniform here

precision lowp float;
varying highp vec2 uv0;
#define textureCoordinate uv0
uniform sampler2D u_FBOTexture;
#define inputImageTexture u_FBOTexture
uniform sampler2D u_albedo;
#define inputImageTexture2 u_albedo
uniform float uniAlpha;

vec4 textureFromFBO(vec2 uv)
{
    #if defined(AE_FRAMEBUFFER_FETCH)
        #if defined(GL_EXT_shader_framebuffer_fetch)
            vec4 result = gl_LastFragData[0].rgba;
        #elif defined(GL_ARM_shader_framebuffer_fetch)
            vec4 result = gl_LastFragColorARM;
        #else
            #error AE_FRAMEBUFFER_FETCH but no ext found!
        #endif
    #else
        vec4 result = texture2D(u_FBOTexture, uv);
    #endif
    return result;
}
void main()
{
    vec4 textureColor = textureFromFBO(textureCoordinate);
    float blueColor = textureColor.b * 63.0;
    highp vec2 quad1;
    quad1.y = floor(floor(blueColor) / 8.0);
    quad1.x = floor(blueColor) - (quad1.y * 8.0);
    highp vec2 quad2;
    quad2.y = floor(ceil(blueColor) /8.0);
    quad2.x = ceil(blueColor) - (quad2.y * 8.0);
    highp vec2 texPos1;
    texPos1.x = (quad1.x * 1.0/8.0) + 0.5/512.0 + ((1.0/8.0 - 1.0/512.0) * textureColor.r);
    texPos1.y = (quad1.y * 1.0/8.0) + 0.5/512.0 + ((1.0/8.0 - 1.0/512.0) * textureColor.g);
    //texPos1.x = 1.0 - texPos1.x;
    // texPos1.y = 1.0 - texPos1.y;
    highp vec2 texPos2;
    texPos2.x = (quad2.x * 1.0/8.0) + 0.5/512.0 + ((1.0/8.0 - 1.0/512.0) * textureColor.r);
    texPos2.y = (quad2.y * 1.0/8.0) + 0.5/512.0 + ((1.0/8.0 - 1.0/512.0) * textureColor.g);
    //texPos2.x = 1.0 - texPos2.x;
    // texPos2.y = 1.0 - texPos2.y;
    lowp vec4 newColor1 = texture2D(inputImageTexture2, texPos1);
    lowp vec4 newColor2 = texture2D(inputImageTexture2, texPos2);
    lowp vec4 newColor = mix(newColor1, newColor2, fract(blueColor));
    gl_FragColor = vec4(mix(textureColor.rgb, newColor.rgb, uniAlpha), 1.0);
}
