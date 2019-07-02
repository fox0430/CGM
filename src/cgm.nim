import os, math, strformat, times
import calcutils

type CalcError = object
  n: int
  error: float64

proc writeCalcErrorLog(errors: seq[CalcError]) =
  echo "Write log file..."
  var f = open("calcErrorLog.txt", FileMode.fmWrite)
  for i in 0 ..< errors.len: f.writeLine($errors[i].n & " " & $errors[i].error)

## Conjugate gradient method
proc CGM(A: Matrix, b: Vector, x: var Vector): Vector =
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
    if error < 10e-10: return x1

    let beta = (r1 * r1) / (r * r)
    p = r1 + beta * p

    r = r1
    x = x1

  return x1

proc initMatrixA(alpha, beta: float64, n: int): Matrix =
  for i in 0 ..< n - 1:
    result.add(newSeq[float64](n - 1))
    if i == 0:
      result[i][0] = alpha
      result[i][1] = beta
    else:
      result[i][i - 1] = beta
      if i < n - 1: result[i][i] = alpha
      if i + 1 < n - 1: result[i][i + 1] = beta

proc initVectorb(beta: float64, n: int): Vector =
  result = newSeq[float64](n - 1)
  result[n - 2] = - beta

proc calcCGMError(ans: seq[float64], deltaX: float64): float64 =
  result = abs(ans[0] - sin(deltaX)) / abs(sin(deltaX))
  for j in 1 ..< ans.len:
    let error1 = abs(ans[j] - sin(float(j + 1) * deltaX)) / sin(float(j + 1) * deltaX)
    if result < error1: result = error1

when isMainModule:
  const nSeq = @[10, 50, 100, 500, 1000]
  var errors: seq[CalcError]

  for i in 0 ..< nSeq.len:

    let
      n = nSeq[i]
      deltaX = PI / 2'f64 / float64(n)
      alpha = - (2'f64 / deltaX^2) + 1'f64
      beta = 1'f64 / deltaX^2
      A = initMatrixA(alpha, beta, n)
      b = initVectorb(beta, n)
    var x: Vector = newSeq[float64](n - 1)

    let time = cpuTime()
    let ans = CGM(A, b, x)
    echo "Time taken: ", cpuTime() - time
    
    let
      error = calcCGMError(ans, deltaX)
      calcError = CalcError(n: n, error: error)

    echo fmt"Exit n: {n}"
    errors.add(calcError)

  #writeCalcErrorLog(errors)
