exports.source=`
//===begin_frag_code===
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 进度
uniform float ratio; // = 1.0 [0.1, 2.0]

// 自定义uniform
uniform float uiScale; // = 1.0 [0.6, 1.4] // 加载元素大小
uniform float glitch; // = 1.0 [0.0, 1.0] // 信号下降时的撕裂强度

varying vec2 vUv; // 纹理坐标
const float T0=0.25;const float T1=1.2;float hash1(float n){return fract(sin(n*12.9898 + 4.1414)*43758.5453);}float lum(vec3 c){return dot(c,vec3(0.299,0.587,0.114));}
float ease(float x){float t=clamp(x,0.,1.);return t*t*(3. - 2.*t);}float sdSeg(vec2 p,vec2 a,vec2 b){vec2 pa=p - a;vec2 ba=b - a;
float h=clamp(dot(pa,ba)/dot(ba,ba),0.,1.);return length(pa - ba*h);}float sdRound(vec2 p,vec2 h,float r){vec2 d=abs(p)- h + vec2(r);
return length(max(d,0.))+ min(max(d.x,d.y),0.)- r;}float sdArc(vec2 c,float r,float a0,float a1){float a=atan(c.y,c.x);float d=abs(length(c)- r);if(a<a0||a>a1){
d=min(length(c - r*vec2(cos(a0),sin(a0))),length(c - r*vec2(cos(a1),sin(a1))));}return d;}float glyphD(vec2 p,float c){float d=9.;if(c>1.5&&c<2.5){
d=abs(sdRound(p,vec2(0.3,0.5),0.3));}else if(c>3.5&&c<4.5){
d=min(sdSeg(p,vec2(-0.3,0.5),vec2(-0.3,-0.5)),min(sdSeg(p,vec2(-0.3,0.5),vec2(0.,0.5)),sdSeg(p,vec2(-0.3,-0.5),vec2(0.,-0.5))));if(p.x>=0.){
d=min(d,abs(sdRound(p,vec2(0.3,0.5),0.3)));}}else if(c>4.5&&c<5.5){
d=min(sdSeg(p,vec2(0.,0.5),vec2(0.,-0.5)),min(sdSeg(p,vec2(-0.17,0.5),vec2(0.17,0.5)),sdSeg(p,vec2(-0.17,-0.5),vec2(0.17,-0.5))));}else if(c>5.5&&c<6.5){
d=min(min(sdSeg(p,vec2(-0.3,-0.5),vec2(-0.3,0.5)),sdSeg(p,vec2(-0.3,0.5),vec2(0.3,-0.5))),sdSeg(p,vec2(0.3,-0.5),vec2(0.3,0.5)));}else if(c>6.5&&c<7.5){
d=abs(sdRound(p,vec2(0.3,0.5),0.3));if(p.x>0.12&&p.y>-0.02&&p.y<0.36){d=length(p - vec2(0.254,0.36));}d=min(d,sdSeg(p,vec2(0.06,-0.02),vec2(0.3,-0.02)));}
else if(c>7.5&&c<8.5){
d=min(min(sdSeg(p,vec2(-0.3,0.5),vec2(-0.3,-0.5)),sdSeg(p,vec2(-0.3,0.5),vec2(0.3,0.5))),min(sdSeg(p,vec2(-0.3,0.),vec2(0.18,0.)),sdSeg(p,vec2(-0.3,-0.5),vec2(0.3,-0.5))));
}else if(c>9.5&&c<10.5){d=min(sdSeg(p,vec2(-0.3,0.5),vec2(0.3,0.5)),sdSeg(p,vec2(0.,0.5),vec2(0.,-0.5)));}else if(c>23.5&&c<24.5){
d=min(sdArc(vec2(-p.x,p.y - 0.25),0.25,-1.5708,2.54),sdArc(p - vec2(0.,-0.25),0.25,-2.54,1.5708));}else if(c>27.5&&c<28.5){d=abs(sdRound(p,vec2(0.3,0.5),0.3));
if(p.x>0.1&&abs(p.y)<0.36){d=min(length(p - vec2(0.254,0.36)),length(p - vec2(0.254,-0.36)));}}return d;}float discD(vec2 q){float i=floor(q.x/0.9 + 0.5);float c=0.;
if(i>-0.5&&i<12.5){if(i<5.5){if(i<2.5){if(i<0.5){c=4.;}else{if(i<1.5){c=5.;}else{c=24.;}}}else{if(i<3.5){c=28.;}else{if(i<4.5){c=2.;}else{c=6.;}}}}else{if(i<8.5){
if(i<6.5){c=6.;}else{if(i<7.5){c=8.;}else{c=28.;}}}else{if(i<10.5){if(i<9.5){c=10.;}else{c=5.;}}else{if(i<11.5){c=6.;}else{c=7.;}}}}}
return glyphD(vec2(q.x - i*0.9,q.y),c);}float dotsD(vec2 q,float x0,float nd){float j=clamp(floor((q.x - x0)/0.42 + 0.5),0.,max(nd - 1.,0.));
return length(vec2(q.x - x0 - j*0.42,q.y + 0.45))+ step(nd,0.5)*9.;}vec4 effect(vec4 texel,float progress){float sec=clamp(progress,0.,1.)*2.;
float asp=clamp(ratio,0.3,3.);vec2 p=vec2((vUv.x - 0.5)*asp,vUv.y - 0.5);float tl=clamp((sec - T0)/(T1 - T0),0.,1.);float L=clamp(tl + 0.04*sin(tl*18.849556),0.,1.);
float pct=floor(L*100. + 0.5);float done=step(T1,sec);float topY=1. - vUv.y;float drop=min(floor(L*4.),4.);float lit=4. - drop;float kq=lit/4.;
float fl=exp(-fract(L*4.)*7.)*step(0.5,drop);if(done>0.5){fl=exp(-(sec - T1)/0.07);}vec2 uv=vUv;
uv.x +=(hash1(floor(topY*22.)*3.7 + drop*9.1)- 0.5)*0.06*fl*clamp(glitch,0.,1.);float rows=14.;if(lit>0.5){rows=28.;}if(lit>1.5){rows=56.;}if(lit>2.5){rows=120.;}
vec2 cells=vec2(rows*asp,rows);vec2 uq=(floor(uv*cells)+ 0.5)/cells;if(lit>3.5){uq=uv;}vec3 c=texture2D(tDiffuse,clamp(uq,0.,1.)).rgb;
vec3 bg=mix(vec3(lum(c))*0.55,c,0.25 + 0.75*kq)*mix(0.50,1.,kq);if(lit>3.5){bg=c;}bg +=vec3(1.,0.5,0.4)*fl*0.10;vec3 col=bg;float uiA=smoothstep(0.06,0.24,sec);
float s=clamp(uiScale,0.6,1.4)*min(1.,asp/0.62);vec2 u=p/s;float rb=length(u - vec2(0.,0.02));if(rb<0.28){col*=1. - 0.55*(1. - smoothstep(0.10,0.28,rb));
vec2 ic=u - vec2(0.,-0.005);float dW=length(ic)- 0.006;float iw=0.;float d1=sdArc(ic,0.042,0.7854,2.3562);if(d1<dW){dW=d1;iw=1.;}float d2=sdArc(ic,0.074,0.7854,2.3562);
if(d2<dW){dW=d2;iw=2.;}float d3=sdArc(ic,0.106,0.7854,2.3562);if(d3<dW){dW=d3;iw=3.;}vec3 wc=vec3(0.40,0.42,0.48);if(iw + 0.5<lit){wc=vec3(1.);}
if(abs(iw -(lit - 1.))<0.5&&fract(sec/0.24)<0.5){wc=vec3(1.,0.70,0.25);}if(lit<0.5&&iw<0.5){wc=vec3(1.,0.35,0.30);}col=mix(col,wc,1. - smoothstep(0.008,0.011,dW));
if(abs(u.y + 0.068)<0.024){vec2 tq=(u - vec2(-5.4*0.027,-0.068))/0.027;{float td=min(discD(tq),dotsD(tq,11.35,mod(floor(sec/0.12),4.)));float ta=0.0016/(0.027*s);
col=mix(col,vec3(0.),(1. - smoothstep(0.1,0.27,td))*0.55*(1.));col=mix(col,vec3(1.),(1. - smoothstep(0.1 - ta,0.1 + ta,td))*(1.));}}}col=mix(bg,clamp(col,0.,1.),uiA);
float a=1. - ease((sec - T1 - 0.06)/0.30);vec3 outc=clamp(col,0.,1.)*a;float outa=texel.a*a;if(sec<=0.045){outc=texel.rgb;outa=texel.a;}if(sec>=T1 + 0.40){outc=vec3(0.);
outa=0.;}return vec4(outc,outa);}void main(){vec4 texel=texture2D(tDiffuse,vUv);gl_FragColor=effect(texel,progress);}
//===end_frag_code===
//===end_frag_code===
`;