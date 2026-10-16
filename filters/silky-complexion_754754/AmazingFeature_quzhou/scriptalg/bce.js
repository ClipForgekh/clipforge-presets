const BCE = {};
const BytennUtil = {};
const PLATFORM = effect.Bach.Platform.name().toLowerCase();

BCE.DeviceIOType = {
    kInvalid: 0,
    kCPUBuffer: 1,
    kGLTexture: 2,
    kCLImage: 3,
    kCLBuffer: 4,
    kCVPixelBuffer: 5,
    kMTLTexture: 6,
    kMTLBuffer: 7,
    kCUDABuffer: 8,
    kAHardwareBuffer: 9,
    kIONBuffer: 10,
    kExtendedBuffer: 11,
    kEGLImage: 12,
    kCUDADevicePtr: 13,
    kDX2CUDADevicePtr: 14,
    kCUDADevicePtr2DX: 15
};

BCE.BackendType = {
	kInvalid: 0,
    kCPU: 1,
    kGPU: 2,
    kDSP: 3,
    kNPU: 4,
    kMetal: 5,
    kOpenCL: 6,
    kOpenGL: 7,
    kVulkan: 8,
    kCUDA: 9,
    kCoreML: 10,
}

BytennUtil.BYTENN_CONFIG = {
    "input_name": "",
    "input_size": [0, 0],
    "output_name": "",
    "output_size": [0, 0]
};

BytennUtil.SetBytennConfig = function(model_config) {
    let input = model_config["inputs"][0];
    let output = model_config["outputs"][0];

    BytennUtil.BYTENN_CONFIG["input_name"] = input["name"];
    BytennUtil.BYTENN_CONFIG["input_size"][0] = input["size"][0];
    BytennUtil.BYTENN_CONFIG["input_size"][1] = input["size"][1];

    BytennUtil.BYTENN_CONFIG["output_name"] = output["name"];
    BytennUtil.BYTENN_CONFIG["output_size"][0] = output["size"][0];
    BytennUtil.BYTENN_CONFIG["output_size"][1] = output["size"][1];
}

BytennUtil.GetInputSize = function() {
	return BytennUtil.BYTENN_CONFIG["input_size"];
}
BytennUtil.GetInputName = function() {
	return BytennUtil.BYTENN_CONFIG["input_name"];
}
BytennUtil.GetOutputSize = function() {
	return BytennUtil.BYTENN_CONFIG["output_size"];
}
BytennUtil.GetOutputName = function() {
	return BytennUtil.BYTENN_CONFIG["output_name"];
}


const OpenclAlphaBlendKernel =
`
__kernel void alpha_blend(__read_only image2d_t input,
                        __write_only image2d_t output)
{
    float4 alpha = {0.5, 0.5, 0.5, 0.5};
    float4 beta = {0.5, 0.5, 0.5, 0.5};
    const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

	int x = (int)get_global_id(0);
	int y = (int)get_global_id(1);
	int w = get_image_width(output);
	int h = get_image_height(output);

	if (x >= w || y >= h) {
		return;
	}

	int2 pos = (int2)(get_global_id(0), get_global_id(1));
	float4 val = read_imagef(input, sampler, pos);
	val = val * alpha + beta;
	write_imagef(output, (int2)(x, y), val);
}
`;

const OpenclWarpAffineKernel =
`
__kernel void affine_warp(__read_only image2d_t input,
                        __write_only image2d_t output,
                        __global float* invTransMatrix
                        )
{
    const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE |
                           CLK_ADDRESS_CLAMP |
                           CLK_FILTER_LINEAR;
    float4 convert_alpha = {2, 2, 2, 2};
    float4 convert_beta = {-1, -1, -1, -1};

	int x = (int)get_global_id(0);
	int y = (int)get_global_id(1);
	int w = get_image_width(output);
	int h = get_image_height(output);

	if (x >= w || y >= h) {
		return;
	}
	float u = (float)x / (float)w;
	float v = (float)y / (float)h;
	float uu = invTransMatrix[0] * u + invTransMatrix[3] * v + invTransMatrix[6];
	float vv = invTransMatrix[1] * u + invTransMatrix[4] * v + invTransMatrix[7];

	int srcW = get_image_width(input);
	int srcH = get_image_height(input);
	float4 val = read_imagef(input, sampler, (int2)(round(uu * srcW), round(vv * srcH)));
	val = val * convert_alpha + convert_beta;
	write_imagef(output, (int2)(x, y), val);
}`;

const CudaAlphaBlendKernel = `
__global__ void AlphaBlendAndRGBAFloat2BGRAUint(const float *src, unsigned char *dst, int width, int height)
{
    int dx = blockIdx.x * blockDim.x + threadIdx.x;//x
    int dy = blockIdx.y * blockDim.y + threadIdx.y;//y
    int di = dy * width + dx;
    if (dx >= width || dy >= height) return;

    float4 alpha = make_float4(0.5f, 0.5f, 0.5f, 0.5f);
    float4 beta = make_float4(0.5f, 0.5f, 0.5f, 0.5f);
    int C = 4; // 4 channel default

    dst[di * C + 2] = floor((src[di * C + 2] * alpha.x + beta.x) * 255);
    dst[di * C + 1] = floor((src[di * C + 1] * alpha.y + beta.y) * 255);
    dst[di * C + 0] = floor((src[di * C ] * alpha.z + beta.z) * 255);
    dst[di * C + 3] = floor((src[di * C + 3] * alpha.w + beta.w) * 255);
}
`;

