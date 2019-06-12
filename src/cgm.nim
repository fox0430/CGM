type
  Vector = seq[float64]
  Matrix = seq[seq[float64]]

proc dot(a, b: Vector): float64 =
  for i in 0 ..< a.len: result = result + (a[i] * b[i])

proc tensorDot(a, b: Matrix): Matrix =
  for i in 0 ..< a.len:
    result.add(@[])
    for j in 0 ..< b.len:
      result[i].add(@[float64(0)])
      for k in 0 ..< b.len:
        result[i][j] = result[i][j] + (a[i][k] * b[k][j])

proc innerProduct(a, b: Vector): float64 =
  for i in 0 ..< a.len: result = result + a[i] * b[i]

proc `*`(a, b: Matrix): Matrix = return tensorDot(a, b)

proc `*`(a, b: Vector): float64 = return dot(a, b)

proc `*`(m: Matrix, v: Vector): Vector =
  for i in 0 ..< v.len:
    result.add(@[float64(0)])
    for j in 0 ..< m[i].len:
      result[i] = result[i] + (m[i][j] * v[i])

proc `*`(m: Vector, f: float64): Vector =
  for i in 0 ..< m.len: result.add(m[i] * f)

proc `+`(a, b: Matrix): Matrix =
  for i in 0 ..< a.len:
    result.add(@[])
    for j in 0 ..< a.len:
      result[i].add(a[i][j] + b[i][j])

proc `+`(a, b: Vector): Vector =
  for i in 0 ..< a.len: result.add(a[i] + b[i])

proc `+`(v: Vector, f: float64): Vector =
  for i in 0 ..< v.len: result.add(v[i] + f)

proc `-`(a, b: Matrix): Matrix =
  for i in 0 ..< a.len:
    result.add(@[])
    for j in 0 ..< a.len:
      result[i].add(a[i][j] - b[i][j])

proc `-`(a, b: Vector): Vector =
  for i in 0 ..< b.len:
    result.add(a[i] - b[i])

proc T(matrix: Matrix): Matrix =
  for i in 00 ..< matrix.len:
    result.add(@[])
    for j in 0 ..< matrix.len:
      result[i].add(matrix[j][i])

proc CGSolver(A: Matrix, b, x0: Vector): Vector =
  var
    alpha = float64(0)
    m = A.T * (A * x0 - b)
    t = -(innerProduct(m, A.T * (A * x0 - b))) / (innerProduct(m, A.T * A * m))
  result = x0 + m * t

  for i in 0 ..< 3:
    alpha = -(innerProduct(m, A.T * A * A.T * (A * result - b))) / (innerProduct(m, A.T * A * m))
    m = A.T * (A * result - b) + m * alpha
    t = -(innerProduct(m, A.T * (A * result - b))) / (innerProduct(m, A.T * A * m))
    result = result + m * t

when isMainModule:
  let A: Matrix = @[@[float64(1), float64(0), float64(0)], @[float64(0), float64(2), float64(0)], @[float64(0), float64(0), float64(1)]]
  let b: Vector = @[float64(4), float64(5), float64(6)]
  var x: Vector = @[float64(0), float64(0), float64(0)]
  echo CGSolver(A, b, x)
