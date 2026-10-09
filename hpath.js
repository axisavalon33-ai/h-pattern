/*
 * Shared H-pattern timing for both tablets (visitor + audience).
 *
 * The bee's position is a pure function of Date.now(): every device that
 * loads this file and has its clock set automatically will show the same
 * point of the cycle at the same moment. No network link is needed.
 *
 * Route:  centre -> right -> up-right -> down-right -> centre
 *                -> left  -> up-left  -> down-left  -> centre
 * 40 s per cycle. 2 s hold at each of the six end points (12 s),
 * the remaining 28 s is split between the eight moves in proportion
 * to their length, so the bee travels at a steady pace.
 *
 * Coordinates are normalised: x and y run from -1 to 1,
 * x = +1 is the visitor's right, y = -1 is up.
 */
(function (global) {
  'use strict';

  var CYCLE_MS = 40000;
  var HOLD_MS = 2000;

  var POINTS = {
    C:  { x:  0, y:  0 },
    R:  { x:  1, y:  0 },
    UR: { x:  1, y: -1 },
    DR: { x:  1, y:  1 },
    L:  { x: -1, y:  0 },
    UL: { x: -1, y: -1 },
    DL: { x: -1, y:  1 }
  };

  var ROUTE = ['C', 'R', 'UR', 'DR', 'C', 'L', 'UL', 'DL', 'C'];

  function dist(a, b) {
    var p = POINTS[a], q = POINTS[b];
    return Math.sqrt((p.x - q.x) * (p.x - q.x) + (p.y - q.y) * (p.y - q.y));
  }

  // Build the timeline once.
  var holds = 0, totalLen = 0, i;
  for (i = 0; i < ROUTE.length - 1; i++) {
    totalLen += dist(ROUTE[i], ROUTE[i + 1]);
    if (ROUTE[i + 1] !== 'C') holds++;
  }
  var moveMs = CYCLE_MS - holds * HOLD_MS;

  var STEPS = [];
  var t = 0;
  for (i = 0; i < ROUTE.length - 1; i++) {
    var from = ROUTE[i], to = ROUTE[i + 1];
    var dur = moveMs * dist(from, to) / totalLen;
    STEPS.push({ kind: 'move', from: from, to: to, start: t, end: t + dur });
    t += dur;
    if (to !== 'C') {
      STEPS.push({ kind: 'hold', at: to, start: t, end: t + HOLD_MS });
      t += HOLD_MS;
    }
  }
  STEPS[STEPS.length - 1].end = CYCLE_MS; // absorb floating-point rounding

  // Gentle ease-in / ease-out on every move.
  function ease(p) {
    return p * p * (3 - 2 * p);
  }

  /**
   * Where is the bee at time `now` (ms since epoch, default Date.now())?
   * Returns { x, y, t, kind, pose, from, to, sinceStart, untilEnd, prevHold }
   *   t          ms into the 40 s cycle
   *   kind       'move' or 'hold'
   *   pose       end point name while holding (e.g. 'UR'), otherwise null
   *   prevHold   while moving: the end point just left (or null)
   */
  function state(now) {
    if (now === undefined) now = Date.now();
    var tc = ((now % CYCLE_MS) + CYCLE_MS) % CYCLE_MS;
    var idx = 0;
    while (idx < STEPS.length - 1 && tc >= STEPS[idx].end) idx++;
    var s = STEPS[idx];
    var res = {
      t: tc,
      kind: s.kind,
      pose: null,
      from: null,
      to: null,
      prevHold: null,
      sinceStart: tc - s.start,
      untilEnd: s.end - tc
    };
    if (s.kind === 'hold') {
      res.pose = s.at;
      res.x = POINTS[s.at].x;
      res.y = POINTS[s.at].y;
    } else {
      var p = ease(Math.min(1, Math.max(0, (tc - s.start) / (s.end - s.start))));
      var a = POINTS[s.from], b = POINTS[s.to];
      res.from = s.from;
      res.to = s.to;
      res.x = a.x + (b.x - a.x) * p;
      res.y = a.y + (b.y - a.y) * p;
      var prev = STEPS[idx - 1];
      if (prev && prev.kind === 'hold') res.prevHold = prev.at;
    }
    return res;
  }

  global.HPath = {
    CYCLE_MS: CYCLE_MS,
    HOLD_MS: HOLD_MS,
    POINTS: POINTS,
    ROUTE: ROUTE,
    STEPS: STEPS,
    state: state
  };
})(this);
