
precision highp float;
varying vec2 uv;
uniform sampler2D inputImageTexture;
uniform sampler2D oriImageTexture;
uniform float GlowRange; 
uniform float baseTexWidth;
uniform float baseTexHeight;
uniform float y_indez;
uniform float alpha;
float uvProtect(vec2 samplerTexCoord)
{
    return step(0.,samplerTexCoord.x)*step(0.,samplerTexCoord.y)*step(samplerTexCoord.x,1.0)*step(samplerTexCoord.y,1.0);
}
void main()
{
    vec4 inputColor = texture2D(inputImageTexture, vec2(1.0-uv.x,uv.y));
    vec4 result = inputColor;
    float sum = 1.0;
    float dx = 2.0 / baseTexWidth * (smoothstep(0.0,0.05,uv.x)*0.5+0.5);
    for(float j=1.0 ; j < 11. ; j+= 1.0)
    {
         if(j>GlowRange)
        break;
        // left
        vec2 samplerTexCoord = vec2(1.0-uv.x + j*dx*y_indez, uv.y);
        float uvPro = uvProtect(samplerTexCoord);
        vec4 tc = texture2D(inputImageTexture, samplerTexCoord);
        result += tc*uvPro;
        sum += 1.0*uvPro;
        //}
        
        //right
        // #ifdef RightBlur2
            vec2 samplerTexCoord1 = vec2(1.0-uv.x - j*dx*y_indez, uv.y );
            uvPro = uvProtect(samplerTexCoord1);
            vec4 tc1 = texture2D(inputImageTexture,samplerTexCoord1);
            result += tc1*uvPro;
            sum += 1.0*uvPro;
        // #endif
       
    }
    result/=(sum);

    // vec4 oriCol=texture2D(oriImageTexture, uv);
    // gl_FragColor =mix(oriCol,result,alpha*0.8);
    gl_FragColor = vec4(result);

}
 