Function.prototype.inherits = function(subclass) {
  // function Surrogate() {}
  // Surrogate.prototype = subclass.prototype;
  this.prototype = Object.create(subclass.prototype);
  this.prototype.constructor = this;
};

function MovingObject (name) {
  this.name = name;
}

MovingObject.prototype.say = function () {
  console.log(this.name);
};

function Ship (name) {
  this.name = name;
}

Ship.inherits(MovingObject);

function Asteroid (name) {
  this.name = name;
}

// Asteroid.inherits(MovingObject);


let ship = new Ship('ship');
let asteroid = new Asteroid('asteroid');
