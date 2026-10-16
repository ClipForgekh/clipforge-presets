#version 300 es
precision highp float;

in highp vec3 attPosition;
in vec3 attBinormal;
in vec3 attNormal;
in vec4 attTangent;
in vec2 uv0;
in vec2 uv_ao;
in vec2 uv1;
in highp vec2 uv2;
in vec2 uv3;
in vec2 uv4;
in vec2 uv5;
in vec2 uv6;
in vec2 uv7;

uniform float iTime;

uniform mat4 u_MVP;
uniform mat4 u_Model;
uniform mat4 u_View;
uniform mat4 u_MV;
uniform mat4 u_LightSpaceMatrix;

uniform sampler2D pos_vat;
uniform sampler2D rot_vat;

uniform float frame_count;
uniform float houdini_fps;
uniform float display_frame;
uniform vec3 bound_max;
uniform vec3 bound_min;

uniform float interframe_interpolation;
uniform float animate_first_frame;
uniform float scale_val;

out vec2 o_uv;
out vec2 o_uv_ao;
out vec4 o_col;
out vec2 vScreenPos;

out vec2 uv_0;
out vec2 uv_1;
out vec2 uv_2;
out vec2 uv_3;
out vec2 uv_4;
out vec2 uv_5;
out vec2 uv_6;
out vec2 uv_7;

out vec3 vNormal;
out vec3 vTangent;
out vec3 vBiNormal;
out vec3 vPosition;
out vec3 v_refraction;
out vec3 v_reflection;
out vec3 v_euler;
out float v_zdis;
out float f_fresnel;
out vec4 FragPosLightSpace;


// Indices of refraction
const float Air = 1.0;
const float Glass = 1.51714;

#define PI 3.1415926
// Air to glass ratio of the indices of refraction (Eta)
const float Eta = Air / Glass;
// see http://en.wikipedia.org/wiki/Refractive_index Reflectivity
const float R0 = ((Air - Glass) * (Air - Glass)) / ((Air + Glass) * (Air + Glass));

vec2 getThisFrameUv(vec2 _apr, out float cur_frame)
{
    float b = floor(display_frame);
    float c = b;
    c = mod(c-1.,frame_count)*(1./frame_count)*_apr.y;

    cur_frame = mod(c,frame_count);

    return vec2(
        uv1.x*_apr.x,
        (1.-uv1.y)*_apr.y+c
    );
}

vec2 getNextFrameUv(vec2 _apr, out float next_frame)
{
    float b = floor(display_frame+1.);
    float c = b;
    c = mod(c-1.,frame_count)*(1./frame_count)*_apr.y;

    next_frame = mod(c,frame_count);

    return vec2(
        uv1.x*_apr.x,
        (1.-uv1.y)*_apr.y+c
    );
}

vec3 getPiecePivot()
{
    return attPosition.xyz-vec3(uv2.x*1., uv3.x, 1.-uv3.y);
}

void DecodeQuaternion(vec3 XYZ, float maxComponent, out vec4 out_xyzw)
{
    float w = sqrt(1.-pow(XYZ.x, 2.)-pow(XYZ.y, 2.)-pow(XYZ.z, 2.));
    vec4 q = vec4(0,0,0,1);
    if(maxComponent < 0.5){
        q = vec4(XYZ.xyz,w);
    }else if(maxComponent < 1.5){
        q = vec4(w, XYZ.yzx);
    }else if(maxComponent < 2.5){
        q = vec4(XYZ.x, -w, XYZ.z, -XYZ.y);
    }else if(maxComponent < 3.5){
        q = vec4(XYZ.xy, -w, -XYZ.z);
    }else{
        q = vec4(XYZ.xyz, w);
    }
    out_xyzw = q;
}

const float TAU = 2.*3.1415926;

vec4 mulQuat(vec4 q1, vec4 q2) {
    return vec4(
        q1.w * q2.x + q1.x * q2.w + q1.z * q2.y - q1.y * q2.z,
        q1.w * q2.y + q1.y * q2.w + q1.x * q2.z - q1.z * q2.x,
        q1.w * q2.z + q1.z * q2.w + q1.y * q2.x - q1.x * q2.y,
        q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z
    );
}

vec3 RotateVectorByQuaternion(vec3 vec,  vec4 quat) {
    // https://twistedpairdevelopment.wordpress.com/2013/02/11/rotating-a-vector-by-a-quaternion-in-glsl/
    vec4 qv = mulQuat( quat, vec4(vec.xyz, 0.0) );
    return mulQuat(qv, vec4(-quat.x, -quat.y, -quat.z, quat.w) ).xyz;
}

// BY https://github.com/mattatz/ShibuyaCrowd/blob/master/source/shaders/common/quaternion.glsl
#define QUATERNION_IDENTITY vec4(0, 0, 0, 1)
vec4 QuaternionSlerp(vec4 a, vec4 b, float t) {
    // if either input is zero, return the other.
    if (length(a) == 0.0) {
        if (length(b) == 0.0) {
            return QUATERNION_IDENTITY;
        }
        return b;
    } else if (length(b) == 0.0) {
        return a;
    }

    float cosHalfAngle = a.w * b.w + dot(a.xyz, b.xyz);

    if (cosHalfAngle >= 1.0 || cosHalfAngle <= -1.0) {
        return a;
    } else if (cosHalfAngle < 0.0) {
        b.xyz = -b.xyz;
        b.w = -b.w;
        cosHalfAngle = -cosHalfAngle;
    }

    float blendA;
    float blendB;
    if (cosHalfAngle < 0.99) {
        // do proper slerp for big angles
        float halfAngle = acos(cosHalfAngle);
        float sinHalfAngle = sin(halfAngle);
        float oneOverSinHalfAngle = 1.0 / sinHalfAngle;
        blendA = sin(halfAngle * (1.0 - t)) * oneOverSinHalfAngle;
        blendB = sin(halfAngle * t) * oneOverSinHalfAngle;
    } else {
        // do lerp if angle is really small.
        blendA = 1.0 - t;
        blendB = t;
    }

    vec4 result = vec4(blendA * a.xyz + blendB * b.xyz, blendA * a.w + blendB * b.w);
    if (length(result) > 0.0) {
        return normalize(result);
    }
    return QUATERNION_IDENTITY;
}


