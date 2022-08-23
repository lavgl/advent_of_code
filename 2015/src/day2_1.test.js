const { parseInput, parseDimensions, $$process } = require('./day2_1.bs')

test("parseDimensions", () => {
    expect(parseDimensions("2x2x2")).toEqual([2,2,2]);
});

test("parseInput", () => {
    expect(parseInput("2x2x2")).toEqual([[2,2,2]])
    expect(parseInput("2x2x2\n3x3x3")).toEqual([[2,2,2], [3,3,3]]);
});
    
test("process", () => {
    expect($$process("2x3x4")).toBe(58)
})