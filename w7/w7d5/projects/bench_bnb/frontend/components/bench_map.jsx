// global_vars = google

import React from "react";
import MarkerManager from "../util/marker_manager";
import { getBounds } from "../util/google_map_utils";

class BenchMap extends React.Component {
  componentDidMount() {
    const mapOptions = {
      center: { lat: 37.7758, lng: -122.435 }, // this is SF
      zoom: 13,
    };

    this.map = new google.maps.Map(this.mapNode, mapOptions);

    this.map.addListener("idle", () => {
      const bounds = getBounds(this.map);
      this.props.updateFilter("bounds", bounds);
    });

    this.MarkerManager = new MarkerManager(this.map);
    this.MarkerManager.updateMarkers(this.props.benches);
  }

  componentWillReceiveProps(nextProps) {
    this.MarkerManager.updateMarkers(nextProps.benches);
  }

  render() {
    return <div id="map-container" ref={map => (this.mapNode = map)} />;
  }
}

export default BenchMap;
