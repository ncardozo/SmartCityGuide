var POI = require("./poi.js");

var Annotation = function(poi, index) {
  this.x = poi.getAddress();
  this.y = poi.getAddress();
  this.title = poi.getName();
  this.poi = poi;
  this.indexIti = index;
};


module.exports = {
  Annotation: Annotation
};
