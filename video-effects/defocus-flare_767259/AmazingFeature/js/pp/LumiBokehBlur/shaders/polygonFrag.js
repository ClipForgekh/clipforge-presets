exports.source=`
precision highp float;

varying vec2 vUv;

uniform sampler2D u_inputTex;
uniform float u_baseTexWidth;
uniform float u_baseTexHeight;
uniform float u_blurSize;
uniform float u_lightIns;
uniform float u_intensity;
uniform float u_regionIns;
uniform float u_quality;
uniform int u_lineNum;
uniform float u_angle;
uniform vec2 u_posVec[10];

mat2 rotate2d(in float angle) {
    float s = sin(angle);
    float c = cos(angle);
    return mat2(c, -s, s, c);
}

float side(vec2 p, vec2 a, vec2 b) {
    vec2 pa = p - a, ba = b - a;
    return step(cross(vec3(pa, 0.0), vec3(ba, 0.0)).z, 0.0);
}

float sdf(vec2 uv) {
    vec2 newUV = uv;
    // Get the edges of the closed polygon connected end-to-end
    vec2 lastPos = u_posVec[0];
    for(int k = 0; k < 10; k++){
        if(k == u_lineNum) {
            lastPos = u_posVec[k];
            break;
        }
    }
    
    float d = side(newUV, lastPos, u_posVec[0]);
    for (int i = 0; i < 10; i++) {
        if (i >= u_lineNum) break;
        d *= side(newUV, u_posVec[i], u_posVec[i + 1]);
    }
    return d;
}

vec4 blur(sampler2D inputTexture, vec2 textureCoordinate, float blurSize, vec2 screenSize) {
    if (u_intensity < 0.01) {
        return texture2D(inputTexture, textureCoordinate);
    }
    
    float amount = 539.45;
    vec4 oriCol = vec4(0.0);
    vec4 maxCol = oriCol;
    vec4 bokeh = vec4(0.0001);
    vec4 sumCol = vec4(0.0);
    vec4 sumWeight = bokeh;
    vec2 unitUV = vec2(2.0, 2.0) * vec2(blurSize);
    vec2 screenOffset = 1.0 / screenSize;

    float blurStep = mix(2.0, 0.5, u_intensity) * mix(2.0, 1.0, u_quality);
    float blurRadius = 12.0 / blurStep * mix(0.65, 1.0, u_quality);
    blurRadius = max(5.0, blurRadius);
    float maxRegionIns = mix(0.7, 1.0, u_regionIns);
    mat2 rotMat = rotate2d(u_angle);
    
    for (int i = 0; i < 30; i++) {
        float fi = float(i);
        if (fi > blurRadius || u_intensity < 0.3) break;
        
        for (int j = 0; j < 30; j++) {
            float fj = float(j);
            if (fj > blurRadius) break;
            
            vec2 tempVec = vec2(mix(-11.0, 11.0, fi / blurRadius), mix(-11.0, 11.0, fj / blurRadius));
            if (sdf(tempVec) < 0.5) continue;
            
            vec4 tempCol = texture2D(inputTexture, (textureCoordinate - 0.5 * tempVec * unitUV * rotMat * screenOffset));
            maxCol = max(maxCol, tempCol * maxRegionIns);
            bokeh = pow(tempCol, vec4(9.0)) * amount + 0.4;
            bokeh *= u_regionIns;
            sumCol += bokeh * tempCol;
            sumWeight += bokeh;
        }
    }
    
    for (int j = 0; j < 10; j++) {
        if (j >= u_lineNum) break;
        
        float lineLength = length(u_posVec[j] - u_posVec[j + 1]) / 1.5 * mix(0.5, 1.0, clamp(u_quality * 1.5, 0.0, 1.0));
        lineLength = max(lineLength, 3.0);
        
        for (int i = 0; i < 40; i++) {
            float fi = float(i);
            float p = fi * blurStep;
            if (p > lineLength) break;
            
            vec2 tempVec = mix(u_posVec[j], u_posVec[j + 1], p / lineLength);
            vec4 tempCol = texture2D(inputTexture, (textureCoordinate - 0.5 * tempVec * unitUV * rotMat * screenOffset));
            maxCol = max(maxCol, tempCol);
            bokeh = pow(tempCol, vec4(9.0)) * amount + 0.4;
            sumCol += bokeh * tempCol;
            sumWeight += bokeh;
        }
    }

    vec4 resultCol = clamp(sumCol / sumWeight, 0.0, 1.0);
    return vec4(mix(resultCol, maxCol, clamp(resultCol * u_lightIns, 0.0, 1.0)));
}

void main() {
    vec2 screenSize = vec2(u_baseTexWidth, u_baseTexHeight) / min(u_baseTexWidth, u_baseTexHeight) * 720.0;
    gl_FragColor = blur(u_inputTex, vUv, u_blurSize, screenSize);
}
`;