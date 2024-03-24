open OUnit

let rec d x = function
    | `Int n -> `Int 0
    | `Var y -> `Int(if x = y then 1 else 0)
    | `Add(f, g) -> `Add(d x f, d x g)
    | `Mul(f, g) -> `Add(`Mul(f, d x g), `Mul(g, d x f))
    | `Pow(f, g) ->
        `Mul(`Pow(f, `Add(g, `Int(-1))),
             `Add(`Mul(g, d x f), `Mul(`Mul(f, `Ln f), d x g)))
    | `Ln f -> `Pow(f, `Int(-1))
    | `Sin f -> `Mul(d x f, `Cos f)
    | `Cos f -> `Mul(`Int(-1), `Mul(d x f, `Sin f))
    
let test_d_basic _ =
  (* Test case 1: Derivative of a constant (should be 0) *)
  let result1 = d "x" (`Int 5) in
  let expected_result1 = `Int 0 in
  assert_equal expected_result1 result1;

  (* Test case 2: Derivative of a variable with respect to itself (should be 1) *)
  let result2 = d "x" (`Var "x") in
  let expected_result2 = `Int 1 in
  assert_equal expected_result2 result2;

  (* Test case 3: Derivative of the sum of two variables *)
  let result3 = d "x" (`Add(`Var "x", `Var "y")) in
  let expected_result3 = `Add(`Int 1, `Int 0) in
  assert_equal expected_result3 result3
