/**
 * 自定义缓动函数库
 *
 * 提供 Tween.js 官方未提供的缓动组合。
 * LLM 产物只从此模块选取已命名曲线，不得自造任意 function(k){...}。
 *
 * ─── 顶层分组（按曲线形态） ───────────────────────────────────────────────
 *   OutIn.*      —— 先释放再收束，Out/In 组合模式（独立保留）
 *   Progress.*   —— 单调或衰减至 1 的曲线（A→B 过渡）
 *   Pulse.*      —— 单次返零脉冲（f(0)=f(1)=0, 单主峰）
 *   Wave.*       —— 周期多峰振荡（f(0)=f(1)=0, 多次反转）
 *   cubicBezier(name | x1,y1,x2,y2) —— 贝塞尔工厂（L2，受限）
 *
 * 二级键沿用主题语义（Physics/Motion/Step/Attention/Breath/Heart/Math/
 * Explosion/Nature/Impact/Rhythm/UI/Magic/Animal），三级键为具体
 * 曲线。业界库曲线已并入最贴近的主题：Physics.Spring、Step.Steps6、
 * Heart.Beat。通用 UI 柔化请直接选用原生 Sinusoidal/Quadratic/Cubic（等）；
 * 需定制贝塞尔时使用 cubicBezier(x1,y1,x2,y2) 工厂。例：
 *   customEasings.Progress.Physics.Spring
 *   customEasings.Pulse.Explosion.Impulse
 *   customEasings.Wave.Breath.Normal
 *
 * 完整清单位于文件末尾 Progress / Pulse / Wave 的 Object.freeze 声明。
 */

const TWEEN = require('./tween');

// ─── §1 OutIn 模式 ────────────────────────────────────────────────────────

/**
 * 将 Out / In 曲线组合为 OutIn 模式。
 *   k ∈ [0, 0.5] 走 easingOut(2k) 的前半，映射到 [0, 0.5]
 *   k ∈ [0.5, 1] 走 easingIn(2k - 1) 的前半，映射到 [0.5, 1]
 */
function makeOutIn(easingOut, easingIn) {
  return function outIn(k) {
    if (k < 0.5) return 0.5 * easingOut(k * 2);
    return 0.5 * easingIn(k * 2 - 1) + 0.5;
  };
}

const E = TWEEN.Easing;

const OutIn = Object.freeze({
  Sinusoidal:  makeOutIn(E.Sinusoidal.Out,  E.Sinusoidal.In),
  Exponential: makeOutIn(E.Exponential.Out, E.Exponential.In),
  Circular:    makeOutIn(E.Circular.Out,    E.Circular.In),
  Elastic:     makeOutIn(E.Elastic.Out,     E.Elastic.In),
  Back:        makeOutIn(E.Back.Out,        E.Back.In),
  Bounce:      makeOutIn(E.Bounce.Out,      E.Bounce.In),
  Quadratic:   makeOutIn(E.Quadratic.Out,   E.Quadratic.In),
  Cubic:       makeOutIn(E.Cubic.Out,       E.Cubic.In),
  Quartic:     makeOutIn(E.Quartic.Out,     E.Quartic.In),
  Quintic:     makeOutIn(E.Quintic.Out,     E.Quintic.In),
});

// ─── §2 Smooth（已整组移除：原生 Sinusoidal/Quadratic/Cubic 已覆盖通用 UI 柔化场景） ───

// ─── §3 Physics 物理系 ─────────────────────────────────────────────────────

// 欠阻尼弹簧（软）：ζ≈0.3，约一次明显越界
const springSoft = (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  return 1 - Math.exp(-6 * k) * Math.cos(12 * k);
};

// 欠阻尼弹簧（硬）：更高频振荡、更慢收敛
const springStiff = (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  return 1 - Math.exp(-5 * k) * Math.cos(18 * k);
};

// 阻尼振荡：sin 基波收尾抖动
const dampedOscillation = (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  return 1 - Math.exp(-5 * k) * Math.cos(10 * k);
};

const Physics = Object.freeze({
  SpringSoft: springSoft,
  SpringStiff: springStiff,
  DampedOscillation: dampedOscillation,
});

// ─── §4 Motion 动作设计系 ──────────────────────────────────────────────────

// 先回拉 10% 再冲向终点：蓄力动作
const anticipate = (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  const pullback = 0.1;
  if (k < 0.3) {
    const p = k / 0.3;
    return -pullback * p * (2 - p); // easeOutQuad 到 -pullback
  }
  const p = (k - 0.3) / 0.7;
  return -pullback + (1 + pullback) * p * p * (3 - 2 * p); // smoothstep 到 1
};

// 冲到 peak 再回到 1 的工厂
const overshootFactory = (peak) => (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  if (k < 0.6) {
    const p = k / 0.6;
    return peak * p * (2 - p); // easeOutQuad 到 peak
  }
  const p = (k - 0.6) / 0.4;
  return peak + (1 - peak) * (1 - Math.pow(1 - p, 3)); // easeOutCubic 到 1
};

const overshoot110 = overshootFactory(1.10);
const overshoot125 = overshootFactory(1.25);

// 快速到位（前 60% 冲到 1.05），后 40% 回到 1：磁吸、卡扣
const snapBack = (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  if (k < 0.6) {
    const p = k / 0.6;
    return 1.05 * (1 - Math.pow(1 - p, 3));
  }
  const p = (k - 0.6) / 0.4;
  return 1.05 - 0.05 * p * p * (3 - 2 * p);
};

