exports.source=`
//===begin_frag_code===
precision highp float;
uniform sampler2D tDiffuse; // Image A
uniform float progress; // = 0.0 [0.0, 1.0] // Transition progress
uniform float ratio; // = 1.0 [0.1, 3.0] // Output width / height
uniform float uiScale; // = 1.0 [0.65, 1.3] // Loading UI size
uniform float bgDim; // = 0.42 [0.0, 1.0] // Background dimming
uniform float hudOpacity; // = 1.0 [0.0, 1.0] // Loading UI opacity
varying vec2 vUv;
float ease(float t){t=clamp(t,0.0,1.0);return t*t*(3.0-2.0*t);}
float sdSeg(vec2 p,vec2 a,vec2 b){vec2 pa=p-a;vec2 ba=b-a;return length(pa-ba*clamp(dot(pa,ba)/dot(ba,ba),0.0,1.0));}
float sdRound(vec2 p,vec2 h,float r){vec2 d=abs(p)-h+vec2(r);return length(max(d,vec2(0.0)))+min(max(d.x,d.y),0.0)-r;}
float boxMask(vec2 p,vec2 h,float aa){vec2 d=abs(p)-h;return 1.0-smoothstep(-aa,aa,max(d.x,d.y));}
void ink(inout vec3 col,vec3 color,float m){col=mix(col,color,clamp(m,0.0,1.0));}
const vec3 C0=vec3(1.0,.52,.73);
const vec3 C1=vec3(.56,.87,1.0);
const vec3 BASE=vec3(.065,.034,.08);
const vec3 INK=vec3(1.0,.94,.98);
const float START_LEN=7.0;
const float END_LEN=5.0;
float glyphD(vec2 p,float c){float d=9.0;
if(c>1.5&&c<2.5){d=abs(sdRound(p,vec2(0.3,0.5),0.3));}
else if(c>2.5&&c<3.5){d=min(min(sdSeg(p,vec2(-0.3,-0.5),vec2(0.0,0.5)),sdSeg(p,vec2(0.0,0.5),vec2(0.3,-0.5))),sdSeg(p,vec2(-0.2,-0.15),vec2(0.2,-0.15)));}
else if(c>3.5&&c<4.5){d=min(sdSeg(p,vec2(-0.3,0.5),vec2(-0.3,-0.5)),min(sdSeg(p,vec2(-0.3,0.5),vec2(0.0,0.5)),sdSeg(p,vec2(-0.3,-0.5),vec2(0.0,-0.5))));if(p.x>=0.0){d=min(d,abs(sdRound(p,vec2(0.3,0.5),0.3)));}}
else if(c>4.5&&c<5.5){d=min(sdSeg(p,vec2(0.0,0.5),vec2(0.0,-0.5)),min(sdSeg(p,vec2(-0.17,0.5),vec2(0.17,0.5)),sdSeg(p,vec2(-0.17,-0.5),vec2(0.17,-0.5))));}
else if(c>5.5&&c<6.5){d=min(min(sdSeg(p,vec2(-0.3,-0.5),vec2(-0.3,0.5)),sdSeg(p,vec2(-0.3,0.5),vec2(0.3,-0.5))),sdSeg(p,vec2(0.3,-0.5),vec2(0.3,0.5)));}
else if(c>6.5&&c<7.5){d=abs(sdRound(p,vec2(0.3,0.5),0.3));if(p.x>0.12 && p.y>-0.02 && p.y<0.36){d=length(p - vec2(0.254,0.36));}d=min(d,sdSeg(p,vec2(0.06,-0.02),vec2(0.3,-0.02)));}
else if(c>7.5&&c<8.5){d=min(min(sdSeg(p,vec2(-0.3,0.5),vec2(-0.3,-0.5)),sdSeg(p,vec2(-0.3,0.5),vec2(0.3,0.5))),min(sdSeg(p,vec2(-0.3,0.0),vec2(0.18,0.0)),sdSeg(p,vec2(-0.3,-0.5),vec2(0.3,-0.5))));}
else if(c>9.5&&c<10.5){d=min(sdSeg(p,vec2(-0.3,0.5),vec2(0.3,0.5)),sdSeg(p,vec2(0.0,0.5),vec2(0.0,-0.5)));}
else if(c>26.5&&c<27.5){d=min(min(sdSeg(p,vec2(-0.3,0.5),vec2(0.0,0.0)),sdSeg(p,vec2(0.3,0.5),vec2(0.0,0.0))),sdSeg(p,vec2(0.0,0.0),vec2(0.0,-0.5)));}
else if(c>28.5&&c<29.5){d=min(sdSeg(p,vec2(-0.3,0.5),vec2(-0.3,-0.5)),min(sdSeg(p,vec2(-0.3,0.5),vec2(0.05,0.5)),sdSeg(p,vec2(-0.3,0.0),vec2(0.05,0.0))));if(p.x>=0.05){d=min(d,abs(length(p - vec2(0.05,0.25))- 0.25));}
d=min(d,sdSeg(p,vec2(.02,0.0),vec2(.3,-.5)));}
else if(c>31.5&&c<32.5){d=min(min(sdSeg(p,vec2(-0.3,0.5),vec2(-0.3,-0.5)),sdSeg(p,vec2(-0.3,0.5),vec2(0.03,0.5))),min(sdSeg(p,vec2(-0.3,0.0),vec2(0.05,0.0)),sdSeg(p,vec2(-0.3,-0.5),vec2(0.05,-0.5))));
if(p.x>=0.03 && p.y>0.0){d=min(d,abs(length(p - vec2(0.03,0.25))- 0.25));}
if(p.x>=0.05 && p.y<=0.0){d=min(d,abs(length(p - vec2(0.05,-0.25))- 0.25));}}
return d;}
float startCode(float i){if(i<-.5||i>6.5)return 0.0;if(i<0.5)return 32.0;if(i<1.5)return 2.0;if(i<2.5)return 2.0;if(i<3.5)return 10.0;if(i<4.5)return 5.0;if(i<5.5)return 6.0;if(i<6.5)return 7.0;return 0.0;}
float endCode(float i){if(i<-.5||i>4.5)return 0.0;if(i<0.5)return 29.0;if(i<1.5)return 8.0;if(i<2.5)return 3.0;if(i<3.5)return 4.0;if(i<4.5)return 27.0;return 0.0;}
void panel(inout vec3 col,vec2 q,vec2 h,float aa){
ink(col,vec3(.02,.025,.04),boxMask(q-vec2(.006,-.008),h+vec2(.004),aa)*.45);
ink(col,C0,boxMask(q,h,aa));
ink(col,BASE,boxMask(q,h-vec2(.0035),aa));
}
void bar(inout vec3 col,vec2 q,vec2 h,float f,float aa){
float m=boxMask(q,h,aa);
ink(col,mix(BASE,INK,.22),m);
float cut=-h.x+2.0*h.x*clamp(f,0.0,1.0);
float fill=1.0-smoothstep(cut-aa,cut+aa,q.x);
if(f<=0.0)fill=0.0;if(f>=1.0)fill=1.0;
ink(col,mix(C0,C1,clamp((q.x+h.x)/(2.0*h.x),0.0,1.0)),m*fill);
}
void title(inout vec3 col,vec2 q,float done,float aa){
float cap=mix(.034,.043,done);
float n=mix(START_LEN,END_LEN,done);
vec2 tq=q/cap+vec2((n-1.0)*.45,0.0);
float idx=floor(tq.x/.9+.5);
float code=done>.5?endCode(idx):startCode(idx);
float d=glyphD(vec2(tq.x-idx*.9,tq.y),code);
float ta=aa/cap;
float m=(1.0-smoothstep(.105-ta,.105+ta,d))*step(abs(q.y),.025)*step(abs(q.x),.245);
ink(col,INK,m);
}
vec4 effect(vec4 texel,float progress){
float sec=clamp(progress,0.0,1.0)*2.0;
float intro=smoothstep(.15,.32,sec);float load=clamp((sec-.28)/1.02,0.0,1.0);float done=step(1.30,sec);float wait=intro*(1.0-smoothstep(1.32,1.74,sec));float uiA=intro*(1.0-smoothstep(1.46,1.80,sec))*clamp(hudOpacity,0.0,1.0);
float asp=clamp(ratio,.3,3.0);
float sc=min(clamp(uiScale,.65,1.3),min(asp/.60,1.1));
vec2 p=vec2((vUv.x-.5)*asp,vUv.y-.5)/sc;
float aa=.00115/sc;
vec3 aCol=texel.rgb;
float density=mix(6.0,110.0,pow(load,.65));vec2 cells=vec2(density*asp,density);
vec2 uv=clamp((floor(vUv*cells)+.5)/cells,vec2(0.0),vec2(1.0));vec3 coarse=texture2D(tDiffuse,uv).rgb;
aCol=mix(coarse,aCol,smoothstep(.60,1.0,load));aCol=mix(aCol,aCol*vec3(1.08,.80,1.04),.4*wait);
aCol*=1.0-.50*clamp(bgDim,0.0,1.0)*wait;aCol=clamp(aCol,0.0,1.0);float mask=0.0;float edgeGlow=0.0;
mask=ease(clamp(load/.18,0.0,1.0));
if(load<=0.0){mask=0.0;edgeGlow=0.0;}if(load>=1.0){mask=1.0;edgeGlow=0.0;}mask=clamp(mask,0.0,1.0);vec4 base=vec4(aCol*mask,mix(1.0,texel.a,mask));
vec3 col=base.rgb;ink(col,C0,edgeGlow*.48);
if(uiA>.0001){vec3 uc=col;
vec2 q=p-vec2(0.0,-.07*(1.0-intro));panel(uc,q,vec2(.252,.177),aa);title(uc,q-vec2(0.0,.132),done,aa);
for(int k=0;k<4;k++){
float fi=float(k);float xx=-.174+fi*.116;float f=clamp(load*4.0-fi,0.0,1.0);
vec2 bq=q-vec2(xx,-.018);
ink(uc,C0,boxMask(bq,vec2(.040,.079),aa)*.65);
ink(uc,BASE,boxMask(bq,vec2(.035,.074),aa));
float fill=1.0-smoothstep(-.061+.122*f-aa,-.061+.122*f+aa,bq.y);
if(f<=0.0)fill=0.0;if(f>=1.0)fill=1.0;
ink(uc,mix(C0,C1,fi/3.0),boxMask(bq,vec2(.026,.061),aa)*fill);
for(int j=0;j<4;j++)ink(uc,BASE,boxMask(bq-vec2(0.0,-.036+float(j)*.024),vec2(.027,.001),aa)*.6);
}
bar(uc,q-vec2(0.0,-.135),vec2(.215,.007),load,aa);
col=mix(col,clamp(uc,0.0,1.0),uiA);}
float alpha=base.a;
alpha=max(alpha,uiA*boxMask(p,vec2(.27,.24),aa));
vec4 result=vec4(clamp(col,0.0,1.0),alpha);
if(sec<.15)result=vec4(0.0);if(sec>=1.92)result=texel;
return result;}
void main(){vec4 a=texture2D(tDiffuse,vUv);gl_FragColor=effect(a,progress);}
//===end_frag_code===
`;