const CudaWarpAffineKernel = `
__global__ void WarpAffineAndBGRAUint2RGBFloat(const unsigned char *src, float *dst, float* transMatrix, 
                                                int dstH, int dstW, int dstC, int srcH, int srcW, int srcC)
{
    int dx = blockIdx.x * blockDim.x + threadIdx.x;//x
    int dy = blockIdx.y * blockDim.y + threadIdx.y;//y
    int di = dy * dstW + dx;
    if (dx >= dstW || dy >= dstH) return;

    float fx = dx / (float)dstW;
    float fy = dy / (float)dstH;
    float srcX = ((transMatrix[0] * fx + transMatrix[3] * fy + transMatrix[6]) * srcW);
    float srcY = ((transMatrix[1] * fx + transMatrix[4] * fy + transMatrix[7]) * srcH);
    //bi-linear interpolation
    const unsigned char const_values[] = {0, 0, 0, 0};
    const unsigned char* v1 = const_values;
    const unsigned char* v2 = const_values;
    const unsigned char* v3 = const_values;
    const unsigned char* v4 = const_values;
    int srcX_low = floor(srcX);
    int srcY_low = floor(srcY);
    int srcX_high = srcX_low + 1;
    int srcY_high = srcY_low + 1;
    float lx = srcX - srcX_low;
    float ly = srcY - srcY_low;
    float hx = 1 - lx;
    float hy = 1 - ly;
    float w1 = hy * hx;
    float w2 = hy * lx;
    float w3 = ly * hx;
    float w4 = ly * lx;

    int src_stride = srcW * srcC;
    if (srcY_low >= 0) {
        if (srcX_low >= 0) {
            v1 = src + srcY_low * src_stride + srcX_low * srcC;
        }
        if (srcX_high < srcW) {
            v2 = src + srcY_low * src_stride + srcX_high * srcC;
        }
    }
    if (srcY_high < srcH) {
        if (srcX_low >= 0) {
            v3 = src + srcY_high * src_stride + srcX_low * srcC;
        }
        if (srcX_high < srcW) {
            v4 = src + srcY_high * src_stride + srcX_high * srcC;
        }
    }

    float tempx = (w1 * v1[0]  + w2 * v2[0] + w3 * v3[0] + w4 * v4[0]) / 255.0;
    float tempy = (w1 * v1[1]  + w2 * v2[1] + w3 * v3[1] + w4 * v4[1]) / 255.0;
    float tempz = (w1 * v1[2]  + w2 * v2[2] + w3 * v3[2] + w4 * v4[2]) / 255.0;

    float4 alphaTemp = make_float4(2.0, 2.0, 2.0, 2.0);
    float4 betaTemp = make_float4(-1.0, -1.0, -1.0, -1.0);
    dst[di * 3] = tempx * alphaTemp.x + betaTemp.x;
    dst[di * 3 + 1] = tempy * alphaTemp.y + betaTemp.y;
    dst[di * 3 + 2] = tempz * alphaTemp.z + betaTemp.z;
}
`;