// 摆锤式：一次轻微过冲后收敛
const swing = (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  return 1 - Math.cos(1.5 * Math.PI * k) * Math.exp(-2.5 * k);
};

const Motion = Object.freeze({
  Anticipate: anticipate,
  Overshoot110: overshoot110,
  Overshoot125: overshoot125,
  SnapBack: snapBack,
  Swing: swing,
});

// ─── §5 Step 步进系 ────────────────────────────────────────────────────────

/**
 * CSS steps() 等价工厂。
 * @param {number} n 段数
 * @param {'start' | 'end'} jumpTerm 跳变在每段的起始还是结束（默认 'end'）
 */
const makeStep = (n, jumpTerm = 'end') => (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  if (jumpTerm === 'start') return Math.ceil(k * n) / n;
  return Math.floor(k * n) / n;
};

const Step = Object.freeze({
  Steps4End: makeStep(4, 'end'),
  Steps8End: makeStep(8, 'end'),
  Steps12End: makeStep(12, 'end'),
});

// ─── §6 Bezier 规范贝塞尔 ──────────────────────────────────────────────────

/**
 * 给定两个控制点 (x1,y1) 与 (x2,y2)，P0=(0,0) P3=(1,1)。
 * 返回函数 f(t) -> y，其中 t 是输入时间（需先用牛顿法从 x 反解 s）。
 */
function buildCubicBezier(x1, y1, x2, y2) {
  const cx = 3 * x1, bx = 3 * (x2 - x1) - cx, ax = 1 - cx - bx;
  const cy = 3 * y1, by = 3 * (y2 - y1) - cy, ay = 1 - cy - by;
  const sampleX = (s) => ((ax * s + bx) * s + cx) * s;
  const sampleY = (s) => ((ay * s + by) * s + cy) * s;
  const sampleDX = (s) => (3 * ax * s + 2 * bx) * s + cx;

  const solveS = (x) => {
    let s = x;
    for (let i = 0; i < 8; i++) {
      const cur = sampleX(s) - x;
      if (Math.abs(cur) < 1e-6) return s;
      const d = sampleDX(s);
      if (Math.abs(d) < 1e-6) break;
      s -= cur / d;
      if (s < 0) s = 0;
      if (s > 1) s = 1;
    }
    // 兜底二分
    let lo = 0, hi = 1;
    for (let i = 0; i < 32 && hi - lo > 1e-6; i++) {
      const mid = (lo + hi) / 2;
      if (sampleX(mid) < x) lo = mid; else hi = mid;
    }
    return (lo + hi) / 2;
  };

  return (k) => {
    if (k <= 0) return 0;
    if (k >= 1) return 1;
    return sampleY(solveS(k));
  };
}

// 贝塞尔白名单：(x1, y1, x2, y2)
const BEZIER_PRESETS = Object.freeze({
  'Material.Standard':    [0.4,  0,    0.2,  1],
  'Material.Accelerate':  [0.4,  0,    1,    1],
  'Material.Decelerate':  [0,    0,    0.2,  1],
  'CSS.Ease':             [0.25, 0.1,  0.25, 1],
});

// 工厂 memoization（避免同参数重复构造）
const _bezierCache = new Map();
function _cachedBezier(x1, y1, x2, y2) {
  const key = x1 + ',' + y1 + ',' + x2 + ',' + y2;
  let fn = _bezierCache.get(key);
  if (!fn) {
    fn = buildCubicBezier(x1, y1, x2, y2);
    _bezierCache.set(key, fn);
  }
  return fn;
}

/**
 * cubicBezier('Material.Standard') | cubicBezier(x1, y1, x2, y2)
 * 直写参数受控域：x1/x2 ∈ [0,1]，y1/y2 ∈ [-0.5, 1.5]
 */
function cubicBezier(a, b, c, d) {
  if (typeof a === 'string') {
    let preset = BEZIER_PRESETS[a];
    if (!preset) {
      console.warn('[customEasings.cubicBezier] unknown preset, falling back to Material.Standard:', a);
      preset = BEZIER_PRESETS['Material.Standard'];
    }
    return _cachedBezier(preset[0], preset[1], preset[2], preset[3]);
  }
  // 数值入口：裁剪到允许域
  const clamp = (v, lo, hi) => Math.max(lo, Math.min(hi, v));
  const x1 = clamp(a, 0, 1);
  const y1 = clamp(b, -0.5, 1.5);
  const x2 = clamp(c, 0, 1);
  const y2 = clamp(d, -0.5, 1.5);
  return _cachedBezier(x1, y1, x2, y2);
}

// 命名贝塞尔实例已整组移除：Material/CSS 预设与原生 Sinusoidal/Quadratic/Cubic
// 数值上几乎等价，特殊场景请直接调用 cubicBezier('Material.Standard') 等工厂。

// ═══════════════════════════════════════════════════════════════════════════
// 扩展分组（与已有 6 组并列，不污染既有命名空间）
// ═══════════════════════════════════════════════════════════════════════════

// ─── §7 业界库扩展（已并入 Physics / Step / Heart） ─────────────────────────
// 以下工厂原本聚合在 Lib.* 命名空间下，现已按语义归入相应主题：
//   Spring (Framer Motion) → Progress.Physics.Spring
//   Steps  (GSAP)          → Progress.Step.Steps6
//   HeartBeat              → Wave.Heart.Beat
// 退役：Framer Motion 的 Anticipate / GSAP 的 Overshoot factory（由 Motion.*
// 覆盖）；GSAP ExpoScale / Unity SmoothDamp（数值上与原生 Sinusoidal/Quadratic
// 等价，已整组移除）。

