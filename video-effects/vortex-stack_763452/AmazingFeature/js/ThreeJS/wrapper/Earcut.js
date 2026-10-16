/**
 * Earcut 三角化算法
 * 将任意多边形（包括带孔的多边形）三角化为三角形网格
 * 基于 Earcut 算法 (https://github.com/mapbox/earcut)
 */

/**
 * 主入口函数：对多边形进行三角化
 * @param {Array<number>} data - 顶点坐标的扁平数组 [x0,y0, x1,y1, x2,y2, ...]
 * @param {Array<number>} holeIndices - 每个孔的起始索引数组
 * @param {number} dim - 每个顶点的维度（默认为2）
 * @returns {Array<number>} 三角形索引数组，每3个索引构成一个三角形
 */
function earcut(data, holeIndices, dim) {
  dim = dim || 2;
  const hasHoles = holeIndices && holeIndices.length;
  const outerLen = hasHoles ? holeIndices[0] * dim : data.length;
  let outerNode = linkedList(data, 0, outerLen, dim, true);
  const triangles = [];

  if (!outerNode || outerNode.next === outerNode.prev) return triangles;

  // 如果有孔，需要消除孔
  if (hasHoles) outerNode = eliminateHoles(data, holeIndices, outerNode, dim);

  let minX, minY, maxX, maxY, x, y, invSize;

  // 如果顶点数量较多，使用 z-order 曲线优化
  if (data.length > 80 * dim) {
    minX = maxX = data[0];
    minY = maxY = data[1];

    for (let i = dim; i < outerLen; i += dim) {
      x = data[i];
      y = data[i + 1];
      if (x < minX) minX = x;
      if (y < minY) minY = y;
      if (x > maxX) maxX = x;
      if (y > maxY) maxY = y;
    }

    invSize = Math.max(maxX - minX, maxY - minY);
    invSize = invSize !== 0 ? 1 / invSize : 0;
  }

  earcutLinked(outerNode, triangles, dim, minX, minY, invSize);
  return triangles;
}

/**
 * 创建双向链表表示多边形
 */
function linkedList(data, start, end, dim, clockwise) {
  let i, last;

  if (clockwise === (signedArea(data, start, end, dim) > 0)) {
    for (i = start; i < end; i += dim) last = insertNode(i / dim, data[i], data[i + 1], last);
  } else {
    for (i = end - dim; i >= start; i -= dim) last = insertNode(i / dim, data[i], data[i + 1], last);
  }

  if (last && equals(last, last.next)) {
    removeNode(last);
    last = last.next;
  }

  return last;
}

/**
 * 消除孔，将孔与外轮廓连接
 */
function eliminateHoles(data, holeIndices, outerNode, dim) {
  const queue = [];
  let i, len, start, end, list;

  for (i = 0, len = holeIndices.length; i < len; i++) {
    start = holeIndices[i] * dim;
    end = i < len - 1 ? holeIndices[i + 1] * dim : data.length;
    list = linkedList(data, start, end, dim, false);
    if (list === list.next) list.steiner = true;
    queue.push(getLeftmost(list));
  }

  queue.sort(compareX);

  for (i = 0; i < queue.length; i++) {
    eliminateHole(queue[i], outerNode);
    outerNode = filterPoints(outerNode, outerNode.next);
  }

  return outerNode;
}

function compareX(a, b) {
  return a.x - b.x;
}

/**
 * 找到连接孔到外轮廓的桥接点
 */
function eliminateHole(hole, outerNode) {
  outerNode = findHoleBridge(hole, outerNode);
  if (outerNode) {
    const b = splitPolygon(outerNode, hole);
    filterPoints(filterPoints(b, b.next), b.next);
  }
}

/**
 * 找到从孔到外轮廓的桥接点
 */
function findHoleBridge(hole, outerNode) {
  let p = outerNode;
  const hx = hole.x;
  const hy = hole.y;
  let qx = -Infinity, m;

  do {
    if (hy <= p.y && hy >= p.next.y && p.next.y !== p.y) {
      const x = p.x + (hy - p.y) * (p.next.x - p.x) / (p.next.y - p.y);
      if (x <= hx && x > qx) {
        qx = x;
        if (x === hx) {
          if (hy === p.y) return p;
          if (hy === p.next.y) return p.next;
        }
        m = p.x < p.next.x ? p : p.next;
      }
    }
    p = p.next;
  } while (p !== outerNode);

  if (!m) return null;

  if (hx === qx) return m;

  const stop = m;
  const mx = m.x;
  const my = m.y;
  let tanMin = Infinity, tan;

  p = m;

  do {
    if (hx >= p.x && p.x >= mx && hx !== p.x &&
        pointInTriangle(hy < my ? hx : qx, hy, mx, my, hy < my ? qx : hx, hy, p.x, p.y)) {
      tan = Math.abs(hy - p.y) / (hx - p.x);

      if (locallyInside(p, hole) &&
          (tan < tanMin || (tan === tanMin && (p.x > m.x || (p.x === m.x && sectorContainsSector(m, p)))))) {
        m = p;
        tanMin = tan;
      }
    }

    p = p.next;
  } while (p !== stop);

  return m;
}