const CudaAlphaBlendPtxKernel = `
//
// Generated by NVIDIA NVVM Compiler
//
// Compiler Build ID: CL-30521435
// Cuda compilation tools, release 11.4, V11.4.152
// Based on NVVM 7.0.1
//

.version 7.0
.target sm_52
.address_size 64

	// .globl	_Z31AlphaBlendAndRGBAFloat2BGRAUintPKfPhii

.visible .entry _Z31AlphaBlendAndRGBAFloat2BGRAUintPKfPhii(
	.param .u64 _Z31AlphaBlendAndRGBAFloat2BGRAUintPKfPhii_param_0,
	.param .u64 _Z31AlphaBlendAndRGBAFloat2BGRAUintPKfPhii_param_1,
	.param .u32 _Z31AlphaBlendAndRGBAFloat2BGRAUintPKfPhii_param_2,
	.param .u32 _Z31AlphaBlendAndRGBAFloat2BGRAUintPKfPhii_param_3
)
{
	.reg .pred 	%p<4>;
	.reg .f32 	%f<17>;
	.reg .b32 	%r<17>;
	.reg .b64 	%rd<9>;


	ld.param.u64 	%rd1, [_Z31AlphaBlendAndRGBAFloat2BGRAUintPKfPhii_param_0];
	ld.param.u64 	%rd2, [_Z31AlphaBlendAndRGBAFloat2BGRAUintPKfPhii_param_1];
	ld.param.u32 	%r3, [_Z31AlphaBlendAndRGBAFloat2BGRAUintPKfPhii_param_2];
	ld.param.u32 	%r4, [_Z31AlphaBlendAndRGBAFloat2BGRAUintPKfPhii_param_3];
	mov.u32 	%r5, %ntid.x;
	mov.u32 	%r6, %ctaid.x;
	mov.u32 	%r7, %tid.x;
	mad.lo.s32 	%r1, %r6, %r5, %r7;
	mov.u32 	%r8, %ntid.y;
	mov.u32 	%r9, %ctaid.y;
	mov.u32 	%r10, %tid.y;
	mad.lo.s32 	%r2, %r9, %r8, %r10;
	setp.ge.s32 	%p1, %r1, %r3;
	setp.ge.s32 	%p2, %r2, %r4;
	or.pred  	%p3, %p1, %p2;
	@%p3 bra 	$L__BB0_2;

	cvta.to.global.u64 	%rd3, %rd2;
	cvta.to.global.u64 	%rd4, %rd1;
	mad.lo.s32 	%r11, %r2, %r3, %r1;
	shl.b32 	%r12, %r11, 2;
	cvt.s64.s32 	%rd5, %r12;
	mul.wide.s32 	%rd6, %r12, 4;
	add.s64 	%rd7, %rd4, %rd6;
	ld.global.f32 	%f1, [%rd7+8];
	fma.rn.f32 	%f2, %f1, 0f3F000000, 0f3F000000;
	mul.f32 	%f3, %f2, 0f437F0000;
	cvt.rmi.f32.f32 	%f4, %f3;
	cvt.rzi.u32.f32 	%r13, %f4;
	add.s64 	%rd8, %rd3, %rd5;
	st.global.u8 	[%rd8+2], %r13;
	ld.global.f32 	%f5, [%rd7+4];
	fma.rn.f32 	%f6, %f5, 0f3F000000, 0f3F000000;
	mul.f32 	%f7, %f6, 0f437F0000;
	cvt.rmi.f32.f32 	%f8, %f7;
	cvt.rzi.u32.f32 	%r14, %f8;
	st.global.u8 	[%rd8+1], %r14;
	ld.global.f32 	%f9, [%rd7];
	fma.rn.f32 	%f10, %f9, 0f3F000000, 0f3F000000;
	mul.f32 	%f11, %f10, 0f437F0000;
	cvt.rmi.f32.f32 	%f12, %f11;
	cvt.rzi.u32.f32 	%r15, %f12;
	st.global.u8 	[%rd8], %r15;
	ld.global.f32 	%f13, [%rd7+12];
	fma.rn.f32 	%f14, %f13, 0f3F000000, 0f3F000000;
	mul.f32 	%f15, %f14, 0f437F0000;
	cvt.rmi.f32.f32 	%f16, %f15;
	cvt.rzi.u32.f32 	%r16, %f16;
	st.global.u8 	[%rd8+3], %r16;

$L__BB0_2:
	ret;

}
`;
const CudaWarpAffinePtxKernel = `
//
// Generated by NVIDIA NVVM Compiler
//
// Compiler Build ID: CL-30521435
// Cuda compilation tools, release 11.4, V11.4.152
// Based on NVVM 7.0.1
//

.version 7.0
.target sm_52
.address_size 64

	// .globl	_Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii

.visible .entry _Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii(
	.param .u64 _Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_0,
	.param .u64 _Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_1,
	.param .u64 _Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_2,
	.param .u32 _Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_3,
	.param .u32 _Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_4,
	.param .u32 _Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_5,
	.param .u32 _Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_6,
	.param .u32 _Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_7,
	.param .u32 _Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_8
)
{
	.local .align 4 .b8 	__local_depot0[4];
	.reg .b64 	%SP;
	.reg .b64 	%SPL;
	.reg .pred 	%p<10>;
	.reg .b16 	%rs<14>;
	.reg .f32 	%f<70>;
	.reg .b32 	%r<29>;
	.reg .b64 	%rd<37>;


	mov.u64 	%SPL, __local_depot0;
	cvta.local.u64 	%SP, %SPL;
	ld.param.u64 	%rd17, [_Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_0];
	ld.param.u64 	%rd18, [_Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_1];
	ld.param.u64 	%rd19, [_Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_2];
	ld.param.u32 	%r9, [_Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_3];
	ld.param.u32 	%r10, [_Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_4];
	ld.param.u32 	%r11, [_Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_6];
	ld.param.u32 	%r12, [_Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_7];
	ld.param.u32 	%r13, [_Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii_param_8];
	mov.u32 	%r14, %ntid.x;
	mov.u32 	%r15, %ctaid.x;
	mov.u32 	%r16, %tid.x;
	mad.lo.s32 	%r1, %r15, %r14, %r16;
	mov.u32 	%r17, %ntid.y;
	mov.u32 	%r18, %ctaid.y;
	mov.u32 	%r19, %tid.y;
	mad.lo.s32 	%r2, %r18, %r17, %r19;
	setp.ge.s32 	%p1, %r1, %r10;
	setp.ge.s32 	%p2, %r2, %r9;
	or.pred  	%p3, %p2, %p1;
	@%p3 bra 	$L__BB0_12;

	cvta.to.global.u64 	%rd20, %rd19;
	cvt.rn.f32.s32 	%f6, %r1;
	cvt.rn.f32.s32 	%f7, %r10;
	div.rn.f32 	%f8, %f6, %f7;
	cvt.rn.f32.s32 	%f9, %r9;
	cvt.rn.f32.s32 	%f10, %r2;
	div.rn.f32 	%f11, %f10, %f9;
	ld.global.f32 	%f12, [%rd20];
	ld.global.f32 	%f13, [%rd20+12];
	mul.f32 	%f14, %f11, %f13;
	fma.rn.f32 	%f15, %f8, %f12, %f14;
	ld.global.f32 	%f16, [%rd20+24];
	add.f32 	%f17, %f16, %f15;
	cvt.rn.f32.s32 	%f18, %r12;
	mul.f32 	%f1, %f17, %f18;
	ld.global.f32 	%f19, [%rd20+4];
	ld.global.f32 	%f20, [%rd20+16];
	mul.f32 	%f21, %f11, %f20;
	fma.rn.f32 	%f22, %f8, %f19, %f21;
	ld.global.f32 	%f23, [%rd20+28];
	add.f32 	%f24, %f23, %f22;
	cvt.rn.f32.s32 	%f25, %r11;
	mul.f32 	%f2, %f24, %f25;
	add.u64 	%rd35, %SP, 0;
	cvta.to.local.u64 	%rd21, %rd35;
	mov.u16 	%rs1, 0;
	st.local.v4.u8 	[%rd21], {%rs1, %rs1, %rs1, %rs1};
	cvt.rmi.f32.f32 	%f26, %f1;
	cvt.rzi.s32.f32 	%r3, %f26;
	cvt.rmi.f32.f32 	%f27, %f2;
	cvt.rzi.s32.f32 	%r4, %f27;
	add.s32 	%r5, %r3, 1;
	add.s32 	%r6, %r4, 1;
	mul.lo.s32 	%r7, %r13, %r12;
	setp.lt.s32 	%p4, %r4, 0;
	mad.lo.s32 	%r8, %r2, %r10, %r1;
	mov.u64 	%rd32, %rd35;
	mov.u64 	%rd33, %rd35;
	@%p4 bra 	$L__BB0_6;

	add.u64 	%rd33, %SP, 0;
	setp.lt.s32 	%p5, %r3, 0;
	mov.u64 	%rd32, %rd33;
	@%p5 bra 	$L__BB0_4;

	mul.lo.s32 	%r20, %r3, %r13;
	mad.lo.s32 	%r21, %r4, %r7, %r20;
	cvt.s64.s32 	%rd22, %r21;
	add.s64 	%rd32, %rd17, %rd22;

$L__BB0_4:
	setp.ge.s32 	%p6, %r5, %r12;
	@%p6 bra 	$L__BB0_6;

	mul.lo.s32 	%r22, %r5, %r13;
	mad.lo.s32 	%r23, %r4, %r7, %r22;
	cvt.s64.s32 	%rd23, %r23;
	add.s64 	%rd33, %rd17, %rd23;

$L__BB0_6:
	cvt.rn.f32.s32 	%f29, %r4;
	sub.f32 	%f3, %f2, %f29;
	setp.ge.s32 	%p7, %r6, %r11;
	mov.f32 	%f69, 0f00000000;
	mov.u64 	%rd36, %rd35;
	@%p7 bra 	$L__BB0_11;

	add.u64 	%rd36, %SP, 0;
	setp.lt.s32 	%p8, %r3, 0;
	mov.u64 	%rd35, %rd36;
	@%p8 bra 	$L__BB0_9;

	mul.lo.s32 	%r24, %r3, %r13;
	mad.lo.s32 	%r25, %r6, %r7, %r24;
	cvt.s64.s32 	%rd24, %r25;
	add.s64 	%rd35, %rd17, %rd24;

$L__BB0_9:
	setp.ge.s32 	%p9, %r5, %r12;
	@%p9 bra 	$L__BB0_11;

	cvta.to.global.u64 	%rd25, %rd17;
	mul.lo.s32 	%r26, %r5, %r13;
	mad.lo.s32 	%r27, %r6, %r7, %r26;
	cvt.s64.s32 	%rd26, %r27;
	add.s64 	%rd27, %rd25, %rd26;
	add.s64 	%rd36, %rd17, %rd26;
	ld.global.u8 	%rs2, [%rd27];
	cvt.rn.f32.u16 	%f69, %rs2;

$L__BB0_11:
	cvta.to.global.u64 	%rd28, %rd18;
	cvt.rn.f32.s32 	%f31, %r3;
	sub.f32 	%f32, %f1, %f31;
	mov.f32 	%f33, 0f3F800000;
	sub.f32 	%f34, %f33, %f32;
	sub.f32 	%f35, %f33, %f3;
	mul.f32 	%f36, %f34, %f35;
	mul.f32 	%f37, %f32, %f35;
	mul.f32 	%f38, %f34, %f3;
	mul.f32 	%f39, %f32, %f3;
	ld.u8 	%rs3, [%rd32];
	cvt.rn.f32.u16 	%f40, %rs3;
	ld.u8 	%rs4, [%rd33];
	cvt.rn.f32.u16 	%f41, %rs4;
	mul.f32 	%f42, %f37, %f41;
	fma.rn.f32 	%f43, %f36, %f40, %f42;
	ld.u8 	%rs5, [%rd35];
	cvt.rn.f32.u16 	%f44, %rs5;
	fma.rn.f32 	%f45, %f38, %f44, %f43;
	fma.rn.f32 	%f46, %f39, %f69, %f45;
	div.rn.f32 	%f47, %f46, 0f437F0000;
	ld.u8 	%rs6, [%rd32+1];
	cvt.rn.f32.u16 	%f48, %rs6;
	ld.u8 	%rs7, [%rd33+1];
	cvt.rn.f32.u16 	%f49, %rs7;
	mul.f32 	%f50, %f37, %f49;
	fma.rn.f32 	%f51, %f36, %f48, %f50;
	ld.u8 	%rs8, [%rd35+1];
	cvt.rn.f32.u16 	%f52, %rs8;
	fma.rn.f32 	%f53, %f38, %f52, %f51;
	ld.u8 	%rs9, [%rd36+1];
	cvt.rn.f32.u16 	%f54, %rs9;
	fma.rn.f32 	%f55, %f39, %f54, %f53;
	div.rn.f32 	%f56, %f55, 0f437F0000;
	ld.u8 	%rs10, [%rd32+2];
	cvt.rn.f32.u16 	%f57, %rs10;
	ld.u8 	%rs11, [%rd33+2];
	cvt.rn.f32.u16 	%f58, %rs11;
	mul.f32 	%f59, %f37, %f58;
	fma.rn.f32 	%f60, %f36, %f57, %f59;
	ld.u8 	%rs12, [%rd35+2];
	cvt.rn.f32.u16 	%f61, %rs12;
	fma.rn.f32 	%f62, %f38, %f61, %f60;
	ld.u8 	%rs13, [%rd36+2];
	cvt.rn.f32.u16 	%f63, %rs13;
	fma.rn.f32 	%f64, %f39, %f63, %f62;
	div.rn.f32 	%f65, %f64, 0f437F0000;
	fma.rn.f32 	%f66, %f47, 0f40000000, 0fBF800000;
	mul.lo.s32 	%r28, %r8, 3;
	mul.wide.s32 	%rd29, %r28, 4;
	add.s64 	%rd30, %rd28, %rd29;
	st.global.f32 	[%rd30], %f66;
	fma.rn.f32 	%f67, %f56, 0f40000000, 0fBF800000;
	st.global.f32 	[%rd30+4], %f67;
	fma.rn.f32 	%f68, %f65, 0f40000000, 0fBF800000;
	st.global.f32 	[%rd30+8], %f68;

$L__BB0_12:
	ret;

}
`;

