const { map } = require('./map');

test("map", () => {
  expect(map(x => x + 1, [1,2,3])).toEqual([2,3,4])
})