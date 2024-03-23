# Short & interesting OCaml code
This OCaml code defines a function d for symbolic differentiation, capable of computing the derivative of various mathematical expressions represented as an algebraic data type. The function takes two arguments: x, the variable with respect to which differentiation is performed, and the expression to be differentiated.

The expressions supported include integers (Int), variables (Var), addition (Add), multiplication (Mul), exponentiation (Pow), natural logarithm (Ln), sine (Sin), and cosine (Cos). The code implements the rules of differentiation for each expression type recursively.
For example, differentiation of an addition (Add) involves differentiating each operand separately and summing the results. Similarly, differentiation of multiplication (Mul) employs the product rule, while differentiation of exponentiation (Pow) utilizes the chain rule.
The result of differentiation is returned as another algebraic data type representing the derivative expression.

## Example by calculating differentiation of x^x
The differentiation of ( x^x ) through the function is represented as an algebraic data type expression. When evaluated in the OCaml REPL (utop), the expression for the derivative is:

```
`Mul
  (`Pow (`Var "x", `Add (`Var "x", `Int (-1))),
   `Add
     (`Mul (`Var "x", `Int 1), `Mul (`Mul (`Var "x", `Ln (`Var "x")), `Int 1)))
```
This result breaks down as follows:

The derivative of ( x^x ) involves the product of two terms.
- The first term corresponds to the power rule: ( x^{x-1} ).
- The second term represents the sum of two sub-terms:
  - The first sub-term is the product rule applied to ( x \cdot 1 ).
  - The second sub-term involves the product of ( x ) with the natural logarithm of ( x ), multiplied by 1. which simplifies to x^(x - 1)*(x×1 + x×ln(x)×1) = x^x(1 + ln(x)) So, the result captures the derivative of ( x^x ) with respect to ( x ) using the implemented symbolic differentiation rules.

![Screenshot 2024-03-24](https://github.com/Siddhi-agg/OCaml-Challenge/assets/101979598/56d2dbdb-86bc-4e6c-ae42-fa07767189f6)

 
