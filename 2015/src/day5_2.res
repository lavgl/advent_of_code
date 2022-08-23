@@warning("-8")

let load = () => {
  Node.Fs.readFileSync("./resources/day5.txt", #utf8)
}

let listFromString = str =>
str
-> Js.String2.split("")
-> Belt.List.fromArray

let listToString = list =>
list 
-> Belt.List.toArray 
-> Js.Array2.joinWith("")


let rec checkRule1WithRest = (pair, rest) => {
  let currCompTo = rest -> Belt.List.take(2)
  let nextRest = rest -> Belt.List.drop(1)

  switch (currCompTo, nextRest) {
    | (Some(pair2), _) if pair == pair2 => Some(pair)
    | (Some(_), Some(nextRest)) => checkRule1WithRest(pair, nextRest)
    | _ => None
  }
}

let checkRule1Since = (str, i) => {
  let next = str -> listFromString -> Belt.List.drop(i)
  let (pair, rest) = switch next {
    | Some(li) => (Belt.List.take(li, 2), Belt.List.drop(li, 2))
    | None => (None, None)
  } 

  switch (pair, rest) {
    | (Some(pair), Some(rest)) => checkRule1WithRest(pair, rest)
    | _ => None
  }
}

let rec rule1Letters = (str, currIndex) => {
    if currIndex < Js.String.length(str) {
      let res = checkRule1Since(str, currIndex)
      switch res {
        | None => rule1Letters(str, currIndex + 1)
        | res => res -> Belt.Option.map(listToString)
      }
    } else {
      None
    }
}


let rule1 = str => {
  switch rule1Letters(str, 0) {
    | Some(_) => true
    | None => false
  }
}

let rec checkRule2For = (l: list<string>) => {
  open Belt

  let current = List.take(l, 3)
  let rest = List.drop(l, 1)

  switch (current, rest) {
    | (Some (list{a,_,c}), _) as kek if a == c => {
      let (Some(l), _) = kek
      Some(listToString(l))
    }
    | (_, Some(rest)) => checkRule2For(rest)
    | _ => None
  }

}

let rule2Letters = (s: string) => 
s -> listFromString -> checkRule2For


let rule2 = str => {
  switch rule2Letters(str) {
    | Some(_) => true
    | None => false
  }
}


let isNice = str => {
  let r1 = rule1(str)
  let r2 = rule2(str)

  r1 && r2
}

let parseInput = input => 
input 
-> Js.String2.split("\n") 
-> Js.Array2.filter(x => x != "")

let main = () => {
  let input = load() -> parseInput
  let result =  input -> Js.Array2.filter(isNice) -> Js.Array2.length

  Js.log(result)
}

main()