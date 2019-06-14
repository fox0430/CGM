import math

type Matrix* = seq[seq[float64]]

proc vectorNorm*(m: Matrix): float64 =
  for i in 0 ..< m.len:
    result = result + m[i][0].abs
  result = sqrt(result)

proc `*`*(a, b: Matrix): Matrix =
  for i in 0 ..< a.len:
    result.add(@[])
    for j in 0 ..< b[0].len:
      result[i].add(@[float64(0)])
      for k in 0 ..< a[0].len:
        result[i][j] = result[i][j] + (a[i][k] * b[k][j])

proc `*`*(m: Matrix, f: float64): Matrix =
  for i in 0 ..< m.len:
    result.add(@[])
    for j in 0 ..< m[0].len:
      result[i].add(m[i][j] * f)

proc `+`*(a, b: Matrix): Matrix =
  for i in 0 ..< a.len:
    result.add(@[])
    for j in 0 ..< a[0].len:
      result[i].add(a[i][j] + b[i][j])

proc `-`*(a, b: Matrix): Matrix =
  for i in 0 ..< a.len:
    result.add(@[])
    for j in 0 ..< a[i].len:
      result[i].add(a[i][j] - b[i][j])

proc `/`*(a, b: Matrix): Matrix =
  for i in 0 ..< a.len:
    result.add(@[])
    for j in 0 ..< a[0].len:
      result[i].add(a[i][j] / b[i][j])

proc T*(m: Matrix): Matrix =
  for i in 0 ..< m[0].len:
    result.add(@[])
    for j in 0 ..< m.len:
      result[i].add(m[j][i])


