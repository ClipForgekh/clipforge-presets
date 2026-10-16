precision highp float;

varying vec2 uv0;
uniform sampler2D inputImageTexture;

uniform float strength;

float random(in vec3 scale, in float seed) {
    /* use the fragment position for randomness */
    return fract(sin(dot(gl_FragCoord.xyz + seed, scale)) * 758.5453 + seed);
}

void main()
{
    vec4 colSrc;

    vec2 center = vec2(.5,.5);
    // float strength = .4;
    float strength1 = .2;
    vec4 color = vec4(0.0);
    float total = 0.0;
    vec2 toCenter = center - uv0;

    /* randomize the lookup values to hide the fixed number of samples */
    float offset = random(vec3(12.9898, 78.233, 151.7182), 0.0);
    for (float t = 0.0; t <= 20.0; t++) {
        float percent = (t + offset) / 20.0;
        float weight = 1.;//((percent - percent * percent));
        vec2 uvNew = uv0 - toCenter * percent * strength;
        float w =  step(uvNew.x, 1.) * step(uvNew.y, 1.) * step(0., uvNew.x) * step(0., uvNew.y);
        color += texture2D(inputImageTexture, uvNew) * weight;
        // }
        // else
        //     color += texture2D(inputImageTexture, texCoord + toCenter * percent * strength1).rgb * weight;
        total += weight;
    }
    color /= total;
    vec4 resultColor = texture2D(inputImageTexture, uv0);
    resultColor = mix(resultColor, color, color.a);
    gl_FragColor = color;
}
 