import math
import calcutils

proc CGSolver(A: Matrix, b: Vector, x: var Vector): Vector =
  var
    r = b - A * x
    p = r
    x1: Vector

  for i in 0 ..< 10000000:
    let
      Ap = A * p
      alpha = (r * r) / (p * Ap)

    x1 = x + alpha * p

    let r1 = r - alpha * Ap

    let error = r1.vectorNorm / b.vectorNorm
    #echo error
    if error < 10e-10: return x1

    let beta = (r1 * r1) / (r * r)
    p = r1 + beta * p

    r = r1
    x = x1

  return x1

proc initMatrixA(alpha, beta: float32, n: int): Matrix =
  for i in 0 ..< n - 1:
    result.add(newSeq[float32](n - 1))
    if i == 0:
      result[i][0] = alpha
      result[i][1] = beta
    else:
      result[i][i - 1] = beta
      if i < n - 1: result[i][i] = alpha
      if i + 1 < n - 1: result[i][i + 1] = beta

  #for i in 0 ..< result.len: echo result[i]

proc initVectorb(beta: float32, n: int): Vector =
  result = newSeq[float32](n - 1)
  for i in 0 ..< n - 1:
    if i == 0 or i == n - 2: result[i] = 4
    else: result[i] = 5

  # echo result

when isMainModule:
  const n = 1000

  let
    #deltaX = PI / 2 / n
    A = initMatrixA(3, 1, n)
    b = initVectorb(4, n)
  var x: Vector = newSeq[float32](n - 1)

  let ans = CGSolver(A, b, x)

  echo "ans"
  echo ans
