
precision highp float;
varying vec2 uv;
uniform sampler2D inputImageTexture;
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
    vec4 result = texture2D(inputImageTexture, vec2(uv.x,uv.y));
    float sum = 1.0;
    float dx = 2.0 / baseTexWidth * (smoothstep(0.0,0.05,1.0-uv.x)*0.5+0.5);

    for(float j=1.0 ; j < 11. ; j+= 1.0)
    {
        // left
        if(j>GlowRange)
        break;
        vec2 samplerTexCoord = vec2(uv.x + j*dx*y_indez, uv.y);
        float uvPro = uvProtect(samplerTexCoord);
        vec4 tc = texture2D(inputImageTexture, samplerTexCoord);
        result += tc*uvPro;
        sum += 1.0*uvPro;
        //}
        
        //right
   
            vec2 samplerTexCoord1 = vec2(uv.x - j*dx*y_indez, uv.y );
            uvPro = uvProtect(samplerTexCoord1);
            vec4 tc1 = texture2D(inputImageTexture,samplerTexCoord1);
            result += tc1*uvPro;
            sum += 1.0*uvPro;

        
    }
    result/=(sum);
    gl_FragColor =result;

}
 