// Spring（Framer Motion 风格）：参数化弹簧，离散积分
const libSpring = ({ stiffness = 180, damping = 12, mass = 1 } = {}) => {
  const DT = 1 / 240;
  const T = 1.5;
  let x = 0, v = 0;
  const samples = [];
  for (let t = 0; t <= T; t += DT) {
    const force = -stiffness * (x - 1) - damping * v;
    v += (force / mass) * DT;
    x += v * DT;
    samples.push({ t, x });
  }
  let T_end = T;
  for (let i = samples.length - 1; i >= 0; i--) {
    if (Math.abs(samples[i].x - 1) > 0.01) { T_end = samples[i].t; break; }
  }
  return (k) => {
    if (k <= 0) return 0;
    if (k >= 1) return 1;
    const t = k * T_end;
    const idx = Math.min(samples.length - 1, Math.floor(t / DT));
    return samples[idx].x;
  };
};

// HeartBeat（简易版）：两高斯峰的绝对值轨迹
const libHeartBeat = (peak = 0.3) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  const bell = (t, c) => Math.exp(-((t - c) ** 2) / (2 * 0.07 * 0.07));
  return peak * (bell(k, 0.2) + bell(k, 0.5));
};

// Steps（GSAP SteppedEase 风格 factory）：离散 N 段阶梯（默认 n=6）
const libSteps = (n = 6) => (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  return Math.floor(k * n) / n;
};

// ─── §8 Attention 注意力 / 抖振 ────────────────────────────────────────────

// Ping：单次衰减脉冲（雷达 ping），sin(π·k) × exp(-decay·k)
const attentionPing = (peak = 0.35, decay = 2) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  return peak * Math.sin(Math.PI * k) * Math.exp(-decay * k);
};

// Wiggle：衰减正弦振荡（easing 值本身，非位置增量）
const attentionWiggle = (count = 4, amplitude = 0.25) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  const env = 1 - k;
  return amplitude * env * Math.sin(k * Math.PI * 2 * count);
};

// Strum：多峰衰减（吉他拨弦）
const attentionStrum = (notes = 4, peak = 0.4) => {
  const centers = [];
  for (let i = 0; i < notes; i++) {
    centers.push({ c: 0.15 + i * (0.7 / Math.max(1, notes - 1)), a: Math.pow(0.72, i) });
  }
  return (k) => {
    if (k <= 0 || k >= 1) return 0;
    let sum = 0;
    for (const { c, a } of centers) {
      sum += a * Math.exp(-((k - c) ** 2) / (2 * 0.05 * 0.05));
    }
    return peak * sum;
  };
};

const Attention = Object.freeze({
  Ping:   attentionPing(),
  Wiggle: attentionWiggle(),
  Strum:  attentionStrum(),
});

// ─── §9 Breath 呼吸 ────────────────────────────────────────────────────────

// Normal：慢节奏正弦呼吸
const breathNormal = (cycles = 2, peak = 0.15) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  return peak * Math.sin(k * Math.PI * 2 * cycles) * Math.sin(k * Math.PI);
};

// Deep：深呼吸——慢吸气 → hold → 慢呼气
const breathDeep = (peak = 0.3, riseRatio = 0.35, holdRatio = 0.15) => {
  const holdEnd = riseRatio + holdRatio;
  return (k) => {
    if (k <= 0 || k >= 1) return 0;
    if (k < riseRatio) {
      const t = k / riseRatio;
      return peak * Math.sin(t * Math.PI / 2);
    }
    if (k < holdEnd) {
      return peak;
    }
    const t = (k - holdEnd) / (1 - holdEnd);
    return peak * Math.cos(t * Math.PI / 2);
  };
};

// Panting：急促浅呼吸——多次小幅起伏 + 正弦包络
const breathPanting = (cycles = 6, peak = 0.08) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  const envelope = Math.sin(k * Math.PI);
  const wave = 0.5 + 0.5 * Math.sin(k * Math.PI * 2 * cycles - Math.PI / 2);
  return peak * envelope * wave;
};

// Sigh：叹息——快速吸气后慢速释放
const breathSigh = (peak = 0.25, riseRatio = 0.2) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  if (k < riseRatio) {
    const t = k / riseRatio;
    return peak * Math.sin(t * Math.PI / 2);
  }
  const t = (k - riseRatio) / (1 - riseRatio);
  return peak * (1 - t) * (1 - t);
};

const Breath = Object.freeze({
  Normal:  breathNormal(),
  Deep:    breathDeep(),
  Panting: breathPanting(),
  Sigh:    breathSigh(),
});

// ─── §10 Heart 心跳 ────────────────────────────────────────────────────────

// Calm：单次舒缓心跳——单高斯峰
const heartCalm = (peak = 0.25, center = 0.35, width = 0.1) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  return peak * Math.exp(-((k - center) ** 2) / (2 * width * width));
};

// Excited：兴奋/紧张——密集快速心跳（N 连击）
const heartExcited = (beats = 4, peak = 0.3, width = 0.04) => {
  const centers = [];
  const span = 0.7;
  for (let i = 0; i < beats; i++) {
    centers.push(0.15 + i * (span / Math.max(1, beats - 1)));
  }
  return (k) => {
    if (k <= 0 || k >= 1) return 0;
    let sum = 0;
    for (const c of centers) {
      sum += Math.exp(-((k - c) ** 2) / (2 * width * width));
    }
    return peak * sum;
  };
};

