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
const float BLANK=0.15;const float T0=0.15;const float T1=1.2;float hash1(float n){return fract(sin(n*12.9898 + 4.1414)*43758.5453);}float hash2(vec2 p){
return fract(sin(dot(p,vec2(12.9898,78.233)))*43758.5453);}float ease(float x){float t=clamp(x,0.,1.);return t*t*(3. - 2.*t);}vec2 rot2(vec2 v,float a){float cs=cos(a);
float sn=sin(a);return vec2(cs*v.x - sn*v.y,sn*v.x + cs*v.y);}float sdSeg(vec2 p,vec2 a,vec2 b){vec2 pa=p - a;vec2 ba=b - a;float h=clamp(dot(pa,ba)/dot(ba,ba),0.,1.);
return length(pa - ba*h);}float sdRound(vec2 p,vec2 h,float r){vec2 d=abs(p)- h + vec2(r);return length(max(d,0.))+ min(max(d.x,d.y),0.)- r;}
float sdArc(vec2 c,float r,float a0,float a1){float a=atan(c.y,c.x);float d=abs(length(c)- r);if(a<a0||a>a1){
d=min(length(c - r*vec2(cos(a0),sin(a0))),length(c - r*vec2(cos(a1),sin(a1))));}return d;}
void bigMix(inout vec3 col,float td,float tds,float ta,float ow,float al,vec3 fill,vec3 outl){col=mix(col,vec3(0.),(1. - smoothstep(ow - 0.02,ow + 0.08,tds))*0.40*al);
col=mix(col,outl,(1. - smoothstep(ow - ta,ow + ta,td))*al);col=mix(col,fill,(1. - smoothstep(0.12 - ta,0.12 + ta,td))*al);}
void stick(inout vec3 col,float d,float aa,float al){col=mix(col,vec3(0.),(1. - smoothstep(0.,0.03,d - 0.010))*0.40*al);
col=mix(col,vec3(0.08,0.06,0.14),(1. - smoothstep(-aa,aa,d - 0.016))*al);col=mix(col,vec3(1.),(1. - smoothstep(-aa,aa,d - 0.008))*al);}vec3 darkGrade(vec3 c,float k){
vec3 l=vec3(dot(c,vec3(0.299,0.587,0.114)));c=mix(c,l*vec3(0.78,0.84,1.),0.65*k);c=pow(max(c,vec3(0.)),vec3(1. + 0.7*k));return c*(1. - 0.25*k);}
vec3 tex0(sampler2D s,vec2 uv){float inside=step(0.,uv.x)*step(uv.x,1.)*step(0.,uv.y)*step(uv.y,1.);return texture2D(s,clamp(uv,0.,1.)).rgb*inside;}
vec3 hmo(sampler2D s,vec2 uv,float k,float t){vec2 c=uv - 0.5;vec3 col=tex0(s,0.5 + c);for(int i=1;i<5;i++){vec3 g=tex0(s,0.5 + c - vec2(0.022,0.016)*float(i)*k);
col=max(col,g*(0.75 - 0.15*float(i))*k + col*(1. - k));}vec3 dk=darkGrade(col,1.)*mix(vec3(1.),vec3(0.88,0.86,1.15),0.00);return mix(col,dk,clamp(0.00*k,0.,1.));}
float glyphD(vec2 p,float c){float d=9.;if(c>0.5&&c<1.5){d=min(sdSeg(p,vec2(-0.3,0.5),vec2(-0.3,-0.5)),sdSeg(p,vec2(-0.3,-0.5),vec2(0.3,-0.5)));}else if(c>1.5&&c<2.5){
d=abs(sdRound(p,vec2(0.3,0.5),0.3));}else if(c>2.5&&c<3.5){
d=min(min(sdSeg(p,vec2(-0.3,-0.5),vec2(0.,0.5)),sdSeg(p,vec2(0.,0.5),vec2(0.3,-0.5))),sdSeg(p,vec2(-0.2,-0.15),vec2(0.2,-0.15)));}else if(c>3.5&&c<4.5){
d=min(sdSeg(p,vec2(-0.3,0.5),vec2(-0.3,-0.5)),min(sdSeg(p,vec2(-0.3,0.5),vec2(0.,0.5)),sdSeg(p,vec2(-0.3,-0.5),vec2(0.,-0.5))));if(p.x>=0.){
d=min(d,abs(sdRound(p,vec2(0.3,0.5),0.3)));}}else if(c>4.5&&c<5.5){
d=min(sdSeg(p,vec2(0.,0.5),vec2(0.,-0.5)),min(sdSeg(p,vec2(-0.17,0.5),vec2(0.17,0.5)),sdSeg(p,vec2(-0.17,-0.5),vec2(0.17,-0.5))));}else if(c>5.5&&c<6.5){
d=min(min(sdSeg(p,vec2(-0.3,-0.5),vec2(-0.3,0.5)),sdSeg(p,vec2(-0.3,0.5),vec2(0.3,-0.5))),sdSeg(p,vec2(0.3,-0.5),vec2(0.3,0.5)));}else if(c>6.5&&c<7.5){
d=abs(sdRound(p,vec2(0.3,0.5),0.3));if(p.x>0.12&&p.y>-0.02&&p.y<0.36){d=length(p - vec2(0.254,0.36));}d=min(d,sdSeg(p,vec2(0.06,-0.02),vec2(0.3,-0.02)));}
else if(c>10.5&&c<11.5){d=min(sdSeg(p,vec2(0.28,0.5),vec2(-0.28,-0.5)),min(abs(length(p - vec2(-0.19,0.33))- 0.11),abs(length(p - vec2(0.19,-0.33))- 0.11)));}
else if(c>11.5&&c<12.5){d=abs(sdRound(p,vec2(0.27,0.5),0.27));}else if(c>12.5&&c<13.5){
d=min(sdSeg(p,vec2(0.04,0.5),vec2(0.04,-0.5)),sdSeg(p,vec2(0.04,0.5),vec2(-0.2,0.27)));}else if(c>13.5&&c<14.5){
d=min(sdArc(p - vec2(0.,0.21),0.29,-0.8727,2.7925),min(sdSeg(p,vec2(0.1864,-0.0122),vec2(-0.3,-0.5)),sdSeg(p,vec2(-0.3,-0.5),vec2(0.3,-0.5))));}else if(c>14.5&&c<15.5){
d=min(sdArc(p - vec2(0.,0.24),0.26,-1.5708,2.618),sdArc(p - vec2(0.,-0.23),0.27,-2.618,1.5708));}else if(c>15.5&&c<16.5){
d=min(min(sdSeg(p,vec2(0.15,0.5),vec2(0.15,-0.5)),sdSeg(p,vec2(0.15,0.5),vec2(-0.3,-0.15))),sdSeg(p,vec2(-0.3,-0.15),vec2(0.3,-0.15)));}else if(c>16.5&&c<17.5){
d=min(min(sdSeg(p,vec2(0.25,0.5),vec2(-0.2,0.5)),sdSeg(p,vec2(-0.2,0.5),vec2(-0.22,0.05))),sdArc(p - vec2(-0.02,-0.2),0.3,-2.5,2.2));}else if(c>17.5&&c<18.5){
d=min(abs(length(p - vec2(0.,-0.2))- 0.3),sdSeg(p,vec2(0.14,0.5),vec2(-0.27,-0.07)));}else if(c>18.5&&c<19.5){
d=min(sdSeg(p,vec2(-0.3,0.5),vec2(0.3,0.5)),sdSeg(p,vec2(0.3,0.5),vec2(-0.06,-0.5)));}else if(c>19.5&&c<20.5){
d=min(abs(length(p - vec2(0.,0.26))- 0.24),abs(length(p - vec2(0.,-0.22))- 0.28));}else if(c>20.5&&c<21.5){
d=min(abs(length(p - vec2(0.,0.2))- 0.3),sdSeg(p,vec2(0.27,0.07),vec2(-0.14,-0.5)));}return d;}float pctD(vec2 q,float v){float i=floor(q.x/0.9 + 0.5);float c=0.;
if(i>-0.5&&i<0.5){if(v>99.5){c=13.;}}else if(i>0.5&&i<1.5){if(v>9.5){c=12. + mod(floor(v/10.),10.);}}else if(i>1.5&&i<2.5){c=12. + mod(v,10.);}else if(i>2.5&&i<3.5){
c=11.;}return glyphD(vec2(q.x - i*0.9,q.y),c);}float loadDC(float i){float c=0.;if(i>-0.5&&i<6.5){if(i<2.5){if(i<0.5){c=1.;}else{if(i<1.5){c=2.;}else{c=3.;}}}else{
if(i<4.5){if(i<3.5){c=4.;}else{c=5.;}}else{if(i<5.5){c=6.;}else{c=7.;}}}}return c;}float loadD(vec2 q){float i=floor(q.x/0.9 + 0.5);float j=i +((q.x/0.9 - i<0.)?-1.:1.);
return min(glyphD(vec2(q.x - i*0.9,q.y),loadDC(i)),glyphD(vec2(q.x - j*0.9,q.y),loadDC(j)));}vec4 effect(vec4 texel,float progress){float sec=clamp(progress,0.,1.)*2.;
float asp=clamp(ratio,0.3,3.);vec2 p=vec2((vUv.x - 0.5)*asp,vUv.y - 0.5);float s=clamp(uiScale,0.6,1.4)*min(1.,asp/0.62);vec2 u=p/s;float vis=step(BLANK,sec);
float tl=clamp((sec - T0)/(T1 - T0),0.,1.);float L=clamp(tl + 0.035*sin(tl*18.849556),0.,1.);float pct=floor(L*100. + 0.5);float fr=floor(sec*15. + 0.001);
float kfm=1. - ease(clamp((sec - BLANK)/1.25,0.,1.));vec3 pic=hmo(tDiffuse,vUv,kfm,sec*2.);float uiA=step(BLANK,sec)*(1. - smoothstep(T1 + 0.12,T1 + 0.22,sec));
float e=ease(clamp((sec - BLANK)/1.,0.,1.));vec3 col=vec3(0.02,0.02,0.05);for(int i=0;i<4;i++){float fi=float(i);float side=(mod(fi,2.)<0.5)?-1.:1.;
float off=side*(1. - e)*(0.25 + 0.15*fi);vec3 c=hmo(tDiffuse,vec2(vUv.x - off,vUv.y),kfm,sec*2.);vec3 tint=(side<0.)?vec3(0.35,0.80,1.):vec3(1.,0.40,0.80);
float on=step(0.5,hash1(floor(sec*20.)+ fi*7.))*(1. - e)*0.55;col=max(col,dot(c,vec3(0.333))*tint*on);}col=mix(col,pic,smoothstep(0.35,1.,e));
float zip=step(0.8,hash1(floor(vUv.y*60.)+ floor(sec*20.)))*(1. - smoothstep(0.1,0.4,abs(fract(vUv.y*60.)- 0.5)))*(1. - e);col=mix(col,vec3(1.),zip*0.6*step(BLANK,sec));
col*=smoothstep(BLANK,BLANK + 0.05,sec);{vec2 pq=u - vec2(0.,-0.40);float dP=sdRound(pq,vec2(0.24,0.060),0.008);
col=mix(col,vec3(0.,0.02,0.05),(1. - smoothstep(-0.002,0.002,dP))*0.85*(uiA));col=mix(col,vec3(0.10,0.95,1.),(1. - smoothstep(0.,0.004,abs(dP)- 0.0018))*(uiA));}{
vec2 bq=u - vec2(0.,(-0.40)- 0.025);float dB=sdRound(bq,vec2(0.20,0.009),0.002);float fx=(bq.x + 0.20)/(2.*0.20);
col=mix(col,(fx<L)?mix(vec3(0.10,0.95,1.),vec3(1.,0.15,0.65),fx):vec3(0.06,0.10,0.16),(1. - smoothstep(-0.002,0.002,dB))*(uiA));}if((uiA)>0.){float bsc=max(1.,0.001);
vec2 bq=rot2(u - vec2(-0.050,(-0.40)+ 0.018),0.)/bsc;if(abs(bq.y)<0.030*1.4&&abs(bq.x)<0.030*3.7000){vec2 tq=(bq - vec2(-2.7000*0.030,0.))/0.030;
bigMix(col,loadD(tq),loadD((tq + vec2(-0.10,0.12))),0.0016/(0.030*s*bsc),0.2,uiA,vec3(1.),vec3(0.,0.05,0.10));}}if((uiA)>0.){float bsc=max(1.,0.001);
vec2 bq=rot2(u - vec2(0.170,(-0.40)+ 0.018),0.)/bsc;if(abs(bq.y)<0.030*1.4&&abs(bq.x)<0.030*2.3500){vec2 tq=(bq - vec2(-1.3500*0.030,0.))/0.030;
bigMix(col,pctD(tq,pct),pctD((tq + vec2(-0.10,0.12)),pct),0.0016/(0.030*s*bsc),0.2,uiA,vec3(1.,0.15,0.65),vec3(0.,0.05,0.10));}}if(sec>=1.45){col=texel.rgb;}
return vec4(clamp(col,0.,1.)*vis,texel.a*vis);}void main(){vec4 texel=texture2D(tDiffuse,vUv);gl_FragColor=effect(texel,progress);}
//===end_frag_code===
`;