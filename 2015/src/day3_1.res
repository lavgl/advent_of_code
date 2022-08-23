let load = () => {
    Node.Fs.readFileSync("./resources/day3.txt", #utf8)
}

module Coordinates = Belt.Id.MakeComparable({
    type t = (int, int)

    let cmp = (c1, c2) => Pervasives.compare(c1, c2)
})

let visitedHouses = (input) => {
    open Belt

    let initialCoords = (0, 0)
    let initialAcc =
    Set.make(~id=module(Coordinates))
    -> Set.add(initialCoords)

    input
    -> Js.String2.split("")
    -> Js.Array2.reduce((((x, y), acc), direction) => {
        let newCoords = 
        switch direction {
            | "^" => (x, y + 1)
            | ">" => (x + 1, y)
            | "v" => (x, y - 1)
            | "<" => (x - 1, y)
            | _ => (x, y)
        }

        (newCoords, Set.add(acc, newCoords))
    }, (initialCoords, initialAcc))
    -> ((_, set)) => Set.size(set)
}

let main = () => {
    let input = load()
    let result = visitedHouses(input)
    Js.log(result)
}

main()