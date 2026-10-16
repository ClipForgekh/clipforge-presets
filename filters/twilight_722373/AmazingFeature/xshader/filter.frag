


#version 300 es
precision highp sampler3D;
precision highp float;
in vec2 uv0;

uniform sampler2D ganTexture;
#define textureCoordinate uv0
uniform sampler2D VIDEO;
#define inputImageTexture VIDEO
uniform sampler3D u_albedo;
uniform sampler3D u_albedo1;
#define inputImageTexture2 u_albedo
uniform float uniAlpha;
out vec4 fragColor;

vec4 sampleLut(vec4 baseColor)
{
    return texture(inputImageTexture2, baseColor.rgb);
}


void main() 
{
    float mask = texture(ganTexture, vec2(textureCoordinate.x,1.0-textureCoordinate.y)).a;
    vec4 srcColor = texture(inputImageTexture, textureCoordinate);
    vec4 newColor = srcColor;
    newColor.xyz = sampleLut(srcColor).xyz;

    vec3 bgColor = texture(u_albedo1, srcColor.rgb).xyz;

    // fragColor = newColor;
    // vec4 curColor = vec4(mix(srcColor.rgb, newColor.rgb, uniAlpha), srcColor.a);
    // fragColor = mix(curColor,srcColor,1.0-mask);

    vec3 final = mix(newColor.rgb, bgColor.rgb, 1.0-mask);
    final.rgb = mix(srcColor.rgb, final.rgb, srcColor.a);
    // gl_FragColor = vec4(mix(textureColor1.rgb, final.rgb, intensity), textureColor1.a); 
    fragColor = vec4(mix(srcColor.rgb, final.rgb, uniAlpha), srcColor.a); 
    // fragColor = vec4(mask);
}



// precision highp float;

// uniform sampler2D inputTexture;
// uniform sampler2D ganTexture;
// uniform sampler2D filterBgTexture;
// uniform sampler2D filterSkinTexture;
// uniform float reflector;

// varying vec2 texcoord1;

// uniform float intensity;

// void main() {
//     highp vec4 textureColor1 = texture2D(inputTexture, texcoord1);
//     textureColor1 = clamp(textureColor1, 0.0, 1.0);
    
//     highp float blueColor = textureColor1.b * 63.0;
    
//     highp vec2 quad1;
//     quad1.y = floor(floor(blueColor) / 8.0);
//     quad1.x = floor(blueColor) - (quad1.y * 8.0);

//     highp vec2 texPos1 = (quad1.xy * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor1.rg);

//     lowp vec4 newColor12 = texture2D(filterBgTexture, texPos1);
//     lowp vec4 newColor22 = texture2D(filterSkinTexture, texPos1);

//     vec2 maskCoord = vec2(texcoord1.x, 1.0 - texcoord1.y);
//     float mask = texture2D(ganTexture, maskCoord).a;

//     vec3 final = mix(newColor12.rgb, newColor22.rgb, mask);

//     gl_FragColor = vec4(mix(textureColor1.rgb, final.rgb, intensity), textureColor1.a); 
// }
