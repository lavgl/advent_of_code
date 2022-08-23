@@warning("-8")

let load = () => {
  Node.Fs.readFileSync("./resources/day6.txt", #utf8)
}

module Grid = {
  type t = array<bool>

  let make = (size): t => Belt.Array.make(size * size, false)
  let size = (grid: t) => {
    grid 
    -> Js.Array.length 
    -> Belt.Int.toFloat
    -> Js.Math.sqrt
    -> Belt.Float.toInt
  } 
  let litCount = (grid: t) => {
    Js.Array2.reduce(grid, (acc, el) => { el ? acc + 1 : acc }, 0)
  }
}

type commandKind = TurnOn | TurnOff | Toggle

type command = {
  kind: commandKind,
  from: (int, int),
  to: (int, int)
}

let extractCommand = (result) => {
  let convert = (input: Js.nullable<string>): option<int> => {
    input
    -> Js.Nullable.toOption
    -> Belt.Option.flatMap(x => Belt.Int.fromString(x))
  }

  let [_, cmdKind, xFrom, yFrom, xTo, yTo] = result

  let cmdKind = switch Js.Nullable.toOption(cmdKind) {
    | Some("turn off") => TurnOff
    | Some("turn on") => TurnOn
    | Some("toggle") => Toggle
  }

  let from = switch (convert(xFrom), convert(yFrom)) {
    | (Some(x), Some(y)) => (x, y)
  }

  let to = switch (convert(xTo), convert(yTo)) {
    | (Some(x), Some(y)) => (x, y)
  }

  {
    kind: cmdKind,
    from: from,
    to: to
  }
}

let operateOnCell = (grid: Grid.t, (x,y), cmdKind) => {
  let i = y * Grid.size(grid) + x
  let set = Belt.Array.set(grid, i, _)
  let _ = switch cmdKind {
  | TurnOn => set(true)
  | TurnOff => set(false)
  | Toggle => set(!grid[i])
  }
}

let operate = (grid, command) => {
  let { kind, from, to } = command

  let (xFrom, yFrom) = from
  let (xTo, yTo) = to

  for x in xFrom to xTo {
    for y in yFrom to yTo {
      operateOnCell(grid, (x,y), kind)
    }
  }
}

let setupLights = (grid, commands) => {
  Js.Array2.forEach(commands, 
  cmd => switch cmd { 
    | Some(cmd) => operate(grid, cmd)
    | None => ()})

}

let parseLine = line => {
  %re("/^([\w ]+) (\d+),(\d+) through (\d+),(\d+)$/")
  -> Js.Re.exec_(line)
  -> Belt.Option.map(Js.Re.captures)
  -> Belt.Option.map(extractCommand)
}

let parseInput = input => {
  input
  -> Js.String2.split("\n")
  -> Js.Array2.map(parseLine)
}

let main = () => {
  let commands = parseInput(load())
  let grid = Grid.make(1000) 
  setupLights(grid, commands)
  let res = Grid.litCount(grid)
  
  Js.log(res)
}

main()