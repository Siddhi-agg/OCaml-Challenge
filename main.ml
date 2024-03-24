let rec d x = function
  | `Int n -> `Int 0
  | `Var y -> `Int(if x = y then 1 else 0)
  | `Add(f, g) -> `Add(d x f, d x g)
  | `Mul(f, g) -> `Add(`Mul(f, d x g), `Mul(g, d x f))
  | `Pow(f, g) ->
      `Mul(`Pow(f, `Add(g, `Int(-1))),
           `Add(`Mul(g, d x f), `Mul(`Mul(f, `Ln f), d x g)))
  | `Ln f -> `Mul(`Pow(f, `Int(-1)), d x f)
  | `Sin f -> `Mul(d x f, `Cos f)
  | `Cos f -> `Mul(`Int(-1), `Mul(d x f, `Sin f))