const MetalAlphaBlendKernel = `
#include <metal_stdlib>
using namespace metal;

kernel void alpha_blend(texture2d<float, access::read> input [[texture(0)]],
                        texture2d<float, access::write> output [[texture(1)]],
                        uint2 grid [[thread_position_in_grid]]
                        )
{
    float4 inColor = input.read(grid);
    float4 outColor = fma(inColor, 0.5h, 0.5h);
    output.write(outColor, grid);
}
`;
const MetalWarpAffineKernel = `
#include <metal_stdlib>
using namespace metal;

kernel void affine_warp(texture2d<float, access::read> input [[texture(0)]],
                        texture2d<float, access::write> output [[texture(1)]],
                        constant float* invTransMatrix [[buffer(2)]],
                        uint2 grid [[thread_position_in_grid]]
                        )
{
	int x = (int)grid.x;
	int y = (int)grid.y;
	int dstW = output.get_width();
	int dstH = output.get_height();
	if (x >= dstW || y >= dstH) {
		return;
	}
	int srcW = input.get_width();
	int srcH = input.get_height();

	float u = (float)x / (float)dstW;
	float v = (float)y / (float)dstH;
    float uu = invTransMatrix[0] * u + invTransMatrix[3] * v + invTransMatrix[6];
	float vv = invTransMatrix[1] * u + invTransMatrix[4] * v + invTransMatrix[7];
	float4 val = input.read(uint2(round(uu * srcW), round(vv * srcH)));
	val = fma(val, 2.0, -1.0);
	output.write(val, grid);
}
`;

