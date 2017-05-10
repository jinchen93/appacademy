import React from 'react';

const GiphysIndexItem = ({ giphy }) => (
  <iframe
    src={`//giphy.com/embed/${giphy.id}`}
    width="480"
    height="360"
    frameBorder="0"
    allowFullScreen
  />
);

export default GiphysIndexItem;
