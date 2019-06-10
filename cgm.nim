proc calcInnerProduct(a, b: seq[float64]): float64 =
  assert a.len == b.len
  for i in 0 ..< a.len: result = result + (a[i] * b[i])

proc calcInnerProduct(a, b: seq[seq[float64]]): seq[seq[float64]] =
  for i in 0 ..< a.len: assert a[i].len == b.len

  for i in 0 ..< a.len:
    result.add(@[])
    for j in 0 ..< b.len:
      result[i].add(@[float64(0)])
      for k in 0 ..< b.len:
        result[i][j] = result[i][j] + (a[i][k] * b[k][j])

proc solver[T](A: seq[seq[float64]], b: seq[float64], x: T) = discard

when isMainModule:
  ## test calcInnerProduct1
  let A = @[float64(1), float64(2), float64(3)]
  let B = @[float64(2), float64(4), float64(6)]
  echo calcInnerProduct(A, B)

  ## test calcInnerProduct1
  let C = @[@[float64(1), float64(1)], @[float64(2), float64(2)], @[float64(3), float64(3)]]
  let D = @[@[float64(1), float64(2)], @[float64(3), float64(4)]]
  echo calcInnerProduct(C, D)

  let x0 = @[@[float64(0)], @[float64(0)], @[float64(0)]]
  solver(C, B, x0)
