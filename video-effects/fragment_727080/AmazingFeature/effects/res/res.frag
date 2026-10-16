precision highp float;

varying vec2 uv0;

uniform sampler2D inputTex;
uniform sampler2D leftTex;
uniform sampler2D rightTex;
uniform sampler2D bgTex;


void main()
{
    vec2 uv1 = uv0;
    vec4 leftCol = texture2D(leftTex, uv1);
    vec4 rightCol = texture2D(rightTex, uv1);
    vec4 bgCol = texture2D(bgTex, uv1);

    vec4 res = leftCol;
    res = rightCol * (1.-res.a) + res;
    res = bgCol * (1.-res.a) + res;
    // res = mix(rightCol, res, res.a);
    // res = mix(bgCol, res, res.a);

    // res = texture2D(inputTex, uv1);

    gl_FragColor = res;
}
