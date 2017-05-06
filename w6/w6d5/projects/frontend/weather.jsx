import React from 'react';

class Weather extends React.Component {
  constructor() {
    super();
    this.state = {weather: null,
                  location: null,
                  lat: null,
                  long: null};

  }

  componentDidMount(){
    navigator.geolocation.getCurrentPosition((res) => {
      this.setState({lat: res.coords.latitude, long: res.coords.longitude});
      this.fetchWeather();
    });
  }

  fetchWeather(){
    const xhr = new XMLHttpRequest();

    xhr.open('GET', `http://api.openweathermap.org/data/2.5/weather?lat=${this.state.lat}&lon=${this.state.long}&appid=bcb83c4b54aee8418983c2aff3073b3b`);

    xhr.onload = () => {
      let json = JSON.parse(xhr.response);
      this.setState({weather: json.main.temp, location: json.name});
    };

    xhr.send();
  }

  kelvinToFahrenheit(kelvins) {
    return Math.floor(((( kelvins - 273.15) * 9/5) + 32));
  }

  render(){
    return(
      <div className = "weather">
        <h1>React Weather</h1>
        <hr />
        <p>
          <h2>{this.state.location}</h2>
        </p>
        <p>
          <h2>{this.kelvinToFahrenheit(this.state.weather)} degrees</h2>
        </p>
    </div>
  );
  }
}

export default Weather;
