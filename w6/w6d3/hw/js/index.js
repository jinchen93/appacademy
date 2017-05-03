// console.log("Hello from the JavaScript console!");
//
// $.ajax({
//   method: 'GET',
//   url: 'http://api.openweathermap.org/data/2.5/weather?q=NY,NY&appid=bcb83c4b54aee8418983c2aff3073b3b',
//   success: res => console.log(res.main.temp)
// });
//
// // Add another console log here, outside your AJAX request
// console.log('Last line');


const fetchWeather = () => {
  console.log('Fetching weather...');

  return $.ajax({
    url: 'http://api.openweathermap.org/data/2.5/weather?q=NY,NY&appid=bcb83c4b54aee8418983c2aff3073b3b',
    method: 'GET'
  });
};

const handleWeather = res => {
  console.log('Weather is:');
  console.log(res.main.temp);
};

fetchWeather().then(handleWeather);
