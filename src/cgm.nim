import math

type
  Vector = seq[float64]
  Matrix = seq[seq[float64]]

proc vectorNorm(m: Matrix): float64 =
  for i in 0 ..< m.len:
    result = result + m[i][0].abs
  result = sqrt(result)

proc dot(a, b: Vector): float64 =
  for i in 0 ..< a.len: result = result + (a[i] * b[i])

proc tensorDot(a, b: Matrix): Matrix =
  for i in 0 ..< a.len:
    result.add(@[])
    for j in 0 ..< b[0].len:
      result[i].add(@[float64(0)])
      for k in 0 ..< a[0].len:
        result[i][j] = result[i][j] + (a[i][k] * b[k][j])

proc innerProduct(a, b: Vector): float64 =
  for i in 0 ..< a.len: result = result + a[i] * b[i]

proc `*`(a, b: Matrix): Matrix = return tensorDot(a, b)

proc `*`(a, b: Vector): float64 = return dot(a, b)

proc `*`(m: Matrix, v: Vector): Vector =
  for i in 0 ..< v.len:
    result.add(@[0'f64])
    for j in 0 ..< m[i].len:
      result[i] = result[i] + (m[i][j] * v[i])

proc `*`(m: Vector, f: float64): Vector =
  for i in 0 ..< m.len: result.add(m[i] * f)

proc `*`(m: Matrix, f: float64): Matrix =
  for i in 0 ..< m.len:
    result.add(@[])
    for j in 0 ..< m[0].len:
      result[i].add(m[i][j] * f)

proc `+`(a, b: Matrix): Matrix =
  for i in 0 ..< a.len:
    result.add(@[])
    for j in 0 ..< a[0].len:
      result[i].add(a[i][j] + b[i][j])

proc `+`(a, b: Vector): Vector =
  for i in 0 ..< a.len: result.add(a[i] + b[i])

proc `+`(v: Vector, f: float64): Vector =
  for i in 0 ..< v.len: result.add(v[i] + f)

proc `-`(a, b: Matrix): Matrix =
  for i in 0 ..< a.len:
    result.add(@[])
    for j in 0 ..< a[i].len:
      result[i].add(a[i][j] - b[i][j])

proc `-`(a, b: Vector): Vector =
  for i in 0 ..< b.len:
    result.add(a[i] - b[i])

proc `/`(a, b: Matrix): Matrix =
  for i in 0 ..< a.len:
    result.add(@[])
    for j in 0 ..< a[0].len:
      result[i].add(a[i][j] / b[i][j])

proc T(m: Matrix): Matrix =
  for i in 0 ..< m[0].len:
    result.add(@[])
    for j in 0 ..< m.len:
      result[i].add(m[j][i])

proc CGSolver(A, b, x0: Matrix): Matrix =
  var
    x = x0
    r0 = b - A * x0
    p = r0

  for i in 0 ..< 100:
    var a = ((r0.T * r0) / ((p.T * A) * p))[0][0]
    x = x + p * a
    var r1 = r0 - (A * a) * p
    echo r1.vectorNorm
    if r1.vectorNorm < 10e-10: return x
    else:
      let b = ((r1.T * r1) / ((r0.T * A) * p))
      p = r1 + p * b
      r0 = r1

when isMainModule:
  let A: Matrix = @[@[1'f64, 0'f64, 0'f64], @[0'f64, 2'f64, 0'f64], @[0'f64, 0'f64, 1'f64]]
  #let b: Vector = @[4'f64, 5'f64, 6'f64]
  let b: Matrix = @[@[4'f64], @[5'f64], @[6'f64]]
  #var x: Vector = @[0'f64, 0'f64, 0'f64]
  var x:Matrix = @[@[0'f64], @[0'f64], @[0'f64]]
  echo CGSolver(A, b, x )
