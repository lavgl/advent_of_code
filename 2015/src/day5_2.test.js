const { rule1Letters, rule2Letters } = require("./day5_2.bs")

test("rule 1", () => {
  expect(rule1Letters("qjhvhtzxzqqjkmpb")).toBe("qj")
  expect(rule1Letters("xxyxx")).toBe("xx")
  expect(rule1Letters("ieodomkazucvgmuy")).toBeUndefined()
});

test("rule 2", () => {
  expect(rule2Letters("qjhvhtzxzqqjkmpb")).toBe("hvh")
  expect(rule2Letters("xxyxx")).toBe("xyx")
  expect(rule2Letters("uurcxstgmygtbstg")).toBeUndefined()
})