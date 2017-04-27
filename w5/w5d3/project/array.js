Array.prototype.uniq = function() {
  let elemSoFar = {};
  let newUniqArr = [];

  this.forEach((el) => {
    if (elemSoFar[el] === undefined) {
      elemSoFar[el] = true;
      newUniqArr.push(el);
    }
  });

  return newUniqArr;
};

// [1, 2, 1, 3, 3].uniq();

Array.prototype.twoSum = function () {
  let twoSums = [];

  for (let i = 0; i < this.length - 1; i++) {
    for (let j = i + 1; j < this.length; j++ ) {
      if (this[i] + this[j] === 0) {
        twoSums.push([i, j]);
      }
    }
  }

  return twoSums;
};

// [-1, 0, 2, -2, 1].twoSum();

Array.prototype.myTranspose = function() {
  let transposeArray = [];

  let tempArray;
  for (let row = 0; row < this.length; row++) {
    tempArray = [];

    for (let col = 0; col < this.length; col++) {
      tempArray.push(this[col][row]);
    }

    transposeArray.push(tempArray);
  }

  return transposeArray;
};

let rows = [[0, 1, 2], [3, 4, 5], [6, 7, 8]];

// rows.myTranspose();