// LubDub：标准心跳「lub-dub」双音节
const heartLubDub = (peak = 0.3) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  const bell = (t, c, w) => Math.exp(-((t - c) ** 2) / (2 * w * w));
  // lub（S1）：中心 0.25、宽 0.045、幅 1.0
  // dub（S2）：中心 0.42、宽 0.03、幅 0.6
  return peak * (bell(k, 0.25, 0.045) + 0.6 * bell(k, 0.42, 0.03));
};

const Heart = Object.freeze({
  Calm:    heartCalm(),
  Excited: heartExcited(),
  LubDub:  heartLubDub(),
});

// ─── §11 Math 物理 / 数学 ─────────────────────────────────────────────────

// JumpArc：抛物线轨迹 4k(1-k)
const mathJumpArc = () => (k) => {
  if (k <= 0 || k >= 1) return 0;
  return 4 * k * (1 - k);
};

// Pendulum：物理摆——sin(πk) 包络的衰减余弦，端点归零（满足 Wave 契约 f(0)=f(1)=0）
const mathPendulum = (damping = 3, freq = 2.5) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  return Math.sin(k * Math.PI) * Math.exp(-damping * k) * Math.cos(freq * Math.PI * k);
};

// Tremor：持续高频小幅抖动（不衰减），整体沿 Linear 进行
const mathTremor = (amplitude = 0.04, freq = 22) => (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  return k + amplitude * Math.sin(k * Math.PI * 2 * freq);
};

// Boomerang 包装器：把任意 easing 包装成 0→1→0（先去再回）。
// 仅作为内部辅助使用，不暴露为公共曲线——常用变体已预实例化为
// Pulse.Math.BoomerangSharp / BoomerangSoft（见 Pulse 命名空间）。
const mathBoomerang = (fn) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  return k < 0.5 ? fn(k * 2) : fn(2 - k * 2);
};

const MathExt = Object.freeze({
  JumpArc:  mathJumpArc(),
  Pendulum: mathPendulum(),
  Tremor:   mathTremor(),
});

// ─── §12 Explosion 爆炸 ────────────────────────────────────────────────────

// Impulse：指数脉冲响应 k·e^(1-k·sharpness)（减线性尾项使 k=1 归 0）
const explosionImpulse = (sharpness = 6) => {
  const tail = sharpness * Math.exp(1 - sharpness);
  return (k) => {
    if (k <= 0 || k >= 1) return 0;
    const h = sharpness * k;
    return h * Math.exp(1 - h) - tail * k;
  };
};

// Flash：瞬间拉满 + 指数衰减到 0
const explosionFlash = (rise = 0.05, decay = 5) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  if (k < rise) return k / rise;
  return Math.exp(-decay * (k - rise));
};

// Recoil：爆炸反冲——负向冲击 -1 + 阻尼振荡
const explosionRecoil = (decay = 4, freq = 3) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  return -Math.exp(-decay * k) * Math.cos(freq * Math.PI * k);
};

// Implosion：三段式——负向吸能 → 正向爆发 → 衰减归 0
const explosionImplosion = (charge = 0.3, depth = 0.4, burstPeak = 1.2) => {
  const sharp = 5;
  const tail = sharp * Math.exp(1 - sharp);
  return (k) => {
    if (k <= 0 || k >= 1) return 0;
    if (k < charge) {
      const t = k / charge;
      return -depth * Math.sin(t * Math.PI / 2);
    }
    const t = (k - charge) / (1 - charge);
    const h = sharp * t;
    const wave = h * Math.exp(1 - h) - tail * t;
    const settle = -depth * Math.pow(1 - t, 3);
    return settle + burstPeak * wave;
  };
};

const Explosion = Object.freeze({
  Impulse:   explosionImpulse(),
  Flash:     explosionFlash(),
  Recoil:    explosionRecoil(),
  Implosion: explosionImplosion(),
});

// ─── §13 Cinema（已整组移除：Creep=k^3.5 与 Cubic.In/Quartic.In 数值等价） ─

// ─── §14 Nature 自然现象 ───────────────────────────────────────────────────

// Wave：海浪律动——多谐波叠加 + 整体正弦包络
const natureWave = (cycles = 3, amplitude = 0.25) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  const env = Math.sin(k * Math.PI);
  const w = Math.sin(k * Math.PI * 2 * cycles)
          + 0.5 * Math.sin(k * Math.PI * 2 * cycles * 1.5 + 1.2)
          + 0.25 * Math.sin(k * Math.PI * 2 * cycles * 3 + 2.4);
  return amplitude * env * w * 0.6;
};

// Flicker：火焰闪烁——伪随机采样 + 线性插值 + 正弦包络
const natureFlicker = (rate = 15, intensity = 0.2, seed = 7) => {
  let s = seed;
  const rand = () => { s = (s * 9301 + 49297) % 233280; return s / 233280; };
  const samples = [];
  for (let i = 0; i <= rate + 1; i++) samples.push(rand());
  return (k) => {
    if (k <= 0 || k >= 1) return 0;
    const env = Math.sin(k * Math.PI);
    const pos = k * rate;
    const idx = Math.floor(pos);
    const t = pos - idx;
    const a = samples[idx];
    const b = samples[idx + 1];
    const interp = a + (b - a) * t;
    return intensity * env * (interp - 0.5) * 2;
  };
};

