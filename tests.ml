open OUnit

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

let test_d_power _ =
  (* Test case 4: Derivative of x^2 *)
  let result4 = d "x" (`Mul(`Var "x", `Var "x")) in
  let expected_result4 = `Add (`Mul (`Var "x", `Int 1), `Mul (`Var "x", `Int 1)) in
  assert_equal expected_result4 result4;

  (* Test case 5: Derivative of x^x *)
  let result5 = d "x" (`Pow(`Var "x", `Var "x")) in
  let expected_result5 = 
    `Mul(
      `Pow(`Var "x", `Add(`Var "x", `Int (-1))),
      `Add(
        `Mul(`Var "x", `Int 1), `Mul(`Mul(`Var "x", `Ln(`Var "x")), `Int 1)))
  in
  assert_equal expected_result5 result5

let test_d_trigonometric _ =
  (* Test case 6: Derivative of sin(x) *)
  let result6 = d "x" (`Sin (`Var "x")) in
  let expected_result6 = `Mul (`Int 1, `Cos (`Var "x")) in
  assert_equal expected_result6 result6;

  (* Test case 7: Derivative of cos(x) *)
  let result7 = d "x" (`Cos (`Var "x")) in
  let expected_result7 = `Mul (`Int (-1), `Mul (`Int 1, `Sin (`Var "x"))) in
  assert_equal expected_result7 result7

let test_d_logarithmic _ =
  (* Test case 8: Derivative of ln(x) *)
  let result8 = d "x" (`Ln (`Var "x")) in
  let expected_result8 = `Mul(`Pow (`Var "x", `Int(-1)), `Int 1) in
  assert_equal expected_result8 result8;

  (* Test case 9: Derivative of ln(x^x) *)
  let result9 = d "x" (`Ln (`Pow(`Var "x", `Var "x"))) in
  let expected_result9 = 
  `Mul
  (`Pow(`Pow(`Var "x",`Var "x"), `Int (-1)),
  `Mul(
      `Pow(`Var "x", `Add(`Var "x", `Int (-1))),
      `Add(
        `Mul(`Var "x", `Int 1),
        `Mul(`Mul(`Var "x", `Ln(`Var "x")), `Int 1))))
  in
  assert_equal expected_result9 result9

  let suite =
    "suite" >::: [
      "test_d_basic" >:: test_d_basic;
      "test_d_power" >:: test_d_power;
      "test_d_trigonometric" >:: test_d_trigonometric;
      "test_d_logarithmic" >:: test_d_logarithmic;
    ]
    |> run_test_tt
