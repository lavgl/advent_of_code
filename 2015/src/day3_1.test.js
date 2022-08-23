const { visitedHouses } = require("./day3_1.bs")

test("visitedHouses", () => {
    const input1 = ">>><<<";
    expect(visitedHouses(input1)).toBe(4);

    const input2 = ">";
    expect(visitedHouses(input2)).toBe(2);

    const input3 = "^>v<";
    expect(visitedHouses(input3)).toBe(4);

    const input4 = "^v^v^v^v^v";
    expect(visitedHouses(input4)).toBe(2);
});