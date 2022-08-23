let loadFile = () => {
    Node.Fs.readFileSync("./resources/day1.txt", #utf8) 
}

let calculate = (acc: int, ch: string) => {
    if ch == "(" { acc + 1 } else if ch == ")" { acc - 1 } else { acc }
}

let rec parseNext = acc => i => s => {
    if acc == -1 {
        Js.log(i)
    }
    switch s {
        | list{} => acc
        | list{h} => calculate(acc, h)
        | list{h, ...t} => parseNext(calculate(acc, h), i + 1, t)
    }
}

let main = () => {
    let content = loadFile()
    let result = parseNext(0, 0, Belt_List.fromArray(Js.String.split("", content)))
    Js.log(result)
}

main()