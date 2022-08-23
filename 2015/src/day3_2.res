let load = () => {
    Node.Fs.readFileSync("./resources/day3.txt", #utf8)
}

module Coordinates = Belt.Id.MakeComparable({
    type t = (int, int)

    let cmp = (c1, c2) => Pervasives.compare(c1, c2)
})

let move = ((x, y), direction) => {
    switch direction {
        | "^" => (x, y + 1)
        | ">" => (x + 1, y)
        | "v" => (x, y - 1)
        | "<" => (x - 1, y)
        | _ => (x, y)
    }
}

let visitedHouses = (input) => {
    open Belt

    let initialCoords = (0, 0)
    let initialAcc =
    Set.make(~id=module(Coordinates))
    -> Set.add(initialCoords)

    input
    -> Js.String2.split("")
    -> Js.Array2.reduce(((santaCoords, roboSantaCoords, isSanta, acc), direction) => {
        let coords = if isSanta { santaCoords } else { roboSantaCoords }

        let newCoords = move(coords, direction)
        let newAcc = Set.add(acc, newCoords)

        if isSanta {
            (newCoords, roboSantaCoords, !isSanta, newAcc)
        } else {
            (santaCoords, newCoords, !isSanta, newAcc)
        }
    }, (initialCoords, initialCoords, true, initialAcc))
    -> ((_, _, _, set)) => Set.size(set)
}

let main = () => {
    let input = load()
    let result = visitedHouses(input)
    Js.log(result)
}

main()