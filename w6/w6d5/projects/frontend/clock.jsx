import React from 'react';

class Clock extends React.Component {
  constructor(){
    super();

    this.state = { time: new Date() };
    this.intervalId = null;
    this.tick = this.tick.bind(this);
  }

  componentDidMount() {
    this.intervalId = setInterval( this.tick, 1000);
  }

  componentWillUnmount(){
    clearInterval(this.intervalId);
  }

  tick() {
    this.setState({ time: new Date() });
  }

  render(){
    return (
      <div className = 'clock'>
        <h1>React Clock</h1>
        <hr />
        <p>
          <h2>Time: </h2>
          <h2>{this.state.time.toLocaleTimeString()}</h2>
        </p>
        <p>
          <h2>Date: </h2>
          <h2>{this.state.time.toDateString()}</h2>
        </p>
      </div>
    );
  }
}

export default Clock;