// Gust：风——N 次高斯阵风叠加
const natureGust = (gusts = 3, peak = 0.25) => {
  const centers = [];
  const span = 0.7;
  for (let i = 0; i < gusts; i++) {
    centers.push(0.15 + i * (span / Math.max(1, gusts - 1)));
  }
  return (k) => {
    if (k <= 0 || k >= 1) return 0;
    let sum = 0;
    for (const c of centers) {
      sum += Math.exp(-((k - c) ** 2) / (2 * 0.08 * 0.08));
    }
    return peak * sum / gusts * 1.8;
  };
};

const Nature = Object.freeze({
  Wave:    natureWave(),
  Flicker: natureFlicker(),
  Gust:    natureGust(),
});

// ─── §15 Impact 撞击 / 落地 ────────────────────────────────────────────────

// Rain：雨滴下落——重力加速段 + 撞击 + 小幅余震
const impactRain = (impactAt = 0.7, rippleAmp = 0.08) => (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  if (k < impactAt) {
    const t = k / impactAt;
    return t * t;
  }
  const t = (k - impactAt) / (1 - impactAt);
  return 1 + rippleAmp * Math.exp(-4 * t) * Math.sin(t * Math.PI * 6);
};

// Hammer：锤击——抬起蓄力（负值）→ 快速下击 → 微反弹
const impactHammer = (liftDepth = 0.25) => {
  const liftEnd = 0.35, strikeEnd = 0.6;
  return (k) => {
    if (k <= 0) return 0;
    if (k >= 1) return 1;
    if (k < liftEnd) {
      const t = k / liftEnd;
      return -liftDepth * Math.sin(t * Math.PI);
    }
    if (k < strikeEnd) {
      const t = (k - liftEnd) / (strikeEnd - liftEnd);
      return t * t;
    }
    const t = (k - strikeEnd) / (1 - strikeEnd);
    return 1 - 0.06 * Math.exp(-5 * t) * Math.sin(t * Math.PI * 4);
  };
};

// BounceDrop：下落 + 多次衰减反弹
const impactBounceDrop = (bounces = 3, rebound = 0.25) => (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  if (k < 0.4) {
    const t = k / 0.4;
    return t * t;
  }
  const t = (k - 0.4) / 0.6;
  const env = Math.exp(-2.5 * t);
  const wave = Math.abs(Math.sin(t * Math.PI * bounces));
  return 1 - env * wave * rebound;
};

// Slap：拍击——快速接触 + 短暂保持 + 快速撤回
const impactSlap = (contactAt = 0.3, holdRatio = 0.1) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  if (k < contactAt) {
    const t = k / contactAt;
    return t * t;
  }
  if (k < contactAt + holdRatio) return 1;
  const t = (k - contactAt - holdRatio) / (1 - contactAt - holdRatio);
  return (1 - t) * (1 - t);
};

// ArrowHit：箭中靶——匀速飞行 + 命中 + 插入后高频振颤衰减
const impactArrowHit = (impactAt = 0.5) => (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  if (k < impactAt) {
    const t = k / impactAt;
    return t * (0.7 + 0.3 * t);
  }
  const t = (k - impactAt) / (1 - impactAt);
  const env = Math.exp(-5 * t);
  const wave = Math.sin(t * Math.PI * 10);
  return 1 + 0.1 * env * wave;
};

// Shatter：撞碎——下落 + 撞击 + 能量 impulse 爆发 + 回到 1
const impactShatter = (impactAt = 0.55, burstAmp = 0.35) => {
  const sharp = 5;
  const tail = sharp * Math.exp(1 - sharp);
  return (k) => {
    if (k <= 0) return 0;
    if (k >= 1) return 1;
    if (k < impactAt) {
      const t = k / impactAt;
      return t * t;
    }
    const t = (k - impactAt) / (1 - impactAt);
    const h = sharp * t;
    const impulseVal = h * Math.exp(1 - h) - tail * t;
    return 1 + burstAmp * impulseVal;
  };
};

const Impact = Object.freeze({
  Rain:       impactRain(),
  Hammer:     impactHammer(),
  BounceDrop: impactBounceDrop(),
  Slap:       impactSlap(),
  ArrowHit:   impactArrowHit(),
  Shatter:    impactShatter(),
});

// ─── §16 Rhythm 节奏 / 冲击 ────────────────────────────────────────────────

// BassDrop：EDM 重拍——缓慢蓄力 → pause pre-drop → 瞬间掉到 1 → 持续并有微脉动
const rhythmBassDrop = () => (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  if (k < 0.4) {
    const t = k / 0.4;
    return 0.4 * Math.pow(t, 2.5);
  }
  if (k < 0.48) {
    const t = (k - 0.4) / 0.08;
    return 0.4 - 0.2 * t;
  }
  if (k < 0.52) {
    const t = (k - 0.48) / 0.04;
    return 0.2 + 0.8 * t;
  }
  const t = (k - 0.52) / 0.48;
  return 1 - 0.04 * Math.sin(t * Math.PI * 8) * (1 - t);
};

// PunchCombo：拳击三连击——jab-jab-cross，第三拳最重最宽
const rhythmPunchCombo = (peak = 0.4) => {
  const pattern = [
    { c: 0.15, w: 0.04,  a: 0.75 },
    { c: 0.35, w: 0.04,  a: 0.75 },
    { c: 0.7,  w: 0.055, a: 1.0  },
  ];
  return (k) => {
    if (k <= 0 || k >= 1) return 0;
    let sum = 0;
    for (const { c, w, a } of pattern) {
      sum += a * Math.exp(-((k - c) ** 2) / (2 * w * w));
    }
    return peak * sum;
  };
};

