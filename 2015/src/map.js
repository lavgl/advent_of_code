const map = (fn, array) => {
  const [h, ...tail] = array;
  const value = fn(h);
  if (tail.length === 0) {
    return [value]
  }
  return [value].concat(map(fn, tail))
};


module.exports = {
  map
}