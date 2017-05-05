import React from 'react';
import CalcButtons from './calc_buttons';

class Calculator extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      result: '',
      num1: '',
      num2: ''
    };

    this.add = this.add.bind(this);
    this.subtract = this.subtract.bind(this);
    this.multiply = this.multiply.bind(this);
    this.divide = this.divide.bind(this);
  }

  setNum1(e) {
    e.preventDefault();
    this.setState({ num1: parseInt(e.currentTarget.value) });
  }

  setNum2(e) {
    e.preventDefault(e);
    this.setState({ num2: parseInt(e.currentTarget.value) });
  }

  add() {
    this.setState({
      result: this.state.num1 + this.state.num2
    });
  }

  subtract() {
    this.setState({
      result: this.state.num1 - this.state.num2
    });
  }

  multiply() {
    this.setState({
      result: this.state.num1 * this.state.num2
    });
  }

  divide() {
    this.setState({
      result: this.state.num1 / this.state.num2
    });
  }

  clear() {
    this.setState({
      result: '',
      num1: '',
      num2: ''
    });
  }

  render() {
    return(
      <div>
        <h1>{this.state.result}</h1>
        
        <input 
          type="text" 
          onChange={ e => this.setNum1(e) } 
          value={this.state.num1} 
        />

        <input 
          type="text" 
          onChange={ e => this.setNum2(e) } 
          value={this.state.num2} 
        />

        <button onClick={ () => this.clear() }>Clear</button>

        <br/>
        
        <CalcButtons 
          add={this.add}
          subtract={this.subtract}
          multiply={this.multiply}
          divide={this.divide}
        />

      </div>
    );
  }
}

export default Calculator;