// Staccato：断奏——均匀节拍内 duty 占空比 sin 脉冲
const rhythmStaccato = (beats = 4, duty = 0.3) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  const beatLen = 1 / beats;
  const phase = (k / beatLen) - Math.floor(k / beatLen);
  if (phase > duty) return 0;
  const t = phase / duty;
  return Math.sin(t * Math.PI);
};

// Kick：极限单击——瞬速冲到 peak，之后强指数衰减
const rhythmKick = (peak = 1.2) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  if (k < 0.05) return peak * k / 0.05;
  const t = (k - 0.05) / 0.95;
  return peak * Math.exp(-4 * t);
};

// Crescendo：渐强——N 次高斯峰，间距递减、幅度递增
const rhythmCrescendo = (beats = 4) => {
  const centers = [];
  for (let i = 0; i < beats; i++) {
    const t = Math.pow((i + 1) / beats, 1.4);
    centers.push({ c: Math.max(0.05, t - 0.08), w: 0.03, a: (i + 1) / beats });
  }
  return (k) => {
    if (k <= 0 || k >= 1) return 0;
    let sum = 0;
    for (const { c, w, a } of centers) {
      sum += a * Math.exp(-((k - c) ** 2) / (2 * w * w));
    }
    return sum;
  };
};

// DunDunDun：悬疑递进——3 击幅度递增，末击更宽形成持续感
const rhythmDunDunDun = () => {
  const bell = (t, c, w) => Math.exp(-((t - c) ** 2) / (2 * w * w));
  return (k) => {
    if (k <= 0 || k >= 1) return 0;
    return 0.3 * bell(k, 0.15, 0.025)
         + 0.6 * bell(k, 0.35, 0.03)
         + 1.0 * bell(k, 0.68, 0.09);
  };
};

// BellToll：钟声——瞬间起振 + 指数衰减调幅的余弦振荡
const rhythmBellToll = (decay = 3, freq = 8) => {
  const strike = 0.05;
  return (k) => {
    if (k <= 0 || k >= 1) return 0;
    if (k < strike) return k / strike;
    const t = k - strike;
    return Math.exp(-decay * t) * Math.cos(freq * Math.PI * t);
  };
};

const Rhythm = Object.freeze({
  BassDrop:   rhythmBassDrop(),
  PunchCombo: rhythmPunchCombo(),
  Staccato:   rhythmStaccato(),
  Kick:       rhythmKick(),
  Crescendo:  rhythmCrescendo(),
  DunDunDun:  rhythmDunDunDun(),
  BellToll:   rhythmBellToll(),
});

// ─── §17 UI 反馈 ───────────────────────────────────────────────────────────

// ClickSnap：按钮点击——压下（负偏移）→ 回弹微过冲 → 归零
const uiClickSnap = (pressDepth = 0.3, reboundPeak = 0.1) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  if (k < 0.2) {
    const t = k / 0.2;
    return -pressDepth * Math.sin(t * Math.PI / 2);
  }
  if (k < 0.5) {
    const t = (k - 0.2) / 0.3;
    return -pressDepth + (pressDepth + reboundPeak) * (1 - Math.pow(1 - t, 3));
  }
  const t = (k - 0.5) / 0.5;
  return reboundPeak * Math.exp(-4 * t) * Math.cos(t * Math.PI * 3);
};

// HoverBloom：悬停高亮——梯形包络（快升 → plateau → 快降）
const uiHoverBloom = (riseRatio = 0.2, fallRatio = 0.3) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  if (k < riseRatio) {
    const t = k / riseRatio;
    return 1 - Math.pow(1 - t, 3);
  }
  if (k < 1 - fallRatio) return 1;
  const t = (k - (1 - fallRatio)) / fallRatio;
  return Math.pow(1 - t, 3);
};

// ErrorShake：错误反馈——方波化高频 shake
const uiErrorShake = (amplitude = 0.15, count = 5) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  const env = 1 - k;
  const raw = Math.sin(k * Math.PI * 2 * count);
  const clipped = Math.sign(raw) * Math.min(1, Math.abs(raw) * 1.8);
  return amplitude * env * clipped;
};

// SuccessPop：成功庆祝——瞬速 scale 到 1.2 → 阻尼余弦回到 1
const uiSuccessPop = (overshoot = 0.2) => (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  if (k < 0.4) {
    const t = k / 0.4;
    return (1 + overshoot) * (1 - Math.pow(1 - t, 2));
  }
  const t = (k - 0.4) / 0.6;
  return 1 + overshoot * Math.exp(-5 * t) * Math.cos(t * Math.PI * 3);
};

// RippleOut：Material 点击涟漪——早峰后淡出
const uiRippleOut = () => (k) => {
  if (k <= 0 || k >= 1) return 0;
  return 6.75 * k * Math.pow(1 - k, 2);
};

const UI = Object.freeze({
  ClickSnap:  uiClickSnap(),
  HoverBloom: uiHoverBloom(),
  ErrorShake: uiErrorShake(),
  SuccessPop: uiSuccessPop(),
  RippleOut:  uiRippleOut(),
});

// ─── §18 Magic 能量 / 魔法 ─────────────────────────────────────────────────

// ManaCharge：魔法蓄能——指数积蓄 + 高频 pulses
const magicManaCharge = () => (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  const base = (Math.exp(3 * k) - 1) / (Math.exp(3) - 1);
  const pulse = 0.04 * Math.sin(k * Math.PI * 8) * k;
  return base + pulse;
};

