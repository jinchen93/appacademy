Array.prototype.myEach = function(callback) {
  for(let i = 0; i < this.length; i++) {
    callback(this[i]);
  }
};

// [1, 2, 3].myEach( el => {
//   console.log(el);
// });


Array.prototype.myMap = function(callback) {
  let mappedArr = [];
  this.myEach( function(el) {
    mappedArr.push(callback(el));
  });
  return mappedArr;
};

// [1, 2, 3].myMap( el => {
//   return el * 2;
// });

Array.prototype.myInject = function(callback) {
  let accum = this[0];

  this.slice(1).myEach( (el) => {
    accum = callback(accum, el);
  });

  return accum;
};

[1, 2, 3, 4, 5].myInject( function(accum, el) {
  return accum + el;
});
