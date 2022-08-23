
// given number 1. find md5, check is it starts with 00000
@module external md5: string => string = "md5"

let input = "yzbqklnj"

let rec run = (input, i) => {
  let s =  Js.Int.toString(i) -> Js.String.concat(input)
  let hash = md5(s)

  if Js.String.startsWith("00000", hash) {
    (true, i)
  } else {
    run(input, i + 1)
  }
}

let main = () => {
  let result = run(input, 1)
  Js.log(result)
}

main()