// SpellCast：施法——蓄能 + 瞬冲 1 + 拖尾衰减
const magicSpellCast = (chargeEnd = 0.4) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  if (k < chargeEnd) {
    const t = k / chargeEnd;
    return 0.3 * Math.pow(t, 2) * (1 + 0.2 * Math.sin(t * Math.PI * 6));
  }
  if (k < chargeEnd + 0.1) {
    const t = (k - chargeEnd) / 0.1;
    return 0.3 + 0.7 * t;
  }
  const t = (k - chargeEnd - 0.1) / (1 - chargeEnd - 0.1);
  return Math.exp(-2 * t) * (1 + 0.1 * Math.cos(t * Math.PI * 4));
};

// Teleport：瞬移——加速压缩 → 完全消失（平顶 1）→ 加速重现
const magicTeleport = () => (k) => {
  if (k <= 0 || k >= 1) return 0;
  if (k < 0.45) {
    const t = k / 0.45;
    return t * t * t;
  }
  if (k < 0.55) return 1;
  const t = (k - 0.55) / 0.45;
  return Math.pow(1 - t, 3);
};

// Shield：护盾——波纹扩散过冲到 1.2 → 稳定到 1 → 微脉动
const magicShield = () => (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  if (k < 0.3) {
    const t = k / 0.3;
    return 1.2 * (1 - Math.pow(1 - t, 2));
  }
  if (k < 0.6) {
    const t = (k - 0.3) / 0.3;
    return 1.2 - 0.2 * t;
  }
  const t = (k - 0.6) / 0.4;
  return 1 + 0.03 * Math.sin(t * Math.PI * 3);
};

// MagicAura：魔法光环——基频 + 2 次谐波 + 3 次泛音的正弦叠加
const magicAura = (peak = 0.15) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  const env = Math.sin(k * Math.PI);
  const fundamental = 0.6 * Math.sin(k * Math.PI * 2);
  const harmonic = 0.3 * Math.sin(k * Math.PI * 4 + 1);
  const overtone = 0.1 * Math.sin(k * Math.PI * 6 + 2);
  return peak * env * (fundamental + harmonic + overtone);
};

const Magic = Object.freeze({
  ManaCharge: magicManaCharge(),
  SpellCast:  magicSpellCast(),
  Teleport:   magicTeleport(),
  Shield:     magicShield(),
  MagicAura:  magicAura(),
});

// ─── §19 Animal 动物动作 ───────────────────────────────────────────────────

// CatPounce：猫扑击——蹲伏蓄力 + 起跳 + 空中抛物线 + 落地微压
const animalCatPounce = () => (k) => {
  if (k <= 0) return 0;
  if (k >= 1) return 1;
  if (k < 0.2) {
    const t = k / 0.2;
    return -0.2 * Math.sin(t * Math.PI);
  }
  if (k < 0.3) {
    const t = (k - 0.2) / 0.1;
    return 0.5 * t * t;
  }
  if (k < 0.8) {
    const t = (k - 0.3) / 0.5;
    return 0.5 + 0.5 * t + 0.2 * Math.sin(t * Math.PI);
  }
  const t = (k - 0.8) / 0.2;
  return 1 + 0.05 * Math.sin(t * Math.PI);
};

// BirdFlap：翅膀拍打——不对称基波（下扑快、上挥慢）+ sin 包络
const animalBirdFlap = (flaps = 4) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  const env = Math.sin(k * Math.PI);
  const phase = k * Math.PI * 2 * flaps;
  const wave = Math.sin(phase) - 0.3 * Math.sin(phase * 2);
  return 0.2 * env * wave;
};

// SnakeSlither：蛇蜿蜒——连续 S 波
const animalSnakeSlither = (waves = 3) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  const env = Math.sin(k * Math.PI);
  const wave = Math.sin(k * Math.PI * 2 * waves);
  return 0.2 * env * wave;
};

// ButterflyFlit：蝴蝶乱飞——seed 可复现的随机采样 + cubic 平滑插值
const animalButterflyFlit = (seed = 13) => {
  let s = seed;
  const rand = () => { s = (s * 9301 + 49297) % 233280; return s / 233280; };
  const samples = [];
  for (let i = 0; i <= 26; i++) samples.push(rand() - 0.5);
  return (k) => {
    if (k <= 0 || k >= 1) return 0;
    const env = Math.sin(k * Math.PI);
    const pos = k * 25;
    const idx = Math.floor(pos);
    const t = pos - idx;
    const smooth = t * t * (3 - 2 * t);
    const interp = samples[idx] + (samples[idx + 1] - samples[idx]) * smooth;
    return 0.3 * env * interp;
  };
};

// HorseGallop：马奔驰——每周期 4 蹄击地 + 空中相位间隙
const animalHorseGallop = (cycles = 3) => (k) => {
  if (k <= 0 || k >= 1) return 0;
  const env = Math.sin(k * Math.PI);
  const cyclePos = (k * cycles) - Math.floor(k * cycles);
  const bell = (c, w = 0.04) => Math.exp(-((cyclePos - c) ** 2) / (2 * w * w));
  return 0.25 * env * (bell(0.0) + bell(0.18) + bell(0.36) + bell(0.54));
};

const Animal = Object.freeze({
  CatPounce:     animalCatPounce(),
  BirdFlap:      animalBirdFlap(),
  SnakeSlither:  animalSnakeSlither(),
  ButterflyFlit: animalButterflyFlit(),
  HorseGallop:   animalHorseGallop(),
});

