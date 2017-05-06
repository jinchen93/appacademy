import React from 'react';
import Clock from './clock';
import Weather from './weather';
import Autocomplete from './autocomplete';

const MONKEYMAP = {
  "Marmoset": "./monkey.jpg",
  "Mandrill": "./monkey.jpg",
  "Howler Monkey": "./howler.jpg",
  "Squirrel Monkey": "./monkey.jpg",
  "Vervet Monkey": "./monkey.jpg",
  "Japanese Macaque": "./monkey.jpg",
  "Rhesus Macaque": "./monkey.jpg",
  "Capuchin": "./monkey.jpg",
  "Proboscis Monkey": "./monkey.jpg"
};

class Root extends React.Component {
  constructor(){
    super();
  }
  render(){
    return (
      <div>
        <Clock />
        <br />
        <Weather />
        <br />
        <Autocomplete monkeyList={[
            "Marmoset",
            "Mandrill",
            "Howler Monkey",
            "Squirrel Monkey",
            "Vervet Monkey",
            "Japanese Macaque",
            "Rhesus Macaque",
            "Capuchin",
            "Proboscis Monkey"
          ]} monkeyMap={MONKEYMAP} />
      </div>
    );
  }
}

export default Root;
