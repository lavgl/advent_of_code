const { visitedHouses } = require("./day3_2.bs")

test("visitedHouses", () => {
    const input1 = "^v";
    expect(visitedHouses(input1)).toBe(3);

    const input3 = "^>v<";
    expect(visitedHouses(input3)).toBe(3);

    const input4 = "^v^v^v^v^v";
    expect(visitedHouses(input4)).toBe(11);
});