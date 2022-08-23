const fs = require('fs')

const load = () => {
  return fs.readFileSync("./resources/day7.txt", "utf8")
}

const tryParseInt = (maybeInt) => {
  const parsed = parseInt(maybeInt, 10);
  return isNaN(parsed) ? maybeInt : parsed
}

let wires = new Map()

const cacheResult = (id, res) => {
  wires.set(id, { inputs: [res]})
}

const lookup = (idOrValue) => {
  console.log('looking up', idOrValue)
  debugger
  if (typeof idOrValue == "number") {
    return idOrValue
  }

  const id = idOrValue;

  const v = wires.get(id);

  const ops = {
    NOT: (a) => ~a,
    OR: (a, b) => a | b,
    AND: (a, b) => a & b,
    RSHIFT: (a, b) => a >> b,
    LSHIFT: (a, b) => a << b
  };

  const op = ops[v.op];

  if (v.op == 'NOT') {
    const res = op(lookup(v.inputs[0]))
    cacheResult(id, res);
    return res;
  } else if (op !== undefined) {
    const res = op(lookup(v.inputs[0]), lookup(v.inputs[1]))
    cacheResult(id, res);
    return res;
  } else {
    const res = lookup(v.inputs[0])
    cacheResult(id, res);
    return res
  }
}

const normalize = (inputs) => {
  if (Array.isArray(inputs)) {
    return inputs;
  } else {
    return [inputs]
  }
}

const Wire = {
  make: (id, input) => {
    const wire = {
      inputs: normalize(input)
    };
    wires.set(id, wire)
  }
}

const Gate = {
  make: (output, op, inputs) => {
    const gate = {
      op, inputs: normalize(inputs)
    }
    wires.set(output, gate)
  }
}

const parseLine = (line) => {
  const res = /^(?:(?:(\w+ )?(AND|OR|NOT|RSHIFT|LSHIFT) (\w+))|([\d|\w]+)) -> (\w+)$/.exec(line);

  if (!res) {
    return
  }

  const [_, input1, op, input2, wireInput, output] = res;

  const inputs = [input1, input2, wireInput]
    .filter(x => x)
    .map(x => x.trim())
    .map(tryParseInt);

  return {
    type: op ? 'GATE' : 'WIRE',
    op: op,
    inputs,
    output
  }
}

const parseInput = (input) => {
  return input.split("\n").map(parseLine).filter(x => x)
}

const init = (input) => {
  input.forEach(x => {
    if (x.type === 'GATE') {
      Gate.make(x.output, x.op, x.inputs)
    } else {
      Wire.make(x.output, x.inputs)
    }
  })
}

const main = () => {
  const input = parseInput(load())

  init(input);

  const a = lookup("a")

  wires = new Map();
  const input2 = [...input, { type: 'WIRE', inputs: [a], output: 'b'}];

  init(input2);

  const a2 = lookup("a");
  console.log(a2)

}

main()



module.exports = {
  Wire,
  Gate,
  lookup,
  parseLine,
  tryParseInt
}