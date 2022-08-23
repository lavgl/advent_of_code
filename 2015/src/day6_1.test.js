const { parseLine, parseInput, setupLights, Grid, operateOnCell } = require("./day6_1.bs")

test("parseLine", () => {
  expect(parseLine("turn off 660,55 through 986,197")).toEqual({ kind: 1, from: [660, 55], to: [986, 197] })
  expect(parseLine("toggle 0,0 through 0,3")).toEqual({ kind: 2, from: [0,0], to: [0,3] })
  expect(parseLine("turn on 11,11 through 12,12")).toEqual({ kind: 0, from: [11, 11], to: [12, 12]})
})

test("operateOnCell", () => {
  let grid = Grid.make(10)
  operateOnCell(grid, [0,5], 0)
  expect(Grid.litCount(grid)).toBe(1)
  operateOnCell(grid, [0,4], 0)
  expect(Grid.litCount(grid)).toBe(2)
})

describe("full grid test", () => {
  const makeTest = (input, gridSize, expected) => {
    test(input, () => {
      let grid = Grid.make(gridSize)
      const cmd = parseInput(input)
      setupLights(grid, cmd)
      expect(Grid.litCount(grid)).toBe(expected)
    })
  }

  makeTest("turn on 0,0 through 2,2", 10, 9)
  makeTest("turn on 0,0 through 999,999", 1000, 1000 * 1000)
  makeTest("toggle 0,0 through 999,0", 1000, 1000)
})