function sectorContainsSector(m, p) {
  return area(m.prev, m, p.prev) < 0 && area(p.next, m, m.next) < 0;
}

/**
 * 主三角化循环
 */
function earcutLinked(ear, triangles, dim, minX, minY, invSize, pass) {
  if (!ear) return;

  if (!pass && invSize) indexCurve(ear, minX, minY, invSize);

  let stop = ear, prev, next;

  while (ear.prev !== ear.next) {
    prev = ear.prev;
    next = ear.next;

    if (invSize ? isEarHashed(ear, minX, minY, invSize) : isEar(ear)) {
      triangles.push(prev.i, ear.i, next.i);
      removeNode(ear);
      ear = next.next;
      stop = next.next;
      continue;
    }

    ear = next;

    if (ear === stop) {
      if (!pass) {
        earcutLinked(filterPoints(ear), triangles, dim, minX, minY, invSize, 1);
      } else if (pass === 1) {
        ear = cureLocalIntersections(filterPoints(ear), triangles, dim);
        earcutLinked(ear, triangles, dim, minX, minY, invSize, 2);
      } else if (pass === 2) {
        splitEarcut(ear, triangles, dim, minX, minY, invSize);
      }
      break;
    }
  }
}

/**
 * 判断一个顶点是否为耳朵
 */
function isEar(ear) {
  const a = ear.prev;
  const b = ear;
  const c = ear.next;

  if (area(a, b, c) >= 0) return false;

  let p = ear.next.next;

  while (p !== ear.prev) {
    if (pointInTriangle(a.x, a.y, b.x, b.y, c.x, c.y, p.x, p.y) && area(p.prev, p, p.next) >= 0) {
      return false;
    }
    p = p.next;
  }

  return true;
}

function isEarHashed(ear, minX, minY, invSize) {
  const a = ear.prev;
  const b = ear;
  const c = ear.next;

  if (area(a, b, c) >= 0) return false;

  const minTX = a.x < b.x ? (a.x < c.x ? a.x : c.x) : (b.x < c.x ? b.x : c.x);
  const minTY = a.y < b.y ? (a.y < c.y ? a.y : c.y) : (b.y < c.y ? b.y : c.y);
  const maxTX = a.x > b.x ? (a.x > c.x ? a.x : c.x) : (b.x > c.x ? b.x : c.x);
  const maxTY = a.y > b.y ? (a.y > c.y ? a.y : c.y) : (b.y > c.y ? b.y : c.y);

  const minZ = zOrder(minTX, minTY, minX, minY, invSize);
  const maxZ = zOrder(maxTX, maxTY, minX, minY, invSize);

  let p = ear.prevZ;
  let n = ear.nextZ;

  while (p && p.z >= minZ && n && n.z <= maxZ) {
    if (p !== ear.prev && p !== ear.next && pointInTriangle(a.x, a.y, b.x, b.y, c.x, c.y, p.x, p.y) &&
        area(p.prev, p, p.next) >= 0) return false;
    p = p.prevZ;

    if (n !== ear.prev && n !== ear.next && pointInTriangle(a.x, a.y, b.x, b.y, c.x, c.y, n.x, n.y) &&
        area(n.prev, n, n.next) >= 0) return false;
    n = n.nextZ;
  }

  while (p && p.z >= minZ) {
    if (p !== ear.prev && p !== ear.next && pointInTriangle(a.x, a.y, b.x, b.y, c.x, c.y, p.x, p.y) &&
        area(p.prev, p, p.next) >= 0) return false;
    p = p.prevZ;
  }

  while (n && n.z <= maxZ) {
    if (n !== ear.prev && n !== ear.next && pointInTriangle(a.x, a.y, b.x, b.y, c.x, c.y, n.x, n.y) &&
        area(n.prev, n, n.next) >= 0) return false;
    n = n.nextZ;
  }

  return true;
}

/**
 * 治愈局部自相交
 */
