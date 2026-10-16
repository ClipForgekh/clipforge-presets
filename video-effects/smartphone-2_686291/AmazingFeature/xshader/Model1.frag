precision highp float;

uniform sampler2D u_videoTex;

uniform float uv_start;
uniform float uv_length;
uniform int uvtype;

varying vec2 uv;

void main ()
{
    vec2 uv1=uv;
    float edge = 0.005;
    if (uvtype==0)
    {
        if(uv1.y<uv_start || uv1.y>uv_start+uv_length)
            gl_FragColor = vec4(0,0,0,1);
        else
        {
            float d = uv1.y - uv_start;
            float alpha = smoothstep(0.0, edge, d);
            d = (1.0 - uv1.y) - uv_start;
            float alpha1 = smoothstep(0.0, edge, d);
            uv1.y = (uv1.y - uv_start)/uv_length;
            vec4 color = texture2D(u_videoTex, uv1) * alpha * alpha1;
            color.a = 1.;
            gl_FragColor = color;
        }
    }
    else
    {
        if(uv1.x<uv_start || uv1.x>uv_start+uv_length)
            gl_FragColor = vec4(0,0,0,1);
        else
        {
            float d = uv1.x - uv_start;
            float alpha = smoothstep(0.0, edge, d);
            d = (1.0 - uv1.x) - uv_start;
            float alpha1 = smoothstep(0.0, edge, d);
            uv1.x = (uv1.x - uv_start)/uv_length;
            vec4 color = texture2D(u_videoTex, uv1) * alpha * alpha1;
            color.a = 1.;
            gl_FragColor = color;
        }
    }
    
}

