var Trait = require("traits").Trait;
var cop = require("context-traits");
var POI = require("./poi.js");
var ITINERARY = require("./irinerary.js");
var PVC = require("./poiViewController.js");


TGuidedVisitMapControllerOperations = Trait({
  nextPoi: function() {
    var curIti = this.currentItinerary;
    var itiPois = curIti.getItineraryPOIs();

     if(currentPoi == itiPois.length()){
         this.cancelItinerary();
     } else {
         currentPoi += 1;
         this.activeItinerary.curPoiNb += 1;
         this.refreshAnnotations();
     }
  },
  setItinerary: function() {
      var curIti = this.currentItinerary;
      //Set the itinerary text
      console.log(curIti.getDescription());
      //Set the annotations
      this.mapView.removeAnnotations(this.annotations);
      this.addPoiAnnotations();
      //Set count button
      console.log(this.currentIti+1 + "/" + this.currentItinerary.length);
  },
  cancelItinerary: function() {
     this.setItinerary();
     console.log("Choose itinerary");
  },
  addPoiAnnotations: function() {
    var poisList = this.currentIti.getItineraryPOIs();
    this.annotations = [];
    var i=0;
    while(i < poisList.length()){
       var curP = poisList[i];
       var annotationPoint = new Annotation(curP, i);
       this.mapView.addAnnotation(annotationPoint);
       this.annotations.push(annotationPoint);
       i++;
    }
  },
  mapView: function(annotation) {
    if(typeof annotation === MKUserLocation){
      return null;
    } else {
      var annotationIdentifier = "AnnotationIdentifier";
      var pinView = this.mapView.dequeueReusableAnnotationViewWithIdentifier(annotationIdentifier);
      //If one isn't available, create a new one
      if(!pinView){
          pinView = new Annotation(annotation, annotationIdentifier);
      }
      //Basic properties
      var imgUrl = "number" + annotation.indexIti+1;
      pinView.image = imgUrl;

      return pinView;
    }
  }
});

//ADAPTATIONS
TGuidedTourGuidedVisitMapControllerOperations = Trait({
  checkNearestPoi: function() {
    var currentLocation = mapView.userLocation.location;
    var nearestPoi = null;
    var nearestDist = 0;
    var itineraryPois = currentItinerary.getItineraryPOIs();
    for(var i=0; i< itineraryPois.length; i++) {
        if(typeof nearestPoi === null){
            nearestPoi = itineraryPois[i];
            nearestDist = itineraryPois[i].distanceBetween(posX, posY);
        } else {
            var curDist = itineraryPois[i].distanceBetween(posX, posY);
            if(curDist < nearestDist){
                nearestPoi = itineraryPois[i];
                nearestDist = curDist;
            }
        }
    }
    var indexPoi = nearestPoi.getId();
    if(indexPoi == this.currentPoi) {
        this.nextPoi();
    }
  },
  mapView: function(annotation) {
    if(typeof annotation === MKUserLocation) {
      return null;
    } else {
      var annotationIdentifier = "AnnotationIdentifier";
      var pinView = this.mapView.dequeueReusableAnnotationViewWithIdentifier(annotationIdentifier);
      //If one isn't available, create a new one
      if(!pinView){
          pinView = new Annotation(annotationIdentifier);
      }

      var indexPoi = annotation.indexIti + 1;

      //Basic properties
      pinView.canShowCallout = YES;
      var imgUrl;
      if(indexPoi == this.currentPoi){
          imgUrl = "number" + indexPoi;
      } else {
          imgUrl = "number" + indexPoi + "_grey";
      }
      pinView.image = imgUrl;
      return pinView;
    }
  }
});

//BEHAVIOR
function TGuidedVisitMapController() {
  return Trait.compose(TGuidedVisitMapControllerOperations, Trait({
    itineraryList: [],
    currentItinerary: null,
    mapView: null,
    currentPoi: 0
  }));
}

function GuidedVisitMapController() {
  return Object.create(Object.prototype, TGuidedVisitMapController);
}


module.exports = {
  GuidedVisitMapController: GuidedVisitMapController,
  TGuidedVisitMapControllerOperations: TGuidedVisitMapControllerOperations,
  TGuidedTourGuidedVisitMapControllerOperations: TGuidedTourGuidedVisitMapControllerOperations
};
