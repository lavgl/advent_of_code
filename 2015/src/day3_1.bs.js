// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Belt_Id = require("rescript/lib/js/belt_Id.js");
var Belt_Set = require("rescript/lib/js/belt_Set.js");
var Caml_obj = require("rescript/lib/js/caml_obj.js");

function load(param) {
  return Fs.readFileSync("./resources/day3.txt", "utf8");
}

var cmp = Caml_obj.caml_compare;

var Coordinates = Belt_Id.MakeComparable({
      cmp: cmp
    });

function visitedHouses(input) {
  var initialCoords = [
    0,
    0
  ];
  var initialAcc = Belt_Set.add(Belt_Set.make(Coordinates), initialCoords);
  var param = input.split("").reduce((function (param, direction) {
          var match = param[0];
          var y = match[1];
          var x = match[0];
          var newCoords;
          switch (direction) {
            case "<" :
                newCoords = [
                  x - 1 | 0,
                  y
                ];
                break;
            case ">" :
                newCoords = [
                  x + 1 | 0,
                  y
                ];
                break;
            case "^" :
                newCoords = [
                  x,
                  y + 1 | 0
                ];
                break;
            case "v" :
                newCoords = [
                  x,
                  y - 1 | 0
                ];
                break;
            default:
              newCoords = [
                x,
                y
              ];
          }
          return [
                  newCoords,
                  Belt_Set.add(param[1], newCoords)
                ];
        }), [
        initialCoords,
        initialAcc
      ]);
  return Belt_Set.size(param[1]);
}

function main(param) {
  var input = Fs.readFileSync("./resources/day3.txt", "utf8");
  var result = visitedHouses(input);
  console.log(result);
  
}

main(undefined);

exports.load = load;
exports.Coordinates = Coordinates;
exports.visitedHouses = visitedHouses;
exports.main = main;
/* Coordinates Not a pure module */
