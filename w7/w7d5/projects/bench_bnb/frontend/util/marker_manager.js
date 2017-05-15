// global_vars = google

class MarkerManager {
  constructor(map) {
    this.map = map;
    this.markers = {};
  }

  updateMarkers(items) {
    const newItems = {};
    items.forEach(item => (newItems[item.id] = item));

    this.filterOldMarkers(newItems);
    this.addNewMarkers(items);
  }

  addMarker(item) {
    const LatLng = new google.maps.LatLng(item.lat, item.lng);
    const newMarker = new google.maps.Marker({
      position: LatLng,
      title: item.description,
      map: this.map,
    });

    this.addInfoWindow(item, newMarker);
    this.markers[item.id] = newMarker;
  }

  addInfoWindow(item, marker) {
    const infoWindow = new google.maps.InfoWindow({
      content: `<img class="bench-img" src=
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRV_bA1JQmRP
        vEPSVElyc3ZunQTVF-L5bczwChbTpk04T975bIF"
      >
      <h2>${item.description}</h2>`,
    });

    marker.addListener("click", () =>
      infoWindow.open(this.map, marker)
    );
  }

  removeMarker(marker, id) {
    marker.setMap(null);
    delete this.markers[id];
  }

  filterOldMarkers(newItems) {
    const markerIds = Object.keys(this.markers);
    markerIds.forEach(markerId => {
      if (newItems[markerId] === undefined) {
        this.removeMarker(this.markers[markerId], markerId);
      }
    });
  }

  addNewMarkers(items) {
    items.forEach(item => {
      if (this.markers[item.id] === undefined) {
        this.addMarker(item);
      }
    });
  }
}

export default MarkerManager;
