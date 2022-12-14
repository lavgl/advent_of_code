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

function move(param, direction) {
  var y = param[1];
  var x = param[0];
  switch (direction) {
    case "<" :
        return [
                x - 1 | 0,
                y
              ];
    case ">" :
        return [
                x + 1 | 0,
                y
              ];
    case "^" :
        return [
                x,
                y + 1 | 0
              ];
    case "v" :
        return [
                x,
                y - 1 | 0
              ];
    default:
      return [
              x,
              y
            ];
  }
}

function visitedHouses(input) {
  var initialCoords = [
    0,
    0
  ];
  var initialAcc = Belt_Set.add(Belt_Set.make(Coordinates), initialCoords);
  var param = input.split("").reduce((function (param, direction) {
          var isSanta = param[2];
          var roboSantaCoords = param[1];
          var santaCoords = param[0];
          var coords = isSanta ? santaCoords : roboSantaCoords;
          var newCoords = move(coords, direction);
          var newAcc = Belt_Set.add(param[3], newCoords);
          if (isSanta) {
            return [
                    newCoords,
                    roboSantaCoords,
                    !isSanta,
                    newAcc
                  ];
          } else {
            return [
                    santaCoords,
                    newCoords,
                    !isSanta,
                    newAcc
                  ];
          }
        }), [
        initialCoords,
        initialCoords,
        true,
        initialAcc
      ]);
  return Belt_Set.size(param[3]);
}

function main(param) {
  var input = Fs.readFileSync("./resources/day3.txt", "utf8");
  var result = visitedHouses(input);
  console.log(result);
  
}

main(undefined);

exports.load = load;
exports.Coordinates = Coordinates;
exports.move = move;
exports.visitedHouses = visitedHouses;
exports.main = main;
/* Coordinates Not a pure module */
