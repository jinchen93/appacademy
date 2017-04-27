Array.prototype.bubbleSort = function() {
  let notSorted = true;

  while (notSorted) {
    notSorted = false;

    for (let i = 0; i < this.length - 1; i++) {
      if (this[i] > this[i + 1]) {
        notSorted = true;

        let temp = this[i];
        this[i] = this[i + 1];
        this[i + 1] = temp;
      }
    }
  }

  return this;
};

// let arr = [5, 4, 3, 2, 1];
// arr.bubbleSort();

function substrings(string) {
  let substringArr = [];

  for (let i = 0; i < string.length; i++) {
    for (let j = i + 1; j <= string.length; j++) {
      substringArr.push(string.substring(i, j));
    }
  }

  return substringArr;
}

// substrings("cat");

function range(start, end) {
  if (end < start) {
    return [];
  } else {
    return [start].concat(range(start + 1, end));
  }
}

// range(1, 5);

Array.prototype.sum = function() {
  if (this.length === 0) {
    return 0;
  } else {
    return this[0] + this.slice(1).sum();
  }
};

// [1,1,1,2].sum();

function exponent1(base, exp) {
  if (exp === 0) {
    return 1;
  } else {
    return base * exponent1(base, exp - 1);
  }
}

// exponent1(2, 3);

function exponent2(base, exp) {
  if (exp === 0) {
    return 1;
  } else if (exp === 1) {
    return base;
  } else if (exp % 2 === 0) {
    let sqrt = exponent2(base, exp / 2);
    return sqrt * sqrt;
  } else {
    let factor = exponent2(base, (exp - 1) / 2);
    return base * factor * factor;
  }
}

// exponent2(2, 3);


function fibonacci(n) {
  if (n === 0) {
    return [];
  } else if (n === 1) {
    return [0];
  } else if (n === 2) {
    return [0, 1];
  } else {
    let fibs = fibonacci(n - 1);
    let next = fibs[fibs.length - 1] + fibs[fibs.length - 2];
    console.log(`fibs: ${fibs}`);
    console.log(`next: ${next}`);
    fibs.push(next);
    return fibs;
  }
}

// fibonacci(3);
// fibonacci(9);

function bSearch(array, target) {
  if (array.length === 0) {
    return null;
  }

  let middle = Math.floor(array.length / 2);

  if (array[middle] === target) {
    return middle;
  } else if (target < array[middle]) {
    return bSearch(array.slice(0, middle), target);
  } else {
    let results = bSearch(array.slice(middle + 1), target);
    return results === null ? null : results + middle + 1;
  }
}

// bSearch([1, 2, 3], 1) === 0;
// bSearch([2, 3, 4, 5], 3) === 1;
// bSearch([2, 4, 6, 8, 10], 6) === 2;
// bSearch([1, 3, 4, 5, 9], 5) === 3;
// bSearch([1, 2, 3, 4, 5, 6], 6) === 5;
// bSearch([1, 2, 3, 4, 5, 6], 0) === null;
// bSearch([1, 2, 3, 4, 5, 7], 6) === null;

function makeChange(total, coins) {

  if (total === 0) {
    return [];
  } else if (total - coins[0] >= 0) {
    let tempChange = makeChange(total - coins[0], coins);

    tempChange.unshift(coins[0]);
    return tempChange;
  } else {
    return makeChange(total, coins.slice(1));
  }
}

// makeChange(14, [10, 7, 1]);

function makeBetterChange(total, coins) {
  let best;

  if (total === 0) {
    return [];
  } else if (total - coins[0] >= 0) {

    for (let i = 0; i < coins.length; i++) {
      let coin = coins[i];
      let subChange = makeBetterChange(total - coin, coins);
      let changeCombo = [coin].concat(subChange);

      if (best === undefined || changeCombo.length < best.length) {
        best = changeCombo;
      }
    }

    return best;
  } else {
    return makeBetterChange(total, coins.slice(1));
  }
}

// makeBetterChange(14, [10, 7, 1]);

function merge(left, right) {
  let merged = [];

  while (left.length > 0 && right.length > 0) {
    let elem;
    if (left[0] < right[0]) {
      elem = left.shift();
    } else {
      elem = right.shift();
    }

    merged.push(elem);
  }

  return merged.concat(left).concat(right);
}

function mergeSort(array) {
  if (array.length < 2) {
    return array;
  } else {
    let middle = Math.floor(array.length / 2);

    let left = mergeSort(array.slice(0, middle));
    let right = mergeSort(array.slice(middle));

    return merge(left, right);
  }
}

mergeSort([5, 4, 3, 2, 1, 7, 22]);


function subsets(array) {
  if (array.length === 0) {
    return [[]];
  }

  let subsWithout = subsets(array.slice(0, array.length - 1));

  // console.log(`subsWithout: ${subsWithout}`);

  let subsWith = subsWithout.map( ele => {
    return ele.concat([array[array.length - 1]]);
  });

  // console.log(`subsWith: ${subsWith}`);

  return subsWithout.concat(subsWith);
}

subsets([]) == [[]];
subsets([1]) == [[], [1]];
subsets([1, 2]) == [[], [1], [2], [1, 2]];
subsets([1, 2, 3]) == [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]];
