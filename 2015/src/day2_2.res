@@warning("-8")

let load = () => {
    Node.Fs.readFileSync("./resources/day2.txt", #utf8)
}

let parseDimensions = (line: string) => {
    line
    -> Js.String2.split("x")
    -> Js.Array2.map(Belt.Int.fromString)
}

let parseInput = (content: string) => {
    content
    -> Js.String2.split("\n")
    -> Js.Array2.map(parseDimensions)
}

let calculate = ([Some(l), Some(w), Some(h)]) => {
    let dims = [l, w, h] -> Belt.SortArray.Int.stableSort
    dims[0] * 2 + dims[1] * 2 + l * w * h
}

let add = (a, b) => a + b

let process = (input) => {
    open Js.Array2

    input 
    -> parseInput
    -> map(calculate)
    -> reduce(add, 0)
}

let main = () => {
    let result = process(load())
    Js.log(result)
}

main()