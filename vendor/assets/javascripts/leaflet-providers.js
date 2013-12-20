// Leaflet shortcuts for common tile providers

L.TileLayer.Common = L.TileLayer.extend({
  initialize: function (options) {
    L.TileLayer.prototype.initialize.call(this, this.url, options);
  }
});

(function () {
  L.TileLayer.MapBox = L.TileLayer.Common.extend({
    url: 'http://{s}.tiles.mapbox.com/v3/{user}.{map}/{z}/{x}/{y}.png'
  });

  L.TileLayer.Stamen = L.TileLayer.Common.extend({
    url: 'http://{s}.tile.stamen.com/{style}/{z}/{x}/{y}.png'
  });
}());
