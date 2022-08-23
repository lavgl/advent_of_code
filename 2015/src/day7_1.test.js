const { Wire, Gate, lookup, parseLine, tryParseInt } = require("./day7.try")

test("tryParseInt", () => {
  expect(tryParseInt("123")).toBe(123)
  expect(tryParseInt("abc")).toBe("abc")
  expect(tryParseInt(null)).toBe(null)
  expect(tryParseInt(undefined)).toBe(undefined)
})

test("NOT gate", () => {
  Wire.make("a", 1);
  Gate.make("b", "NOT", "a")

  expect(lookup("b")).toBe(-2)
});

test("AND gate", () => {
  Wire.make("a", 1);
  Wire.make("b", 3)
  Gate.make("c", "AND", ["a", "b"])

  expect(lookup("c")).toBe(1)
})

test("parseLine", () => {
  expect(parseLine("NOT dq -> dr")).toEqual({ type: "GATE", op: "NOT", inputs: ["dq"], output: "dr"})
  expect(parseLine("kg OR kf -> kh")).toEqual({ type: "GATE", op: "OR", inputs: ["kg", "kf"], output: "kh"})
  expect(parseLine("44430 -> b")).toEqual({ type: "WIRE", op: undefined, inputs: [44430], output: "b"})
  expect(parseLine("lx -> a")).toEqual({ type: "WIRE", op: undefined, inputs: ["lx"], output: "a"})
});