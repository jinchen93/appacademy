const Utils = {
  inherits (childClass, parentClass) {
    childClass.prototype = Object.create(parentClass.prototype);
    childClass.prototype.constructor = childClass;
  },

  randomVec (length) {
    const deg = 2 * Math.PI * Math.random();
    return this.scale([Math.sin(deg), Math.cos(deg)], length);
  },

  scale (vec, m) {
    return [vec[0] * m, vec[1] * m];
  },

  distance (pos1, pos2) {
    let xSquared = Math.pow(pos1[0] - pos2[0], 2);
    let ySquared = Math.pow(pos1[1] - pos2[1], 2);
    return Math.sqrt(xSquared + ySquared);
  },

  width: window.innerWidth - 20,
  height: window.innerHeight - 20

};

module.exports = Utils;
