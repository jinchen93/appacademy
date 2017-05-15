import React from "react";

const BenchIndexItem = ({ bench }) => (
  <li>
    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRV_bA1JQmRP%20%20%20%20%20%20%20%20vEPSVElyc3ZunQTVF-L5bczwChbTpk04T975bIF" />
    <section>
      <h3>{bench.description}</h3>
    </section>
  </li>
);

export default BenchIndexItem;