// ─── 导出（形态分类：Progress / Pulse / Wave） ─────────────────────────────
//
// 上方各主题常量（Physics / Motion / Step / Attention / Breath / Heart /
// MathExt / Explosion / Nature / Impact / Rhythm / UI / Magic / Animal）
// 及业界库 factory（libSpring / libSteps / libHeartBeat）仅作为
// "源池"使用，不再作为顶层导出；由下列 Progress / Pulse / Wave 三个按形态
// 分类的命名空间统一暴露。
//
// 通用 UI 柔化（Smooth / Bezier 两组共 6 条命名曲线）已整组移除——数值上
// 与原生 Sinusoidal/Quadratic/Cubic 等价；需定制贝塞尔请直接调用顶层
// cubicBezier('Material.Standard' | x1,y1,x2,y2) 工厂。

// Progress —— 单调或衰减至 1 的曲线（A→B 过渡）
const Progress = Object.freeze({
  // Physics：原生 + Spring（Framer Motion 参数化弹簧）
  Physics: Object.freeze({
    ...Physics,                         // SpringSoft / SpringStiff / DampedOscillation
    Spring:    libSpring(),             // Framer Motion 风格默认弹簧
  }),
  Motion,   // Anticipate / Overshoot110 / Overshoot125 / SnapBack / Swing
  // Step：固定段数实例 —— Steps4/6/8/12End 覆盖实用区间，无任意段数工厂
  Step: Object.freeze({
    ...Step,                            // Steps4End / Steps8End / Steps12End
    Steps6: libSteps(),
  }),
  Math: Object.freeze({
    Tremor:   MathExt.Tremor,
  }),
  Impact: Object.freeze({
    Rain:       Impact.Rain,
    Hammer:     Impact.Hammer,
    BounceDrop: Impact.BounceDrop,
    ArrowHit:   Impact.ArrowHit,
    Shatter:    Impact.Shatter,
  }),
  Rhythm: Object.freeze({
    BassDrop: Rhythm.BassDrop,
  }),
  UI: Object.freeze({
    SuccessPop: UI.SuccessPop,
  }),
  Magic: Object.freeze({
    ManaCharge: Magic.ManaCharge,
    Shield:     Magic.Shield,
  }),
  Animal: Object.freeze({
    CatPounce: Animal.CatPounce,
  }),
});

// Pulse —— 单次返零脉冲（f(0)=f(1)=0, 单主峰；reversals ≤ 2 为主）
const Pulse = Object.freeze({
  Attention: Object.freeze({
    Ping: Attention.Ping,
  }),
  Breath: Object.freeze({
    Deep: Breath.Deep,
    Sigh: Breath.Sigh,
  }),
  Heart: Object.freeze({
    Calm: Heart.Calm,
  }),
  Math: Object.freeze({
    JumpArc:        MathExt.JumpArc,                // 对称抛物 4k(1-k)
    BoomerangSharp: mathBoomerang(E.Cubic.In),      // 尖峰回程：缓→冲到峰→缓回（峰值锐利）
    BoomerangSoft:  mathBoomerang(E.Cubic.Out),     // 平顶回程：快→在峰上停留→快回（峰值平滑）
  }),
  Explosion: Object.freeze({
    Impulse:   Explosion.Impulse,
    Flash:     Explosion.Flash,
    Recoil:    Explosion.Recoil,
    Implosion: Explosion.Implosion,
  }),
  Impact: Object.freeze({
    Slap: Impact.Slap,
  }),
  Rhythm: Object.freeze({
    Kick: Rhythm.Kick,
  }),
  UI: Object.freeze({
    ClickSnap:  UI.ClickSnap,
    HoverBloom: UI.HoverBloom,
    RippleOut:  UI.RippleOut,
  }),
  Magic: Object.freeze({
    SpellCast: Magic.SpellCast,
    Teleport:  Magic.Teleport,
  }),
});

// Wave —— 周期多峰振荡（f(0)=f(1)=0, 多次反转）
const Wave = Object.freeze({
  Attention: Object.freeze({
    Wiggle: Attention.Wiggle,
    Strum:  Attention.Strum,
  }),
  Breath: Object.freeze({
    Normal:  Breath.Normal,
    Panting: Breath.Panting,
  }),
  Heart: Object.freeze({
    Excited: Heart.Excited,
    LubDub:  Heart.LubDub,
    Beat:    libHeartBeat(),   // 迁移自 Lib.HeartBeat
  }),
  Math: Object.freeze({
    Pendulum: MathExt.Pendulum,
  }),
  Nature,   // Wave / Flicker / Gust
  Rhythm: Object.freeze({
    PunchCombo: Rhythm.PunchCombo,
    Staccato:   Rhythm.Staccato,
    Crescendo:  Rhythm.Crescendo,
    DunDunDun:  Rhythm.DunDunDun,
    BellToll:   Rhythm.BellToll,
  }),
  UI: Object.freeze({
    ErrorShake: UI.ErrorShake,
  }),
  Magic: Object.freeze({
    MagicAura: Magic.MagicAura,
  }),
  Animal: Object.freeze({
    BirdFlap:      Animal.BirdFlap,
    SnakeSlither:  Animal.SnakeSlither,
    ButterflyFlit: Animal.ButterflyFlit,
    HorseGallop:   Animal.HorseGallop,
  }),
});

const customEasings = Object.freeze({
  makeOutIn,
  OutIn,
  Progress,
  Pulse,
  Wave,
  cubicBezier,
});

exports.customEasings = customEasings;
exports.default = customEasings;
