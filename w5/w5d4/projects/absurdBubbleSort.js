const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdin
});


// reader.question("Enter a number:", response => {
// }

function askIfGreaterThan(el1, el2, callback) {
  reader.question(`${el1} is greater than ${el2}?`, response => {
    if (response === "yes") {
      callback(true);
    } else {
      callback(false);
    }
  });
}

// askIfGreaterThan(1, 2, (response) => console.log(response));

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1) {
    askIfGreaterThan(arr[i], arr[i + 1], (isGreaterThan) => {
      if (isGreaterThan) {
        let temp = arr[i];
        arr[i] = arr[i+1];
        arr[i+1] = temp;
        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop);
    });
  } else if (i === arr.length - 1) {
    outerBubbleSortLoop(madeAnySwaps);
  }
}

// innerBubbleSortLoop([1,2,3,8,6,5], 0, false, (arr) => {
//   console.log(arr);
//   reader.close();
// });

function absurdBubbleSort(arr, sortCompletionCallback) {

  function outerBubbleSortLoop(madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  }

  outerBubbleSortLoop(true);
}

absurdBubbleSort([1,2,3,8,6,5], arr => {
  console.log(arr);
  reader.close();
});