class BCEUtil {
	constructor() {this.init();}

	init() {
		this.siso_kernel_map = {
			"metal": {
				"alpha_blend": {
					"kernel_name": "alpha_blend",
					"kernel_impl": MetalAlphaBlendKernel,
					"properties": [{
						"name":	"input",
						"index":	0,
						"objectType":	"inputdevicememptr",
						"deviceIOType":	"MTLTexture"
					}, {
						"name":	"output",
						"index":	1,
						"objectType":	"outputdevicememptr",
						"deviceIOType":	"cvpixelbuffer",
					}]
				},
				"warp_affine": {
					"kernel_name": "affine_warp",
					"kernel_impl": MetalWarpAffineKernel,
					"properties": [{
						"name":	"input",
						"index":	0,
						"objectType":	"inputdevicememptr",
						"deviceIOType":	"cvpixelbuffer",
					}, {
						"name":	"output",
						"index":	1,
						"objectType":	"outputdevicememptr",
						"deviceIOType":	"MTLTexture"
					}, {
						"name":	"invTransMatrix",
						"index":	2,
						"objectType":	"inputdevicememptr",
						"deviceIOType":	"MTLBuffer"
					}]
				},
				"bytenn": {
					"kernel_name": "",
					"kernel_impl": "",
					"properties": [{
						"name":	BytennUtil.GetInputName(),
						"index":	0,
						"objectType":	"inputdevicememptr",
						"deviceIOType":	"MTLTexture",
						"dataType":	"float32"
					},{
						"name":	BytennUtil.GetOutputName(),
						"index":	0,
						"objectType": "outputdevicememptr",
						"deviceIOType":	"MTLTexture",
						"dataType":	"float32"
					}]
				}
			},
			"opencl": {
				"alpha_blend": {
					"kernel_name": "alpha_blend",
					"kernel_impl": OpenclAlphaBlendKernel,
					"properties": [{
							"name":	"input",
							"index":	0,
							"objectType":	"inputdevicememptr",
							"deviceIOType":	"climage"
						}, {
							"name":	"output",
							"index":	1,
							"objectType":	"outputdevicememptr",
							"deviceIOType":	"climage",
							"extData": "shareWithDX"
						}]
				},
				"warp_affine": {
					"kernel_name": "affine_warp",
					"kernel_impl": OpenclWarpAffineKernel,
					"properties": [{
							"name":	"input",
							"index":	0,
							"objectType":	"inputdevicememptr",
							"deviceIOType":	"climage",
							"extData": "shareWithDX"
						}, {
							"name":	"output",
							"index":	1,
							"objectType":	"outputdevicememptr",
							"deviceIOType":	"climage"
						}, {
							"name":	"invTransMatrix",
							"index":	2,
							"objectType":	"inputdevicememptr",
							"deviceIOType":	"clbuffer"
						}]
				},
				"bytenn": {
					"kernel_name": "",
					"kernel_impl": "",
					"properties": [{
							"name":	BytennUtil.GetInputName(),
							"index":	0,
							"objectType":	"inputdevicememptr",
							"deviceIOType":	"climage",
							"dataType":	"float32"
						},{
							"name":	BytennUtil.GetOutputName(),
							"index":	0,
							"objectType": "outputdevicememptr",
							"deviceIOType":	"climage",
							"dataType":	"float32"
					}]
				}
			},
			"cuda": {
				"alpha_blend": {
					"kernel_name": "_Z31AlphaBlendAndRGBAFloat2BGRAUintPKfPhii",
					"kernel_impl": CudaAlphaBlendPtxKernel,
					"properties": [{
						"name":	"input",
						"index":	0,
						"objectType":	"inputdevicememptr",
						"deviceIOType":	"cudadeviceptr"
					}, {
						"name":	"output",
						"index":	1,
						"objectType":	"outputdevicememptr",
						"deviceIOType":	"cudadeviceptr2dx"
					}, {
						"name":	"width",
						"index":	2,
						"objectType":	"int",
						"value":	BytennUtil.GetOutputSize()[0]
					}, {
						"name":	"height",
						"index":	3,
						"objectType":	"int",
						"value":	BytennUtil.GetOutputSize()[1]
					}]
				},
				"warp_affine": {
					"kernel_name": "_Z30WarpAffineAndBGRAUint2RGBFloatPKhPfS1_iiiiii",
					"kernel_impl": CudaWarpAffinePtxKernel,
					"properties": [{
						"name":	"input",
						"index":	0,
						"objectType":	"inputdevicememptr",
						"deviceIOType":	"dx2cudadeviceptr"
					}, {
						"name":	"output",
						"index":	1,
						"objectType":	"outputdevicememptr",
						"deviceIOType":	"cudadeviceptr"
					}, {
						"name":	"invTransMatrix",
						"index":	2,
						"objectType":	"inputdevicememptr",
						"deviceIOType":	"cudadeviceptr"
					}, {
						"name":	"dstH",
						"index":	3,
						"objectType":	"int",
						"value":	BytennUtil.GetInputSize()[1]
					}, {
						"name":	"dstW",
						"index":	4,
						"objectType":	"int",
						"value":	BytennUtil.GetInputSize()[0]
					}, {
						"name":	"dstC",
						"index":	5,
						"objectType":	"int",
						"value":	3
					}, {
						"name":	"srcH",
						"index":	6,
						"objectType":	"int",
						"value":	BytennUtil.GetInputSize()[1]
					}, {
						"name":	"srcW",
						"index":	7,
						"objectType":	"int",
						"value":	BytennUtil.GetInputSize()[0]
					}, {
						"name":	"srcC",
						"index":	8,
						"objectType":	"int",
						"value":	4
					}]
				},
				"bytenn": {
					"kernel_name": "",
					"kernel_impl": "",
					"properties": [
						{
							"name":	BytennUtil.GetInputName(),
							"index":	0,
							"objectType":	"inputdevicememptr",
							"deviceIOType":	"cudadeviceptr",
							"dataType":	"float32"
						},{
							"name":	BytennUtil.GetOutputName(),
							"index":	0,
							"objectType": "outputdevicememptr",
							"deviceIOType":	"cudadeviceptr",
							"dataType":	"float32"
						}
					]
				}
			}
		};
		
		this.platform_backend_map = {
    		"ios": ["metal"],
    		"android": ["opencl"],
    		"mac": ["metal"],
    		"windows": ["opencl"]
    		// "windows": ["cuda", "opencl"]
		};

		this.tensor_deviceio_map = {
    		"metal": {
        		"matrix": "mtlbuffer",
        		"input": "CVPixelBuffer",
        		"warp_affine_out": "MTLTexture",
        		"inference_out": "MTLTexture",
        		"final_data": "CVPixelBuffer"
    		},
    		"opencl": {
        		"matrix": "clbuffer",
        		"input": "climage",
        		"warp_affine_out": "climage",
        		"inference_out": "climage",
        		"final_data": "climage"
    		},
    		"cuda": {
        		"matrix": "cudadeviceptr",
        		"input": "dx2cudadeviceptr",
        		"warp_affine_out": "cudadeviceptr",
        		"inference_out": "cudadeviceptr",
        		"final_data": "cudadeviceptr2dx"
    		}
		};

		this.current_backend_index = 0;
		this.current_backend = this.platform_backend_map[PLATFORM][this.current_backend_index];
		this.current_kernel_item = this.siso_kernel_map[this.current_backend];
		this.current_deviceio_item = this.tensor_deviceio_map[this.current_backend];
	}

