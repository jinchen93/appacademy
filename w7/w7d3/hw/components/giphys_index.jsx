import React from 'react';

import GiphysIndexItem from './giphys_index_item';

const GiphysIndex = props => (
  <div>
    { props.giphys.map( (giphy, idx) => (
        <GiphysIndexItem key={'giphy' + idx} giphy={giphy} />
      ))
    }
  </div>
);

export default GiphysIndex;
