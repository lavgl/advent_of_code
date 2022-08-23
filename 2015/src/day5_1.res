@@warning("-8")

let load = () => {
  Node.Fs.readFileSync("./resources/day5.txt", #utf8)
}

let listFromString = str =>
str
->  Js.String2.split("")
-> Belt.List.fromArray

let rec innerCountVowels = (input, count) => {
  switch input {
    | list{} => count
    | list{h, ...tail} => {
      if Js.String.includes(h, "aeiou") {
        innerCountVowels(tail, count + 1)
      } else {
        innerCountVowels(tail, count)
      }
    }
  }
}

let countVowels = innerCountVowels(_, 0)

let rule1 = str => {
  let vowels = str
  -> listFromString
  -> countVowels

  vowels >= 3
}

let rule2 = str => {
  let list1 = listFromString(str)
  let list2 = list1 -> Belt.List.drop(1) -> (Some(x)) => x

  Belt.List.some2(
    list1,
    list2,
    (a, b) => a == b
  )
}

let rule3 = str => {
  open Js.Array2

  not(["ab", "cd", "pq", "xy"] -> some(subs => Js.String2.includes(str, subs)))
}

let isNice = str => {
  let r1 = rule1(str)
  let r2 = rule2(str)
  let r3 = rule3(str)

  r1 && r2 && r3
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