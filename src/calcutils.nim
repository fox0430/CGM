import math

type
  Matrix* = seq[seq[float32]]
  Vector* = seq[float32]

proc `*`*(m: Matrix, v: Vector): Vector =
  for i in 0 ..< v.len:
    result.add(0'f32)
    for j in 0 ..< v.len: result[i] = result[i] + m[i][j] * v[j]

proc `-`*(v1, v2: Vector): Vector =
  for i in 0 ..< v1.len: result.add(v1[i] - v2[i])

proc `*`*(v1, v2: Vector): float32 =
  for i in 0 ..< v1.len: result = result + v1[i] * v2[i]

proc `*`*(f: float32, v: Vector): Vector =
  for i in 0 ..< v.len: result.add(f * v[i])

proc `+`*(v1, v2: Vector): Vector =
  for i in 0 ..< v1.len: result.add(v1[i] + v2[i])

proc vectorNorm*(v: Vector): float32 =
  for i in 0 ..< v.len: result = result + v[i] * v[i]
  return sqrt(result)
