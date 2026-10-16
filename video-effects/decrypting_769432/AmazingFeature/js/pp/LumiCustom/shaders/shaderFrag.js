exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 进度
uniform float ratio; // = 1.0 [0.1, 2.0]

// 自定义uniform
uniform float uiScale; // = 1.0 [0.6, 1.4] // 加载元素大小

varying vec2 vUv; // 纹理坐标
const float BLANK=0.15;const float T0=0.15;const float T1=1.15;float hash1(float n){return fract(sin(n*12.9898 + 4.1414)*43758.5453);}float hash2(vec2 p){
return fract(sin(dot(p,vec2(12.9898,78.233)))*43758.5453);}float ease(float x){float t=clamp(x,0.,1.);return t*t*(3. - 2.*t);}vec2 rot2(vec2 v,float a){float cs=cos(a);
float sn=sin(a);return vec2(cs*v.x - sn*v.y,sn*v.x + cs*v.y);}float sdSeg(vec2 p,vec2 a,vec2 b){vec2 pa=p - a;vec2 ba=b - a;float h=clamp(dot(pa,ba)/dot(ba,ba),0.,1.);
return length(pa - ba*h);}float sdRound(vec2 p,vec2 h,float r){vec2 d=abs(p)- h + vec2(r);return length(max(d,0.))+ min(max(d.x,d.y),0.)- r;}
float sdArc(vec2 c,float r,float a0,float a1){float a=atan(c.y,c.x);float d=abs(length(c)- r);if(a<a0||a>a1){
d=min(length(c - r*vec2(cos(a0),sin(a0))),length(c - r*vec2(cos(a1),sin(a1))));}return d;}
void bigMix(inout vec3 col,float td,float tds,float ta,float ow,float al,vec3 fill,vec3 outl){col=mix(col,vec3(0.),(1. - smoothstep(ow - 0.02,ow + 0.08,tds))*0.40*al);
col=mix(col,outl,(1. - smoothstep(ow - ta,ow + ta,td))*al);col=mix(col,fill,(1. - smoothstep(0.12 - ta,0.12 + ta,td))*al);}
void stick(inout vec3 col,float d,float aa,float al){col=mix(col,vec3(0.),(1. - smoothstep(0.,0.03,d - 0.010))*0.40*al);
col=mix(col,vec3(0.08,0.06,0.14),(1. - smoothstep(-aa,aa,d - 0.016))*al);col=mix(col,vec3(1.),(1. - smoothstep(-aa,aa,d - 0.008))*al);}float glyphD(vec2 p,float c){
float d=9.;if(c>3.5&&c<4.5){d=min(sdSeg(p,vec2(-0.3,0.5),vec2(-0.3,-0.5)),min(sdSeg(p,vec2(-0.3,0.5),vec2(0.,0.5)),sdSeg(p,vec2(-0.3,-0.5),vec2(0.,-0.5))));if(p.x>=0.){
d=min(d,abs(sdRound(p,vec2(0.3,0.5),0.3)));}}else if(c>4.5&&c<5.5){
d=min(sdSeg(p,vec2(0.,0.5),vec2(0.,-0.5)),min(sdSeg(p,vec2(-0.17,0.5),vec2(0.17,0.5)),sdSeg(p,vec2(-0.17,-0.5),vec2(0.17,-0.5))));}else if(c>5.5&&c<6.5){
d=min(min(sdSeg(p,vec2(-0.3,-0.5),vec2(-0.3,0.5)),sdSeg(p,vec2(-0.3,0.5),vec2(0.3,-0.5))),sdSeg(p,vec2(0.3,-0.5),vec2(0.3,0.5)));}else if(c>6.5&&c<7.5){
d=abs(sdRound(p,vec2(0.3,0.5),0.3));if(p.x>0.12&&p.y>-0.02&&p.y<0.36){d=length(p - vec2(0.254,0.36));}d=min(d,sdSeg(p,vec2(0.06,-0.02),vec2(0.3,-0.02)));}
else if(c>7.5&&c<8.5){
d=min(min(sdSeg(p,vec2(-0.3,0.5),vec2(-0.3,-0.5)),sdSeg(p,vec2(-0.3,0.5),vec2(0.3,0.5))),min(sdSeg(p,vec2(-0.3,0.),vec2(0.18,0.)),sdSeg(p,vec2(-0.3,-0.5),vec2(0.3,-0.5))));
}else if(c>9.5&&c<10.5){d=min(sdSeg(p,vec2(-0.3,0.5),vec2(0.3,0.5)),sdSeg(p,vec2(0.,0.5),vec2(0.,-0.5)));}else if(c>10.5&&c<11.5){
d=min(sdSeg(p,vec2(0.28,0.5),vec2(-0.28,-0.5)),min(abs(length(p - vec2(-0.19,0.33))- 0.11),abs(length(p - vec2(0.19,-0.33))- 0.11)));}else if(c>11.5&&c<12.5){
d=abs(sdRound(p,vec2(0.27,0.5),0.27));}else if(c>12.5&&c<13.5){d=min(sdSeg(p,vec2(0.04,0.5),vec2(0.04,-0.5)),sdSeg(p,vec2(0.04,0.5),vec2(-0.2,0.27)));}
else if(c>13.5&&c<14.5){d=min(sdArc(p - vec2(0.,0.21),0.29,-0.8727,2.7925),min(sdSeg(p,vec2(0.1864,-0.0122),vec2(-0.3,-0.5)),sdSeg(p,vec2(-0.3,-0.5),vec2(0.3,-0.5))));}
else if(c>14.5&&c<15.5){d=min(sdArc(p - vec2(0.,0.24),0.26,-1.5708,2.618),sdArc(p - vec2(0.,-0.23),0.27,-2.618,1.5708));}else if(c>15.5&&c<16.5){
d=min(min(sdSeg(p,vec2(0.15,0.5),vec2(0.15,-0.5)),sdSeg(p,vec2(0.15,0.5),vec2(-0.3,-0.15))),sdSeg(p,vec2(-0.3,-0.15),vec2(0.3,-0.15)));}else if(c>16.5&&c<17.5){
d=min(min(sdSeg(p,vec2(0.25,0.5),vec2(-0.2,0.5)),sdSeg(p,vec2(-0.2,0.5),vec2(-0.22,0.05))),sdArc(p - vec2(-0.02,-0.2),0.3,-2.5,2.2));}else if(c>17.5&&c<18.5){
d=min(abs(length(p - vec2(0.,-0.2))- 0.3),sdSeg(p,vec2(0.14,0.5),vec2(-0.27,-0.07)));}else if(c>18.5&&c<19.5){
d=min(sdSeg(p,vec2(-0.3,0.5),vec2(0.3,0.5)),sdSeg(p,vec2(0.3,0.5),vec2(-0.06,-0.5)));}else if(c>19.5&&c<20.5){
d=min(abs(length(p - vec2(0.,0.26))- 0.24),abs(length(p - vec2(0.,-0.22))- 0.28));}else if(c>20.5&&c<21.5){
d=min(abs(length(p - vec2(0.,0.2))- 0.3),sdSeg(p,vec2(0.27,0.07),vec2(-0.14,-0.5)));}else if(c>22.5&&c<23.5){
d=min(sdSeg(p,vec2(-0.3,0.5),vec2(-0.3,-0.5)),min(sdSeg(p,vec2(-0.3,0.5),vec2(0.05,0.5)),sdSeg(p,vec2(-0.3,0.),vec2(0.05,0.))));if(p.x>=0.05){
d=min(d,abs(length(p - vec2(0.05,0.25))- 0.25));}}else if(c>26.5&&c<27.5){
d=min(min(sdSeg(p,vec2(-0.3,0.5),vec2(0.,0.)),sdSeg(p,vec2(0.3,0.5),vec2(0.,0.))),sdSeg(p,vec2(0.,0.),vec2(0.,-0.5)));}else if(c>27.5&&c<28.5){
d=abs(sdRound(p,vec2(0.3,0.5),0.3));if(p.x>0.1&&abs(p.y)<0.36){d=min(length(p - vec2(0.254,0.36)),length(p - vec2(0.254,-0.36)));}}else if(c>28.5&&c<29.5){
d=min(sdSeg(p,vec2(-0.3,0.5),vec2(-0.3,-0.5)),min(sdSeg(p,vec2(-0.3,0.5),vec2(0.05,0.5)),sdSeg(p,vec2(-0.3,0.),vec2(0.05,0.))));if(p.x>=0.05){
d=min(d,abs(length(p - vec2(0.05,0.25))- 0.25));}d=min(d,sdSeg(p,vec2(0.02,0.),vec2(0.3,-0.5)));}return d;}float pctD(vec2 q,float v){float i=floor(q.x/0.9 + 0.5);
float c=0.;if(i>-0.5&&i<0.5){if(v>99.5){c=13.;}}else if(i>0.5&&i<1.5){if(v>9.5){c=12. + mod(floor(v/10.),10.);}}else if(i>1.5&&i<2.5){c=12. + mod(v,10.);}
else if(i>2.5&&i<3.5){c=11.;}return glyphD(vec2(q.x - i*0.9,q.y),c);}float decDC(float i){float c=0.;if(i>-0.5&&i<9.5){if(i<4.5){if(i<1.5){if(i<0.5){c=4.;}else{c=8.;}}
else{if(i<2.5){c=28.;}else{if(i<3.5){c=29.;}else{c=27.;}}}}else{if(i<6.5){if(i<5.5){c=23.;}else{c=10.;}}else{if(i<7.5){c=5.;}else{if(i<8.5){c=6.;}else{c=7.;}}}}}return c;
}float decD(vec2 q){float i=floor(q.x/0.9 + 0.5);float j=i +((q.x/0.9 - i<0.)?-1.:1.);
return min(glyphD(vec2(q.x - i*0.9,q.y),decDC(i)),glyphD(vec2(q.x - j*0.9,q.y),decDC(j)));}vec4 effect(vec4 texel,float progress){float sec=clamp(progress,0.,1.)*2.;
float asp=clamp(ratio,0.3,3.);vec2 p=vec2((vUv.x - 0.5)*asp,vUv.y - 0.5);float s=clamp(uiScale,0.6,1.4)*min(1.,asp/0.62);vec2 u=p/s;float vis=step(BLANK,sec);
float tl=clamp((sec - T0)/(T1 - T0),0.,1.);float L=clamp(tl + 0.035*sin(tl*18.849556),0.,1.);float pct=floor(L*100. + 0.5);float fr=floor(sec*15. + 0.001);
vec2 cells=vec2(floor(12.*asp + 0.5),12.);vec2 cid=floor(vUv*cells);vec2 cf=fract(vUv*cells);float th=T0 + hash2(cid*1.31 + 4.)*(T1 - T0 - 0.12);float done=step(th,sec);
float fl=exp(-max(sec - th,0.)/0.06)*done;vec2 sub=floor(cf*5.);float bit=step(0.5,hash2(cid*7. + sub + fr*1.7));
vec3 cip=mix(vec3(0.,0.08,0.06),mix(vec3(0.30,1.,0.55),vec3(0.10,0.95,1.),hash2(cid + 3.)),bit*0.55);cip*=step(0.08,cf.x)*step(0.08,cf.y);
vec3 pic=texture2D(tDiffuse,vUv).rgb;vec3 col=(done>0.5)?mix(pic,pic*vec3(0.85,1.05,1.1),0.4*(1. - ease((sec - T1)/0.3))):cip;col=mix(col,vec3(0.8,1.,0.95),fl*0.8);
float uiA=step(BLANK,sec)*(1. - smoothstep(T1 + 0.05,T1 + 0.18,sec));vec2 pq=u - vec2(0.,0.);float dP=sdRound(pq,vec2(0.25,0.085),0.006);
col=mix(col,vec3(0.,0.03,0.04),(1. - smoothstep(-0.002,0.002,dP))*0.88*uiA);col=mix(col,vec3(0.10,0.95,1.),(1. - smoothstep(0.,0.004,abs(dP)- 0.002))*uiA);
vec2 bq=pq - vec2(0.,-0.045);float dB=sdRound(bq,vec2(0.21,0.010),0.002);
col=mix(col,(bq.x + 0.21<L*0.42)?mix(vec3(0.30,1.,0.55),vec3(0.10,0.95,1.),(bq.x + 0.21)/0.42):vec3(0.05,0.15,0.18),(1. - smoothstep(-0.002,0.002,dB))*uiA);if((uiA)>0.){
float bsc=max(1.,0.001);vec2 bq=rot2(u - vec2(-0.045,0.025),0.)/bsc;if(abs(bq.y)<0.034*1.4&&abs(bq.x)<0.034*5.0500){vec2 tq=(bq - vec2(-4.0500*0.034,0.))/0.034;
bigMix(col,decD(tq),decD((tq + vec2(-0.10,0.12))),0.0016/(0.034*s*bsc),0.2,uiA,vec3(0.30,1.,0.55),vec3(0.,0.10,0.06));}}if((uiA)>0.){float bsc=max(1.,0.001);
vec2 bq=rot2(u - vec2(0.180,0.025),0.)/bsc;if(abs(bq.y)<0.034*1.4&&abs(bq.x)<0.034*2.3500){vec2 tq=(bq - vec2(-1.3500*0.034,0.))/0.034;
bigMix(col,pctD(tq,pct),pctD((tq + vec2(-0.10,0.12)),pct),0.0016/(0.034*s*bsc),0.2,uiA,vec3(1.),vec3(0.,0.10,0.06));}}if(sec>=1.45){col=texel.rgb;}
return vec4(clamp(col,0.,1.)*vis,texel.a*vis);}void main(){vec4 texel=texture2D(tDiffuse,vUv);gl_FragColor=effect(texel,progress);}
//===end_frag_code===
`;