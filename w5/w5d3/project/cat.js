function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatements = function() {
  return `${this.owner} loves ${this.name}`;
};

const harry = new Cat("Harry", "Trevor");
const mia = new Cat("Mia", "Wyatt");

console.log(harry.cuteStatements());
console.log(mia.cuteStatements());

Cat.prototype.cuteStatements = function() {
  return `Everyone loves ${this.name}!`;
};

console.log(harry.cuteStatements());
console.log(mia.cuteStatements());

Cat.prototype.meow = () => console.log("meow");

harry.meow = () => console.log("rarh");

harry.meow();
mia.meow();