	fallback() {
		console.log(`bce fallback from ${this.current_backend}`);
		this.current_backend_index++;
		if (this.current_backend_index >= this.platform_backend_map[PLATFORM].length) {
			this.current_backend = "unknown";
			this.current_kernel_item = null;
			this.current_deviceio_item = null;
			return false;
		}
		this.current_backend = this.platform_backend_map[PLATFORM][this.current_backend_index];
		this.current_kernel_item = this.siso_kernel_map[this.current_backend];
		this.current_deviceio_item = this.tensor_deviceio_map[this.current_backend];
		console.log(`bce fallback to ${this.current_backend}`);
		return true;
	}

	getAlphaBlendKernel() {
		return this.current_kernel_item["alpha_blend"]["kernel_impl"];
	}
	getWarpAffineKernel() {
		return this.current_kernel_item["warp_affine"]["kernel_impl"];
	}

	getAlphaBlendConfig() {
		return {
    	"libraryKind":	"normal",
		"programName":	"__alpha_blend1__",
		"backendType":	this.current_backend,
		"compileOptions": "",
		"kernels":	[{
				"kernelName":	this.current_kernel_item["alpha_blend"]["kernel_name"],
				"properties":	this.current_kernel_item['alpha_blend']['properties']
			}]
		}
	}

	getWarpAffineConfig() {
		return {
    	"libraryKind":	"normal",
		"programName":	"__warp_affine__",
		"backendType":	this.current_backend,
		"compileOptions": "",
		"kernels":	[{
				"kernelName":	this.current_kernel_item["warp_affine"]["kernel_name"],
				"properties":	this.current_kernel_item["warp_affine"]["properties"]
			}]
		}
	}

	getBytennOpConfig() {
		return {
    	"libraryKind":	"inference",
		"programName":	"__bytenn_op__",
		"precisionMode":	"normalprecision",
		"sourceFilePath":	"inference_model0.bin",
		"powerMode":	"normalpower",
		"runtimeLibLoadingPath":	"./",
		"forwardType":	this.current_backend,
		"oclKernelBinPath":	"./",
		"properties":	this.current_kernel_item["bytenn"]["properties"]
		}
	}

