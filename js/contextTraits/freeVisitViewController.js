var Trait = require("traits").Trait;
var cop = require("context-traits");
var POI = require("./poi.js");

TFreeVisitMapViewControlleroperations = Trait({
    getPinLook: function() {
      return "green_pin";
    },
    addPoiLocations: function() {
      this.annotations = [];
      for(var i=0; i<poisList.length; i++) {
          var annotationPoint = poiList[i];
          this.annotations.push(annotationPoint);
      }
    }
});

//ADAPTATIONS
TColorFreeVisitMapViewControllerOperations = Trait ({
  getPinLook: function(poi) {
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
  }
});

//BEHAVIOR
function TFreeVisitMapViewController() {
  return Trait.compose(TFreeVisitMapViewControlleroperations, Trait({
    annotations: []
  }));
}

function FreeVisitMapViewController() {
  return Object.create(Object.prototype, TFreeVisitMapViewController);
}


module.exports = {
  FreeVisitMapViewController: FreeVisitMapViewController,
  ColorFreeVisitMapViewControllerStrategy: ColorFreeVisitMapViewControllerStrategy,
  FreeVisitMapViewControllerStrategy: FreeVisitMapViewControllerStrategy
};
