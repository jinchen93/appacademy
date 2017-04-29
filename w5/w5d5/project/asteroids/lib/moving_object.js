function MovingObject(params) {
  this.pos = params.pos;
  this.vel = params.vel;
  this.radius = params.radius;
  this.color = params.color;
  this.game = params.game;
}

MovingObject.prototype.draw = function(ctx) {
  ctx.fillStyle = this.color;
  ctx.beginPath();
  ctx.arc(
    this.pos[0],
    this.pos[1],
    this.radius,
    0,
    2 * Math.PI,
    false
  );
  ctx.fill();
};


MovingObject.prototype.move = function() {
  let wrappedPos = this.game.wrap(this.pos);

  this.pos[0] = wrappedPos[0] + this.vel[0];
  this.pos[1] = wrappedPos[1] + this.vel[1];
};

module.exports = MovingObject;