	getWarpAffineGraphConfig() {
		return {
    		"graphConfig":	{
				"backendType":	this.current_backend,
				"maxThreadNum":	2,
				"runtimeLibLoadingPath":	"./",
				"queueName":	""
			},
			"tensors":	[{
					"tensorName":	"matrix",
					"hostName":	"",
					"tensorType":	"input",
					"tensorDesc":	{
						"deviceIOType":	this.current_deviceio_item["matrix"],
						"dataType":	"float32",
						"dataFormat":	"nhwc",
						"shape":	[1, 3, 3, 1]
					}
				}, {
					"tensorName":	"input",
					"hostName":	"",
					"tensorType":	"input",
					"tensorDesc":	{
						"deviceIOType":	this.current_deviceio_item["input"],
						"dataType":	"uint8",
						"dataFormat":	"nhwc",
						"shape":	[1, BytennUtil.GetInputSize()[1], BytennUtil.GetInputSize()[0], 4]
					}
				}, {
					"tensorName":	"final_data",
					"hostName":	"warp_affine_op",
					"tensorType":	"output",
					"tensorDesc":	{
						"deviceIOType":	"cvpixelbuffer",
						"dataType":	"uint8",
						"dataFormat":	"nhwc",
						"shape":	[1, BytennUtil.GetInputSize()[1], BytennUtil.GetInputSize()[0], 4]
					}
				}
				],
			"links":	[
				{
					"opName":	"warp_affine_op",
					"opProperty":	{
						"backendType":	this.current_backend,
						"opType":	"normal",
						"programName":	"__warp_affine__",
						"kernelName":	this.current_kernel_item["warp_affine"]["kernel_name"]
					},
					"tensors":	[{
							"argName":	"input",
							"tensorName":	"input"
						}, {
							"argName":	"output",
							"tensorName":	"final_data"
						},{
							"argName":	"invTransMatrix",
							"tensorName":	"matrix"
						}]
				}
			]
		};
	}
	getGraphConfig() {
		return {
    		"graphConfig":	{
				"backendType":	this.current_backend,
				"maxThreadNum":	2,
				"runtimeLibLoadingPath":	"./",
				"queueName":	""
			},
			"tensors":	[{
					"tensorName":	"matrix",
					"hostName":	"",
					"tensorType":	"input",
					"tensorDesc":	{
						"deviceIOType":	this.current_deviceio_item["matrix"],
						"dataType":	"float32",
						"dataFormat":	"nhwc",
						"shape":	[1, 3, 3, 1]
					}
				}, {
					"tensorName":	"input",
					"hostName":	"",
					"tensorType":	"input",
					"tensorDesc":	{
						"deviceIOType":	this.current_deviceio_item["input"],
						"dataType":	"uint8",
						"dataFormat":	"nhwc",
						"shape":	[1, BytennUtil.GetInputSize()[1], BytennUtil.GetInputSize()[0], 4]
					}
				}, {
					"tensorName":	"warp_affine_out",
					"hostName":	"warp_affine_op",
					"tensorType":	"normal",
					"tensorDesc":	{
						"deviceIOType":	this.current_deviceio_item["warp_affine_out"],
						"dataType":	"float32",
						"dataFormat":	"nhwc",
						"shape":	[1, BytennUtil.GetInputSize()[1], BytennUtil.GetInputSize()[0], 4]
					}
				},{
					"tensorName":	"inference_out",
					"hostName":	"bytenn_op",
					"tensorType":	"normal",
					"tensorDesc":	{
						"deviceIOType":	this.current_deviceio_item["inference_out"],
						"dataType":	"float32",
						"dataFormat":	"nhwc",
						"shape":	[1, BytennUtil.GetOutputSize()[1], BytennUtil.GetOutputSize()[0], 4]
					}
				},
				{
					"tensorName":	"final_data",
					"hostName":	"alpha_blend_op",
					"tensorType":	"output",
					"tensorDesc":	{
						"deviceIOType":	this.current_deviceio_item["final_data"],
						"dataType":	"uint8",
						"dataFormat":	"nhwc",
						"shape":	[1, BytennUtil.GetOutputSize()[1], BytennUtil.GetOutputSize()[0], 4]
					}
				}],
			"links":	[
				{
					"opName":	"warp_affine_op",
					"opProperty":	{
						"backendType":	this.current_backend,
						"opType":	"normal",
						"programName":	"__warp_affine__",
						"kernelName":	this.current_kernel_item["warp_affine"]["kernel_name"]
					},
					"tensors":	[{
							"argName":	"input",
							"tensorName":	"input"
						}, {
							"argName":	"output",
							"tensorName":	"warp_affine_out"
						},{
							"argName":	"invTransMatrix",
							"tensorName":	"matrix"
						}]
				}, {
					"opName":	"bytenn_op",
					"opProperty":	{
						"backendType":	this.current_backend,
						"opType":	"inference",
						"programName":	"__bytenn_op__",
						"kernelName":	""
					},
					"tensors":	[{
							"argName":	BytennUtil.GetInputName(),
							"tensorName":	"warp_affine_out"
						},{
							"argName":	BytennUtil.GetOutputName(),
							"tensorName":	"inference_out"
						}]
				},{
					"opName":	"alpha_blend_op",
					"opProperty":	{
						"backendType":	this.current_backend,
						"opType":	"normal",
						"programName":	"__alpha_blend1__",
						"kernelName":	this.current_kernel_item["alpha_blend"]["kernel_name"]
					},
					"tensors":	[
					{
						"argName":	"input",
						"tensorName":	"inference_out"
					}, {
						"argName":	"output",
						"tensorName":	"final_data"
					}]
				}
			]
		}

	}

	printGraphConfig() {
		let config = JSON.stringify(this.getGraphConfig());
		for (let i = 0; i < config.length; i+= 100) {
			console.log(`graph config: ${config.slice(i, i+100)}`);
		}
	}
}


class EngineWrapper {
	constructor() {
		this.graphName = "bce_siso_graph";
		this.matrixTensorName = "matrix";
		this.inputTensorName = "input";
		this.outputTensorName = "final_data";
	}


	init(alg, model, modelConfig) {
		BytennUtil.SetBytennConfig(modelConfig);
		// initialize BceUtil after SetBytennConfig
		this.bceUtil = new BCEUtil();
		this.engine = null;
		let err = this.loadModel(alg, model);
		if (err != 0) {
			this.destroy();
			while (this.bceUtil.fallback()) {
				err = this.loadModel(alg, model);
				if (err == 0) {
					break;
				} else {
					this.destroy();
				}
			}
		}
		return err;
	}

	destroy() {
		if (this.engine) {
			this.engine.destroyGraph(this.graphName);
			this.engine.releaseEngine();
			this.engine = null;
		}
	}

	valid() {
		return this.engine != null;
	}

