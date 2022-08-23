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
    let areas = [l * w, w * h, h * l]
    let min = Js.Math.minMany_int(areas)
    areas[0] * 2 + areas[1] * 2 + areas[2] * 2 + min
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