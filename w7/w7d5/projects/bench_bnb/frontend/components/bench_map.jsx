// global_vars = google

import React from "react";
import MarkerManager from "../util/marker_manager";
import { getBounds } from "../util/google_map_utils";
import { withRouter } from "react-router-dom";

class BenchMap extends React.Component {
  componentDidMount() {
    const mapOptions = {
      center: { lat: 37.784052, lng: -122.407588 }, // this is SF
      zoom: 14,
    };

    this.map = new google.maps.Map(this.mapNode, mapOptions);

    this.map.addListener("idle", () => {
      const bounds = getBounds(this.map);
      this.props.updateFilter("bounds", bounds);
    });

    this.map.addListener("click", e => {
      const coords = { lat: e.latLng.lat(), lng: e.latLng.lng() };
      this._handleClick(coords);
    });

    this.MarkerManager = new MarkerManager(this.map);
    this.MarkerManager.updateMarkers(this.props.benches);
  }

  componentWillReceiveProps(nextProps) {
    this.MarkerManager.updateMarkers(nextProps.benches);
  }

  _handleClick(coords) {
    this.props.history.push({
      pathname: "benches/new",
      search: `lat=${coords.lat}&lng=${coords.lng}`,
    });
  }

  render() {
    return <div id="map-container" ref={map => (this.mapNode = map)} />;
  }
}

export default withRouter(BenchMap);