	loadModel(alg, model) {
        if (model.pData == null)
        {
            console.error(`bce loading model ${model.name} null`);
			return -1;
        }

    	this.engine = new effect.Bach.JSWrapBceEngine();
    	if (this.engine == null) {
        	console.error("create bce engine fail");
			return -1;
    	}

        let appConfig = alg.getCacheDir();
        let configMap = {"cache_dir": appConfig};
        let err = this.engine.setConfig(configMap);
        if (err != 0) {
            console.log(`bce engine setConfig fail`);
			this.destroy();
            return err;
        }

		if (PLATFORM == "windows" && this.bceUtil.current_backend == "opencl") {
			// sharing between dx and ocl, using compute engine.
			console.log("sharing between dx and opencl");
			err = this.engine.shareContext(alg.app.engine);
			if (err != 0) {
				this.destroy();
				return err;
			}
		}
        
		// console.log(`bytenn config: ${JSON.stringify(this.bceUtil.getBytennOpConfig())}`);
        err = this.engine.registerLibraryFromJson(JSON.stringify(this.bceUtil.getBytennOpConfig()), model.pData);
        if (err != 0) {
            console.error(`registerLibraryFromJson bytennOpConfig fail`);
			this.destroy();
            return err;
        }
		// console.log(`warpaffine config: ${JSON.stringify(this.bceUtil.getWarpAffineConfig())}`);
        err = this.engine.registerLibraryFromJson(JSON.stringify(this.bceUtil.getWarpAffineConfig()), this.bceUtil.getWarpAffineKernel());
        if (err != 0) {
            console.error(`registerLibraryFromJson warpAffineConfig fail`);
			this.destroy();
            return err;
        }
		// console.log(`alphablend config: ${JSON.stringify(this.bceUtil.getAlphaBlendConfig())}`);
        err = this.engine.registerLibraryFromJson(JSON.stringify(this.bceUtil.getAlphaBlendConfig()), this.bceUtil.getAlphaBlendKernel());
        if (err != 0) {
            console.error(`registerLibraryFromJson alphaBlendConfig1 fail`);
			this.destroy();
            return err;
        }
		// this.bceUtil.printGraphConfig();
        err = this.engine.createGraphFromJson(this.graphName, JSON.stringify(this.bceUtil.getGraphConfig()));
        // err = this.engine.createGraphFromJson(this.#graphName, JSON.stringify(this.bceUtil.getWarpAffineGraphConfig()));
        if (err != 0) {
            console.error(`CreateGraphFromJson graphConfig fail`);
			this.destroy();
            return err;
        }
        err = this.engine.initGraph(this.graphName);
        if (err != 0) {
            console.log(`bce engine init fail, graphName = ${this.graphName}`);
			this.destroy();
            return err;
        }
		return err;

	}

	// affineData must be normalized
	// outputMapIndex: corresponding to addOutputType(index)
	// outputIndex: 
	execute(nodeContext, computeEngine, inputTex, affineData, outputMapIndex, outputIndex) {
		if (this.engine == null) {
			console.error(`invalid bce engine null`);
			return -1;
		}
		let err = 0;
		// set input tensor
		// if (this.bceUtil.current_backend == "cuda" || this.bceUtil.current_backend == "opencl" || this.bceUtil.current_backend == "metal") {
		if (PLATFORM == "windows" || PLATFORM == "ios" || PLATFORM == "android") {
			let ioType = BCE.DeviceIOType.kInvalid;
			if (this.bceUtil.current_backend == "opencl") {
				ioType = BCE.DeviceIOType.kCLImage;
			}
			if (this.bceUtil.current_backend == "cuda") {
				ioType = BCE.DeviceIOType.kDX2CUDADevicePtr;
			}
			// if (this.inputTensor == null || this.inputTensor.tex.width != inputTex.width || this.inputTensor.tex.height != inputTex.height) {
			if (this.inputTensor == null) {
				let inputAlgTex = computeEngine.createTex(BytennUtil.GetInputSize()[0], BytennUtil.GetInputSize()[1], 0); // 0 is rgba8unorm
				this.inputTensor = this.engine.createTensor(inputAlgTex, true, ioType);
			}
			this.inputTensor.wait();
			if (PLATFORM == "ios" || PLATFORM == "android") {
				inputTex.copyTo(this.inputTensor.tex);
			}
			err = this.engine.setTensor(this.graphName, this.inputTensorName, this.inputTensor, true);
			if (PLATFORM == "windows") {
				// for windows, copyTo must be called after setTensor, because setTensor will call initDxData and copyTo will call initGpuData.
				inputTex.copyTo(this.inputTensor.tex);
			}
			if (err != 0) return err;
		}
		else {
			this.inputTensor = this.engine.createTensor(inputTex, true);
			err = this.engine.setTensor(this.graphName, this.inputTensorName, this.inputTensor, true);
			if (err != 0)  return err;
		}

		// set matrix data
		err = this.engine.setTensorData(this.graphName, this.matrixTensorName, 1, affineData.getBuffer());
		if (err != 0) return err;

		// set output tensor
		let outputIoType = BCE.DeviceIOType.kInvalid;
		if (PLATFORM == "windows" && this.bceUtil.current_backend == "opencl") {
			outputIoType = BCE.DeviceIOType.kCLImage;
		}
        this.outputTensor = nodeContext.getOutputBceTensor(
            computeEngine,
            BytennUtil.GetOutputSize()[0],
            BytennUtil.GetOutputSize()[1],
            0, //Bach.AEPixelFormat.RGBA8UNORM
            outputIndex,
            this.engine,
			outputMapIndex,
			outputIoType
		);
		err = this.engine.setTensor(this.graphName, this.outputTensorName, this.outputTensor, false);
		if (err != 0) return err;

		// dispatch
		err = this.engine.submit(this.graphName);
		if (err != 0) return err;

		if (PLATFORM != "windows") {
			err = this.engine.insertSync(this.graphName);
		}
		if (PLATFORM == "mac" || PLATFORM == "android") {
			err = this.outputTensor.wait();
			err = this.outputTensor.sync(false);
		}
		return err;

	}
}

BCE.Engine = EngineWrapper;
BCE.GetInputSize = function() {
	return BytennUtil.GetInputSize();
}
BCE.GetOutputSize = function() {
	return BytennUtil.GetOutputSize();
}

exports.BCE = BCE;
