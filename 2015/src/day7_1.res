let load = () => {
  Node.Fs.readFileSync("./resources/day7_test.txt", #utf8)
}

// let unpackResult = (result) => {

// }

let parseLine = (line) => {
  let res = %re("/^(\w+ )?(AND|OR|NOT|RSHIFT|LSHIFT) (\w+) -> (\w+)$/")
  -> Js.Re.exec_(line) 
  // -> Belt.Option.flatMap(unpackResult)
  Js.log(res)
}

let parseInput = (input) => {
  true
}

module rec Wire = {
  type t = { id: string, inputs: array< }

}
and

module Gate = {
  type kind = And | Or | Not | Rshift | Lshift
  type op = BinaryOp((int,int) => int) | UnaryOp((int) => int)
  
  type t = { kind: kind, op: op, inputs: array<int>}

  let make = (~kind: kind, ~op: op): t => {
    { kind, op, inputs: []}
  }

  let \"And" = make(~kind=And, ~op=BinaryOp(Pervasives.land))
  let \"Or" = make(~kind=Or, ~op=BinaryOp(Pervasives.lor))
  let \"Not" = make(~kind=Not, ~op=UnaryOp(Pervasives.lnot))
  let \"Rshift" = make(~kind=Rshift, ~op=BinaryOp(Pervasives.lsr))
  let \"Lshift" = make(~kind=Lshift, ~op=BinaryOp(Pervasives.lsr))
}


let test = () => {
  let g = Gate.And
  let g = Gate.Or
  let g = Gate.Not
  let g = Gate.Rshift
  let g = Gate.Lshift
}



let main = () => {
  true
}

// main()