function cureLocalIntersections(start, triangles, dim) {
  let p = start;
  do {
    const a = p.prev;
    const b = p.next.next;

    if (!equals(a, b) && intersects(a, p, p.next, b) && locallyInside(a, b) && locallyInside(b, a)) {
      triangles.push(a.i, p.i, b.i);
      removeNode(p);
      removeNode(p.next);
      p = start = b;
    }
    p = p.next;
  } while (p !== start);

  return filterPoints(p);
}

/**
 * 分割多边形并继续三角化
 */
function splitEarcut(start, triangles, dim, minX, minY, invSize) {
  let a = start;
  do {
    let b = a.next.next;
    while (b !== a.prev) {
      if (a.i !== b.i && isValidDiagonal(a, b)) {
        let c = splitPolygon(a, b);
        a = filterPoints(a, a.next);
        c = filterPoints(c, c.next);
        earcutLinked(a, triangles, dim, minX, minY, invSize);
        earcutLinked(c, triangles, dim, minX, minY, invSize);
        return;
      }
      b = b.next;
    }
    a = a.next;
  } while (a !== start);
}

/**
 * 使用 z-order 曲线为顶点建立索引
 */
function indexCurve(start, minX, minY, invSize) {
  let p = start;
  do {
    if (p.z === null) p.z = zOrder(p.x, p.y, minX, minY, invSize);
    p.prevZ = p.prev;
    p.nextZ = p.next;
    p = p.next;
  } while (p !== start);

  p.prevZ.nextZ = null;
  p.prevZ = null;

  sortLinked(p);
}

/**
 * 使用归并排序对链表排序
 */
function sortLinked(list) {
  let i, p, q, e, tail, numMerges, pSize, qSize, inSize = 1;

  do {
    p = list;
    list = null;
    tail = null;
    numMerges = 0;

    while (p) {
      numMerges++;
      q = p;
      pSize = 0;
      for (i = 0; i < inSize; i++) {
        pSize++;
        q = q.nextZ;
        if (!q) break;
      }
      qSize = inSize;

      while (pSize > 0 || (qSize > 0 && q)) {
        if (pSize !== 0 && (qSize === 0 || !q || p.z <= q.z)) {
          e = p;
          p = p.nextZ;
          pSize--;
        } else {
          e = q;
          q = q.nextZ;
          qSize--;
        }

        if (tail) tail.nextZ = e;
        else list = e;

        e.prevZ = tail;
        tail = e;
      }

      p = q;
    }

    tail.nextZ = null;
    inSize *= 2;

  } while (numMerges > 1);

  return list;
}

/**
 * z-order 值计算
 */
function zOrder(x, y, minX, minY, invSize) {
  x = 32767 * (x - minX) * invSize;
  y = 32767 * (y - minY) * invSize;

  x = (x | (x << 8)) & 0x00FF00FF;
  x = (x | (x << 4)) & 0x0F0F0F0F;
  x = (x | (x << 2)) & 0x33333333;
  x = (x | (x << 1)) & 0x55555555;

  y = (y | (y << 8)) & 0x00FF00FF;
  y = (y | (y << 4)) & 0x0F0F0F0F;
  y = (y | (y << 2)) & 0x33333333;
  y = (y | (y << 1)) & 0x55555555;

  return x | (y << 1);
}

/**
 * 获取最左边的顶点
 */
function getLeftmost(start) {
  let p = start;
  let leftmost = start;
  do {
    if (p.x < leftmost.x || (p.x === leftmost.x && p.y < leftmost.y)) leftmost = p;
    p = p.next;
  } while (p !== start);
  return leftmost;
}

/**
 * 判断点是否在三角形内
 */
function pointInTriangle(ax, ay, bx, by, cx, cy, px, py) {
  return (cx - px) * (ay - py) - (ax - px) * (cy - py) >= 0 &&
         (ax - px) * (by - py) - (bx - px) * (ay - py) >= 0 &&
         (bx - px) * (cy - py) - (cx - px) * (by - py) >= 0;
}

/**
 * 判断对角线是否有效
 */
function isValidDiagonal(a, b) {
  return a.next.i !== b.i && a.prev.i !== b.i && !intersectsPolygon(a, b) &&
         (locallyInside(a, b) && locallyInside(b, a) && middleInside(a, b) &&
          (area(a.prev, a, b.prev) || area(a, b.prev, b)) || equals(a, b) && area(a.prev, a, a.next) > 0 && area(b.prev, b, b.next) > 0);
}

/**
 * 计算三角形面积
 */
function area(p, q, r) {
  return (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y);
}

/**
 * 判断两点是否相等
 */
