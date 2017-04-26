function madLib(verb, adjective, noun) {
  return `We shall ${verb.toUpperCase()} `
    + `the ${adjective.toUpperCase()} ${noun.toUpperCase()}`;
}

function isSubstring(searchString, subString) {
  let result = false;
  let substringStart = false;
  let sub = '';

  searchString.split('').forEach((letter) => {
    if (subString.includes(letter)) {
      substringStart = true;
      sub += letter;
    } else {
      substringStart = false;
      sub = '';
    }

    if (sub === subString) {
      result = true;
    }
  });

  return result;
}

function fizzBuzz(array) {
  let result = [];
  array.forEach( (val) => {
    if ((val % 3) + (val % 5) === 0) {
      return;
    }
    else if (val % 3 === 0) {
      result.push(val);
    }
    else if (val % 5 === 0) {
      result.push(val);
    }
  });
  return result;
}

function isPrime(number) {
  if (number === 1) {
    return false;
  }

  let prime = true;

  for (let i = 2; i < number; i++) {
    if (number % i === 0) {
      prime = false;
    }
  }

  return prime;
}

function sumOfNPrimes(n) {
  let sum = 0;
  let count = -1;
  let i = 0;

  while (count !== n) {
    if (isPrime(i)) {
      console.log(i);
      sum += i;
      count++;
    }
    i++;
  }

  return sum;
}
