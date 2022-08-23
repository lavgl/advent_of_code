// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Belt_List = require("rescript/lib/js/belt_List.js");

function loadFile(param) {
  return Fs.readFileSync("./resources/day1.txt", "utf8");
}

function calculate(acc, ch) {
  if (ch === "(") {
    return acc + 1 | 0;
  } else if (ch === ")") {
    return acc - 1 | 0;
  } else {
    return acc;
  }
}

function parseNext(_acc, _s) {
  while(true) {
    var s = _s;
    var acc = _acc;
    if (!s) {
      return acc;
    }
    var t = s.tl;
    var h = s.hd;
    if (!t) {
      return calculate(acc, h);
    }
    _s = t;
    _acc = calculate(acc, h);
    continue ;
  };
}

function main(param) {
  var content = Fs.readFileSync("./resources/day1.txt", "utf8");
  var result = parseNext(0, Belt_List.fromArray(content.split("")));
  console.log(result);
  
}

main(undefined);

exports.loadFile = loadFile;
exports.calculate = calculate;
exports.parseNext = parseNext;
exports.main = main;
/*  Not a pure module */