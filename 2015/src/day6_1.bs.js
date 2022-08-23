// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Belt_Int = require("rescript/lib/js/belt_Int.js");
var Belt_Array = require("rescript/lib/js/belt_Array.js");
var Caml_array = require("rescript/lib/js/caml_array.js");
var Belt_Option = require("rescript/lib/js/belt_Option.js");
var Caml_option = require("rescript/lib/js/caml_option.js");

function load(param) {
  return Fs.readFileSync("./resources/day6.txt", "utf8");
}

function make(size) {
  return Belt_Array.make(Math.imul(size, size), false);
}

function size(grid) {
  return Math.sqrt(grid.length) | 0;
}

function litCount(grid) {
  return grid.reduce((function (acc, el) {
                if (el) {
                  return acc + 1 | 0;
                } else {
                  return acc;
                }
              }), 0);
}

var Grid = {
  make: make,
  size: size,
  litCount: litCount
};

function extractCommand(result) {
  var convert = function (input) {
    return Belt_Option.flatMap((input == null) ? undefined : Caml_option.some(input), Belt_Int.fromString);
  };
  if (result.length !== 6) {
    throw {
          RE_EXN_ID: "Match_failure",
          _1: [
            "day6_1.res",
            38,
            6
          ],
          Error: new Error()
        };
  }
  var cmdKind = result[1];
  var xFrom = result[2];
  var yFrom = result[3];
  var xTo = result[4];
  var yTo = result[5];
  var cmdKind$1;
  if (cmdKind == null) {
    throw {
          RE_EXN_ID: "Match_failure",
          _1: [
            "day6_1.res",
            40,
            16
          ],
          Error: new Error()
        };
  }
  switch (cmdKind) {
    case "toggle" :
        cmdKind$1 = /* Toggle */2;
        break;
    case "turn off" :
        cmdKind$1 = /* TurnOff */1;
        break;
    case "turn on" :
        cmdKind$1 = /* TurnOn */0;
        break;
    default:
      throw {
            RE_EXN_ID: "Match_failure",
            _1: [
              "day6_1.res",
              40,
              16
            ],
            Error: new Error()
          };
  }
  var match = convert(xFrom);
  var match$1 = convert(yFrom);
  var from;
  if (match !== undefined) {
    if (match$1 !== undefined) {
      from = [
        match,
        match$1
      ];
    } else {
      throw {
            RE_EXN_ID: "Match_failure",
            _1: [
              "day6_1.res",
              46,
              13
            ],
            Error: new Error()
          };
    }
  } else {
    throw {
          RE_EXN_ID: "Match_failure",
          _1: [
            "day6_1.res",
            46,
            13
          ],
          Error: new Error()
        };
  }
  var match$2 = convert(xTo);
  var match$3 = convert(yTo);
  var to;
  if (match$2 !== undefined) {
    if (match$3 !== undefined) {
      to = [
        match$2,
        match$3
      ];
    } else {
      throw {
            RE_EXN_ID: "Match_failure",
            _1: [
              "day6_1.res",
              50,
              11
            ],
            Error: new Error()
          };
    }
  } else {
    throw {
          RE_EXN_ID: "Match_failure",
          _1: [
            "day6_1.res",
            50,
            11
          ],
          Error: new Error()
        };
  }
  return {
          kind: cmdKind$1,
          from: from,
          to: to
        };
}

function operateOnCell(grid, param, cmdKind) {
  var i = Math.imul(param[1], Math.sqrt(grid.length) | 0) + param[0] | 0;
  switch (cmdKind) {
    case /* TurnOn */0 :
        Belt_Array.set(grid, i, true);
        break;
    case /* TurnOff */1 :
        Belt_Array.set(grid, i, false);
        break;
    case /* Toggle */2 :
        Belt_Array.set(grid, i, !Caml_array.get(grid, i));
        break;
    
  }
  
}

function operate(grid, command) {
  var to = command.to;
  var yTo = to[1];
  var from = command.from;
  var yFrom = from[1];
  var kind = command.kind;
  for(var x = from[0] ,x_finish = to[0]; x <= x_finish; ++x){
    for(var y = yFrom; y <= yTo; ++y){
      operateOnCell(grid, [
            x,
            y
          ], kind);
    }
  }
  
}

function setupLights(grid, commands) {
  commands.forEach(function (cmd) {
        if (cmd !== undefined) {
          return operate(grid, cmd);
        }
        
      });
  
}

function parseLine(line) {
  return Belt_Option.map(Belt_Option.map(Caml_option.null_to_opt(/^([\w ]+) (\d+),(\d+) through (\d+),(\d+)$/.exec(line)), (function (prim) {
                    return prim;
                  })), extractCommand);
}

function parseInput(input) {
  return input.split("\n").map(parseLine);
}

function main(param) {
  var commands = parseInput(Fs.readFileSync("./resources/day6.txt", "utf8"));
  var grid = make(1000);
  setupLights(grid, commands);
  var res = litCount(grid);
  console.log(res);
  
}

main(undefined);

exports.load = load;
exports.Grid = Grid;
exports.extractCommand = extractCommand;
exports.operateOnCell = operateOnCell;
exports.operate = operate;
exports.setupLights = setupLights;
exports.parseLine = parseLine;
exports.parseInput = parseInput;
exports.main = main;
/*  Not a pure module */
