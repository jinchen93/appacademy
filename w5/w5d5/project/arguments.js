// function sum() {
//   const args = [].slice.call(arguments);
//   let result = 0;
//   for (let i = 0; i < args.length; i++) {
//     result += args[i];
//   }
//   return result;
// }
//
// function sum2(...args) {
//   let result = 0;
//   for (let i = 0; i < args.length; i++) {
//     result += args[i];
//   }
//   return result;
// }
//
//
//
//
//
//
// Function.prototype.myBind = function() {
//   const args = [].slice.call(arguments);
//   const ctx = args[0];
//   const bindArgs = args.slice(1);
//   let thisFunk = this;
//
//   return function() {
//     const callArgs = [].slice.call(arguments);
//     const allArgs = bindArgs.concat(callArgs);
//     let boundResult = thisFunk.apply(ctx, allArgs);
//     return boundResult;
//   };
// };
//
//
//
// Function.prototype.myBind2 = function(...args) {
//   const ctx = args[0];
//   const bindArgs = args.slice(1);
//   let thisFunk = this;
//
//   return function(...callArgs) {
//     const allArgs = bindArgs.concat(callArgs);
//     return thisFunk.apply(ctx, allArgs);
//   };
// };
//
//
//
// class Cat {
//   constructor(name) {
//     this.name = name;
//   }
//
//   says(sound, person) {
//     console.log(`${this.name} says ${sound} to ${person}!`);
//     return true;
//   }
// }
//
// const markov = new Cat("Markov");
// const breakfast = new Cat("Breakfast");
//
// markov.says("meow", "Ned");
// // Markov says meow to Ned!
// // true
//
// // bind time args are "meow" and "Kush", no call time args
// markov.says.myBind(breakfast, "meow", "Kush")();
// // Breakfast says meow to Kush!
// // true
//
// // no bind time args (other than context), call time args are "meow" and "me"
// markov.says.myBind(breakfast)("meow", "a tree");
// // Breakfast says meow to a tree!
// // true
//
// // bind time arg is "meow", call time arg is "Markov"
// markov.says.myBind(breakfast, "meow")("Markov");
// // Breakfast says meow to Markov!
// // true
//
// // no bind time args (other than context), call time args are "meow" and "me"
// const notMarkovSays = markov.says.myBind(breakfast);
// notMarkovSays("meow", "me");
// // Breakfast says meow to me!
// // true



// Function.prototype.curry = function(numArgs) {
//   const numbers = [];
//
//   return function _curriedSum(num) {
//     numbers.push(num);
//     if (numbers.length === numArgs) {
//       let sum = 0;
//       for (let i = 0; i < numbers.length; i++) {
//         sum += numbers[i];
//       }
//       return sum;
//     } else {
//       return _curriedSum;
//     }
//   };
// };


function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

sumThree(4, 20, 6); // == 30

// you'll write `Function#curry`!
let f1 = sumThree.curry(3); // tells `f1` to wait until 3 arguments are given before running `sumThree`
f1 = f1(4); // [Function]
f1 = f1(20); // [Function]
f1 = f1(6); // = 30

Function.prototype.curry = function(numArgs) {
  const args = [];
  const thisFunk = this;
  if (args.length !== numArgs) {
    return Function.prototype.curry;
  } else {
    thisFunk(...args);
  }
};

Function.prototype.curry2 = function(numArgs) {
  const args = [];
  const thisFunk = this;
  if (args.length !== numArgs) {
    return Function.prototype.curry;
  } else {
    thisFunk.apply(numArgs, args);
  }
};

// or more briefly:
console.log(sumThree.curry(3)(4)(20)(6)); // == 30
