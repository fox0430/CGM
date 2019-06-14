import math

type Matrix = seq[seq[float64]]

proc vectorNorm(m: Matrix): float64 =
  for i in 0 ..< m.len:
    result = result + m[i][0].abs
  result = sqrt(result)

proc `*`(a, b: Matrix): Matrix =
  for i in 0 ..< a.len:
    result.add(@[])
    for j in 0 ..< b[0].len:
      result[i].add(@[float64(0)])
      for k in 0 ..< a[0].len:
        result[i][j] = result[i][j] + (a[i][k] * b[k][j])

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

proc `-`(a, b: Matrix): Matrix =
  for i in 0 ..< a.len:
    result.add(@[])
    for j in 0 ..< a[i].len:
      result[i].add(a[i][j] - b[i][j])

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

  for i in 0 ..< 200:
    let
      a = ((r0.T * r0) / ((p.T * A) * p))[0][0]
      r1 = r0 - (A * a) * p
    x = x + p * a
    echo "Error: " & $r1.vectorNorm
    if r1.vectorNorm < 10e-10: return x
    else:
      let b = ((r1.T * r1) / ((r0.T * A) * p))
      p = r1 + p * b
      r0 = r1
  return x

when isMainModule:
  const A:Matrix = @[@[1'f64, 0'f64, 0'f64], @[0'f64, 2'f64, 0'f64], @[0'f64, 0'f64, 1'f64]]
  const b:Matrix = @[@[4'f64], @[5'f64], @[6'f64]]
  const x:Matrix = @[@[0'f64], @[0'f64], @[0'f64]]
  echo "Anser:" & $CGSolver(A, b, x )
