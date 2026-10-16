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
uniform float u_scaleX;
uniform float u_scaleY;
uniform float u_angle;
uniform float u_starShapeIns;
uniform float u_starLineNum;

mat2 rotate2d(in float angle) {
    float s = sin(angle);
    float c = cos(angle);
    return mat2(c, -s, s, c);
}

vec4 blur(sampler2D inputTexture, vec2 textureCoordinate, float blurSize, vec2 screenSize) {
    if(u_intensity < 0.01) {
        return texture2D(inputTexture, textureCoordinate);
    }
    
    // float -> int
    int lineNum = int(floor(u_starLineNum + 0.5));
    
    float starShapeIns = u_starShapeIns;
    float amount = 539.45;
    vec4 oriCol = vec4(0.0);
    vec4 maxCol = oriCol;
    vec4 bokeh = vec4(0.0001);
    vec4 sumCol = vec4(0.0);
    vec4 sumWeight = bokeh;
    vec2 unitUV = vec2(2.0, 2.0) * vec2(u_scaleX, u_scaleY) * vec2(blurSize);
    vec2 screenOffset = 1.0 / screenSize;
    
    float blurStep = mix(1.5, 0.5, u_intensity) * mix(3.5, 1.0, pow(u_quality, 0.6));
    float blurRadius = floor(4.0 / blurStep);
    blurRadius = max(2.0, blurRadius);
    float maxRegionIns = mix(0.7, 1.0, u_regionIns);
    float maxBlurStep = 0.5;
    float maxBlurRadius = 4.0 / maxBlurStep;
    
    mat2 rotMat = rotate2d(u_angle);
    vec2 iOffset = vec2(0.0, 0.75) * floor(maxBlurRadius) / floor(blurRadius);
    
    float floatLineNum = u_starLineNum;
    
    vec2 jOffsetL = iOffset * rotate2d(-3.14159 / floatLineNum);
    vec2 jOffsetR = iOffset * rotate2d(3.14159 / floatLineNum);
    
    for(int h = 0; h < 10; h++) {
        if (h >= lineNum) break;
        
        // Left Side star arm
        for(int i = 0; i < 15; i++) {
            float fi = float(i);
            if (fi >= blurRadius) break;
            
            float jRadius = ceil(starShapeIns * (blurRadius - fi));
            for(int j = 0; j <= 20; j++) {
                float fj = float(j);
                if (fj > jRadius) break;
                if (h > 0 && fi < 0.1 && fj < 0.1) continue;
                
                float p = (starShapeIns * (blurRadius - fi)) / (jRadius + 1.0);
                vec4 tempCol = texture2D(inputTexture, textureCoordinate - (fi * iOffset + p * fj * jOffsetL) * unitUV * rotMat * screenOffset);
                maxCol = max(maxCol, tempCol * mix(1.0, maxRegionIns, step(fj, jRadius - 0.5)));
                bokeh = pow(tempCol, vec4(9.0)) * amount + 0.4;
                bokeh *= mix(1.0, u_regionIns, step(fj, jRadius - 0.5));
                sumCol += bokeh * tempCol;
                sumWeight += bokeh;
            }
        }
        
        // Right Side star arm
        for(int i = 1; i < 15; i++) {
            float fi = float(i);
            if (fi >= blurRadius) break;
            
            float jRadius = ceil(starShapeIns * (blurRadius - fi));
            for(int j = 1; j <= 20; j++) {
                float fj = float(j);
                if (fj > jRadius) break;
                
                float p = (starShapeIns * (blurRadius - fi)) / (jRadius + 1.0);
                vec4 tempCol = texture2D(inputTexture, textureCoordinate - (fi * iOffset + p * fj * jOffsetR) * unitUV * rotMat * screenOffset);
                maxCol = max(maxCol, tempCol * mix(1.0, maxRegionIns, step(fj, jRadius - 0.5)));
                bokeh = pow(tempCol, vec4(9.0)) * amount + 0.4;
                bokeh *= mix(1.0, u_regionIns, step(fj, jRadius - 0.5));
                sumCol += bokeh * tempCol;
                sumWeight += bokeh;
            }
        }
        
        vec4 tempCol = texture2D(inputTexture, textureCoordinate - ((blurRadius - 0.2) * iOffset) * unitUV * rotMat * screenOffset);
        maxCol = max(maxCol, tempCol);
        bokeh = pow(tempCol, vec4(9.0)) * amount + 0.4;
        sumCol += bokeh * tempCol;
        sumWeight += bokeh;
        
        iOffset *= rotate2d(3.14159 * 2.0 / floatLineNum);
        jOffsetL *= rotate2d(3.14159 * 2.0 / floatLineNum);
        jOffsetR *= rotate2d(3.14159 * 2.0 / floatLineNum);
    }

    vec4 resultCol = clamp(sumCol / sumWeight, 0.0, 1.0);
    return vec4(mix(resultCol, maxCol, clamp(resultCol * u_lightIns, 0.0, 1.0)));
}

void main() {
    vec2 screenSize = vec2(u_baseTexWidth, u_baseTexHeight) / min(u_baseTexWidth, u_baseTexHeight) * 720.0;
    gl_FragColor = blur(u_inputTex, vUv, u_blurSize, screenSize);
}
`;