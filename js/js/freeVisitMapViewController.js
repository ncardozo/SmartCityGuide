var POI = require("./poi.js");

var FreeVisitMapViewControllerStrategy = function() {
  this.annotations = [];
};
FreeVisitMapViewControllerStrategy.prototype.getPinLook = function(poi) {
  return "green_pin";
};

FreeVisitMapViewControllerStrategy.prototype.addPOILocations = function(poisList) {
    this.annotations = [];
    for(var i=0; i<poisList.length; i++) {
        var annotationPoint = poiList[i];
        this.annotations.push(annotationPoint);
    }
};

//ADAPTATIONS
var ColorFreeVisitMapViewControllerStrategy = function() {};
ColorFreeVisitMapViewControllerStrategy.prototype = Object.create(FreeVisitMapViewControllerStrategy.prototype);
ColorFreeVisitMapViewControllerStrategy.prototype.getPinLook = function(poi) {
  var image;
  var category = poi.getCategory();
  if(category == "Culture"){
      image = "green_pin";
  }
  else if(category == "Divertissement"){
      image = "blue_pin";
  }
  else if(category == "Shopping"){
      image = "pink_pin";
  }
  else {
      image = "yellow_pin";
  }
  return image;
};

//BEHAVIOR
var FreeVisitMapViewController = function(strategy) {
  this.strategy = strategy;
};

FreeVisitMapViewController.prototype.setStrategy = function(s) {
  this.strategy = s;
};

FreeVisitMapViewController.prototype.getStrategy = function() {
  return this.strategy;
};

FreeVisitMapViewController.prototype.getPinLook = function(poi) {
  return this.strategy.getPinLook(poi);
};

FreeVisitMapViewController.prototype.addPOILocations = function(pois) {
  this.setStrategy(new FreeVisitMapViewControllerStrategy());
  this.strategy.addPOILocations(pois);
};

module.exports = {
  FreeVisitMapViewController: FreeVisitMapViewController,
  ColorFreeVisitMapViewControllerStrategy: ColorFreeVisitMapViewControllerStrategy,
  FreeVisitMapViewControllerStrategy: FreeVisitMapViewControllerStrategy
};
