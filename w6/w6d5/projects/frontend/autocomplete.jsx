import React from 'react';

class Autocomplete extends React.Component {
  constructor(props) {
    super(props);

    this.state = { monkeys: props.monkeyList, monkeyMap: props.monkeyMap };
    this.searchMonkeys = this.searchMonkeys.bind(this);
  }

  searchMonkeys(event) {
    event.preventDefault();
    let search = event.target.value;
    if(search === ''){
      this.setState({ monkeys: this.props.monkeyList});
    } else{
      let matcher = new RegExp(`^${search}`, 'i');
      this.setState({ monkeys: this.state.monkeys.filter(monkey => {
        return monkey.match(matcher);
      })
     });
    }
  }

  printImage() {
    if(this.state.monkeys.length == 1){
      return <img src={this.state.monkeyMap[this.state.monkeys[0]]}/>;
    }
  }

  render() {
    const createMonkeys = (monkeyList) => {
      return monkeyList.map((monkey, idx) => {
        console.log(monkey);
        return <li key={monkey + idx}>{monkey}</li>;
      });
    };

    return (
      <div className="autocomplete">
        <h1>React Autocomplete</h1>
        <hr />
        <input type="text" onChange={this.searchMonkeys} />
        <ul className="monkey-list">
          {createMonkeys(this.state.monkeys)}
        </ul>
        {this.printImage()}
      </div>
    );
  }
}

export default Autocomplete;