vec3 QuaternionToEuler(vec4 quaternion)
{
    vec3 euler;
    if (quaternion.w > 1.0)quaternion = normalize(quaternion);
    float qx = quaternion.x;
    float qy = quaternion.y;
    float qz = quaternion.z;
    float qw = quaternion.w;

    float m00 = 1.0f - 2.0f * (qy * qy + qz * qz);
    float m10 = 2.0f * (qx * qy - qz * qw);
    float m20 = 2.0f * (qx * qz + qy * qw);
    float m21 = 2.0f * (qy * qz - qx * qw);
    float m22 = 1.0f - 2.0f * (qx * qx + qy * qy);

    euler.z = atan(-m20, sqrt(m00 * m00 + m10 * m10));
    euler.y = 2. * acos(qw);
    return euler;
}

void main() {
    vec3 local_pos = attPosition;

    vec2 acive_pixels_ratio = vec2(
        1.-(ceil(bound_min.z*10.)-bound_min.z*10.),
        1.-(bound_max.x*10.*-1.-floor(bound_max.x*10.*-1.))
    );

    float cur_frame = 0.;
    vec2 this_frame_uv = getThisFrameUv(acive_pixels_ratio, cur_frame);
    vec4 this_frame_pos = texture(pos_vat, this_frame_uv);
    vec4 rot_vat_val4 = texture(rot_vat, this_frame_uv);

    vec3 piece_pivot = getPiecePivot();
    vec4 this_quaternion;
    DecodeQuaternion(rot_vat_val4.xyz, floor(this_frame_pos.w*4.), this_quaternion);

    vec3 cur_frame_pos = this_frame_pos.xyz;
    vec4 cur_quaternion = this_quaternion;
    if(interframe_interpolation > 0.5)
    {
        // interpolate position
        float next_frame = 0.;
        vec2 next_frame_uv = getNextFrameUv(acive_pixels_ratio, cur_frame);
        vec4 next_frame_pos = texture(pos_vat, next_frame_uv);
        cur_frame_pos = mix(this_frame_pos.xyz, next_frame_pos.xyz, fract(display_frame));

        // interpolate rotation
        vec4 next_rot_vat_val4 = texture(rot_vat, next_frame_uv);
        vec4 next_quaternion;
        DecodeQuaternion(next_rot_vat_val4.xyz, floor(next_frame_pos.w*4.), next_quaternion);
        vec3 next_rot_val = RotateVectorByQuaternion(piece_pivot, next_quaternion);
        cur_quaternion = QuaternionSlerp(this_quaternion, next_quaternion , fract(display_frame));
    }

    vec3 cur_frame_rot = RotateVectorByQuaternion(piece_pivot, cur_quaternion);
    v_euler = QuaternionToEuler(cur_quaternion);

    vec3 res_pos = cur_frame_pos * vec3(-1,1,1) + cur_frame_rot;
    // res_pos = cur_frame_pos * vec3(-1,1,1);

    // if(animate_first_frame < 0.50001){
    //     res_pos = abs(cur_frame-1.)<1.?res_pos:local_pos;
    // }
    
    vec4 glpos = u_MVP * vec4(res_pos,1.0);
    FragPosLightSpace = u_LightSpaceMatrix * u_Model * vec4(res_pos,1.0);
    //vec4 glpos = u_View * vec4(res_pos,1.0);

    gl_Position = glpos;
    // gl_Position = u_MVP * vec4(attPosition, 1.0);
    vScreenPos = (vec2(glpos.xy/glpos.w)+1.)/2.;
    v_zdis = res_pos.z;
    // vScreenPos.y = 1.0 -vScreenPos.y;
    uv_0=uv0;
    uv_1=uv1;
    uv_2=uv2;
    uv_3=uv3;
    uv_4=uv4;
    uv_5=uv5;
    uv_6=uv6;
    uv_7=uv7;
    o_uv_ao = uv_ao;
    o_uv = uv0;
    o_uv.x = 1.-o_uv.x;
    o_col = vec4(piece_pivot, 1);
    o_col.rgb = normalize(attNormal);
    ///////////////////////////////// normal && tangent //////////////////////////////
    vNormal = RotateVectorByQuaternion(attNormal, cur_quaternion);
    vNormal = normalize(vNormal);

    vTangent = RotateVectorByQuaternion(attTangent.xyz, cur_quaternion);
    vTangent = normalize(vTangent);

    vBiNormal = RotateVectorByQuaternion(attBinormal, cur_quaternion);

    vec4 vPos4 = u_View * u_Model * vec4(attPosition, 1.0);
    vPosition = vPos4.xyz / vPos4.w;
    vec3 incident = normalize(res_pos);

    // o_col.xyz = attPosition - vec3(uv2.x*1., uv3.x, 1.-uv3.y);

    v_refraction = refract(incident, vNormal, Eta);
	v_reflection = reflect(incident, vNormal);
    f_fresnel = R0 + (1.0 - R0) * pow((1.0 - dot(-incident, vNormal)), 5.0);
}