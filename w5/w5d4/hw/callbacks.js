// window.setTimeout( () => alert('HAMMERTIME'), 5000);
//
// const hammerTime = time => {
//   window.setTimeout( () => alert(`${time} is hammertime!`), 5000);
// };

const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function teaAndBiscuits () {
  let first, second;

  reader.question('Would you like some tea?', (res1) => {
    first = res1;
    console.log(`You replied ${res1}.`);

    reader.question('Would you like some biscuits?', (res2) => {
      second = res2;
      console.log(`You replied ${res2}.`);

      const firstRes = (first === 'yes') ? 'do' : 'don\'t';
      const secondRes = (second === 'yes') ? 'do' : 'don\'t';

      console.log(`So you ${firstRes} \
        want tea and you ${secondRes} want biscuits.`);

      reader.close();
    });
  });
}

// teaAndBiscuits();