function equals(p1, p2) {
  return p1.x === p2.x && p1.y === p2.y;
}

/**
 * 判断两条线段是否相交
 */
function intersects(p1, q1, p2, q2) {
  const o1 = sign(area(p1, q1, p2));
  const o2 = sign(area(p1, q1, q2));
  const o3 = sign(area(p2, q2, p1));
  const o4 = sign(area(p2, q2, q1));

  if (o1 !== o2 && o3 !== o4) return true;

  if (o1 === 0 && onSegment(p1, p2, q1)) return true;
  if (o2 === 0 && onSegment(p1, q2, q1)) return true;
  if (o3 === 0 && onSegment(p2, p1, q2)) return true;
  if (o4 === 0 && onSegment(p2, q1, q2)) return true;

  return false;
}

/**
 * 判断点 q 是否在线段 p-r 上
 */
function onSegment(p, q, r) {
  return q.x <= Math.max(p.x, r.x) && q.x >= Math.min(p.x, r.x) &&
         q.y <= Math.max(p.y, r.y) && q.y >= Math.min(p.y, r.y);
}

function sign(num) {
  return num > 0 ? 1 : num < 0 ? -1 : 0;
}

/**
 * 判断对角线是否与多边形相交
 */
function intersectsPolygon(a, b) {
  let p = a;
  do {
    if (p.i !== a.i && p.next.i !== a.i && p.i !== b.i && p.next.i !== b.i &&
        intersects(p, p.next, a, b)) return true;
    p = p.next;
  } while (p !== a);

  return false;
}

/**
 * 判断对角线是否在多边形内部
 */
function locallyInside(a, b) {
  return area(a.prev, a, a.next) < 0 ?
    area(a, b, a.next) >= 0 && area(a, a.prev, b) >= 0 :
    area(a, b, a.prev) < 0 || area(a, a.next, b) < 0;
}

/**
 * 判断对角线中点是否在多边形内部
 */
function middleInside(p, q) {
  let a = p;
  let inside = false;
  const px = (p.x + q.x) / 2;
  const py = (p.y + q.y) / 2;
  do {
    const sx = a.x;
    const sy = a.y;
    const ex = a.next.x;
    const ey = a.next.y;
    if (((sy > py) !== (ey > py)) && (px < (ex - sx) * (py - sy) / (ey - sy) + sx)) inside = !inside;
    a = a.next;
  } while (a !== p);

  return inside;
}

/**
 * 在两个顶点之间分割多边形
 */
function splitPolygon(a, b) {
  const a2 = new Node(a.i, a.x, a.y);
  const b2 = new Node(b.i, b.x, b.y);
  const an = a.next;
  const bp = b.prev;

  a.next = b;
  b.prev = a;

  a2.next = an;
  an.prev = a2;

  b2.next = a2;
  a2.prev = b2;

  bp.next = b2;
  b2.prev = bp;

  return b2;
}

/**
 * 插入新节点
 */
function insertNode(i, x, y, last) {
  const p = new Node(i, x, y);

  if (!last) {
    p.prev = p;
    p.next = p;
  } else {
    p.next = last.next;
    p.prev = last;
    last.next.prev = p;
    last.next = p;
  }
  return p;
}

/**
 * 移除节点
 */
function removeNode(p) {
  p.next.prev = p.prev;
  p.prev.next = p.next;

  if (p.prevZ) p.prevZ.nextZ = p.nextZ;
  if (p.nextZ) p.nextZ.prevZ = p.prevZ;
}

/**
 * 节点类
 */
function Node(i, x, y) {
  this.i = i;
  this.x = x;
  this.y = y;
  this.prev = null;
  this.next = null;
  this.z = null;
  this.prevZ = null;
  this.nextZ = null;
  this.steiner = false;
}

/**
 * 计算多边形的有向面积
 */
function signedArea(data, start, end, dim) {
  let sum = 0;
  for (let i = start, j = end - dim; i < end; i += dim) {
    sum += (data[j] - data[i]) * (data[i + 1] + data[j + 1]);
    j = i;
  }
  return sum;
}

/**
 * 过滤重复点
 */
function filterPoints(start, end) {
  if (!start) return start;
  if (!end) end = start;

  let p = start, again;
  do {
    again = false;

    if (!p.steiner && (equals(p, p.next) || area(p.prev, p, p.next) === 0)) {
      removeNode(p);
      p = end = p.prev;
      if (p === p.next) break;
      again = true;
    } else {
      p = p.next;
    }
  } while (again || p !== end);

  return end;
}

exports.earcut = earcut;



