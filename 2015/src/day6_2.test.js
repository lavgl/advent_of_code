const { parseInput, Grid, setupLights } = require("./day6_2.bs")

describe("full grid test", () => {
  const makeTest = (input, gridSize, expected) => {
    test(input, () => {
      let grid = Grid.make(gridSize)
      const cmd = parseInput(input)
      setupLights(grid, cmd)
      expect(Grid.totalBrightness(grid)).toBe(expected)
    })
  }

  makeTest("turn on 0,0 through 0,0", 3, 1)
  makeTest("toggle 0,0 through 999,999", 1000, 2000000)
})