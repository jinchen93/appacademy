export const getBounds = map => {
  const boundsObj = map.getBounds();
  const northEast = boundsObj.getNorthEast();
  const southWest = boundsObj.getSouthWest();
  const northEastLatLng = {
    lat: northEast.lat(),
    lng: northEast.lng(),
  };
  const southWestLatLng = {
    lat: southWest.lat(),
    lng: southWest.lng(),
  };

  const bounds = {
    northEast: northEastLatLng,
    southWest: southWestLatLng,
  };

  return bounds;
};
