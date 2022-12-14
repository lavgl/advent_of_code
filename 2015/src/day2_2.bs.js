// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Belt_Int = require("rescript/lib/js/belt_Int.js");
var Caml_array = require("rescript/lib/js/caml_array.js");
var Belt_SortArrayInt = require("rescript/lib/js/belt_SortArrayInt.js");

function load(param) {
  return Fs.readFileSync("./resources/day2.txt", "utf8");
}

function parseDimensions(line) {
  return line.split("x").map(Belt_Int.fromString);
}

function parseInput(content) {
  return content.split("\n").map(parseDimensions);
}

function calculate(param) {
  if (param.length === 3) {
    var l = param[0];
    if (l !== undefined) {
      var w = param[1];
      if (w !== undefined) {
        var h = param[2];
        if (h !== undefined) {
          var dims = Belt_SortArrayInt.stableSort([
                l,
                w,
                h
              ]);
          return ((Caml_array.get(dims, 0) << 1) + (Caml_array.get(dims, 1) << 1) | 0) + Math.imul(Math.imul(l, w), h) | 0;
        }
        
      }
      
    }
    
  }
  throw {
        RE_EXN_ID: "Match_failure",
        _1: [
          "day2_2.res",
          19,
          16
        ],
        Error: new Error()
      };
}

function add(a, b) {
  return a + b | 0;
}

function $$process(input) {
  return parseInput(input).map(calculate).reduce(add, 0);
}

function main(param) {
  var result = $$process(Fs.readFileSync("./resources/day2.txt", "utf8"));
  console.log(result);
  
}

main(undefined);

exports.load = load;
exports.parseDimensions = parseDimensions;
exports.parseInput = parseInput;
exports.calculate = calculate;
exports.add = add;
exports.$$process = $$process;
exports.main = main;
/*  Not a pure module */
