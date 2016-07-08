var Trait = require("traits").Trait;
var cop = require("context-traits");
var ContextManager = require("./contextManager.js");
var GVMC = require("./guidedVisitMapController");
var POI = require("./poi.js");
var db = require("./DBManager.js");
var user = require("./user.js").User;

TGuidedVisitOperations = Trait({
  setDescription: function(desc) {
  		throw new Error("A language strategy needs to be defined to set the GuidedVisit description");
  },
  getDescription: function() {
  		throw new Error("A language strategy needs to be defined to get the GuidedVisit description");
  },
  hideItineraryChoice: function(hide) {
  		if(hide)
  			console.log("displaying choice of itinerary option");
  		else
  			console.log("no choice of itinerary option is displayed");
  },
  updateItineraries: function() {
  	this.itineraryList =  itineraryList;
  },
  addPoiAnnotations: function() {
  		var pois = this.currentIninerary.itineraryPOIs;
  		for(i=0; i<pois.length; i++) {
  			var poi = pois[i];
  			var pos = [poi.latitude, poi.longitude];
  			this.annotations[pos] = {
  										"poi": poi.name(),
  										"state": poi.state()
  									};
  		}
  },
  setItinerary: function(id) {
  		var itinerary;
  		if(typeof this.itineraryList[id] !== 'undefined') {
  			itinerary = this.itineraryList[id];
  		}
  		this.strategy.setDescription(itinerary.getDescription());
  		console.log("Itinerary count: " + (this.currentItinerary + 1) + "/" + this.itineraryList.length);
  },
  checkNearestPoit: function() {
  	var currentLocation = user.getLocation();
  	var nearestPoi = null;
  	var nearestDist = 0;
  	var poi;
  	var pois = this.itineraryList[this.currentItinerary].getItineraryPOIs();
  	for(var i=0; i< pois.length; i++) {
  		poi = pois[i];
  		if(nearestPoi === null) {
  			nearestPoi = poi;
  			nearestDist = poi.distanceBetween(currentLocation);
  		} else {
  			var curDist = poi.distanceBetween(currentLocation);
  			if(curDist < nearestDist) {
  				nearestPoi = poi;
  				nearestDist = curDist;
  			}
  		}
  	}
  	var indexPoi = nearestPoi.id();
  	if(indexPoi === this.currentPoi) {
  		this.nextPoi();
  	}
  },
  refreshAnnotations: function() {
  	this.addPoiAnnotations();
  },
  nextPoi: function() {
  	var itinerary = this.itineraryList[this.currentItinerary];
  	var itineraryPOIs = itinerary.getItineraryPOIs();
  	if(this.currentPoi === itineraryPOIs[itineraryPOIs.length -1]){
          this.cancelItinerary();
    } else {
        this.currentPoi += 1;
        this.refreshAnnotations();
    }
  },
  cancelItinerary: function() {
   	this.currentPoi = 0;
  	this.setItinerary();
  	console.log("Choose itinerary");
  }
});

//--- ADAPTATIONS
TEnglishGuidedVisitOperations = Trait({
  setDescription: function(desc) {
	   db.runQuery('INSERT INTO GuidedVisit Values(%@, %@, %@)', this.id, "EN", desc);
  },
  getDescription: function() {
	   var res = db.runQuery('SELECT description FROM GuidedVisit WHERE id = %@ AND language = %@', this.id, "EN");
     return res[0];
   },
});

TFrenchGuidedVisitOperations = Trait({
  setDescription: function(desc) {
	   db.runQuery('INSERT INTO GuidedVisit Values(%@, %@, %@)', this.id, "FR", desc);
   },
   getDescription: function() {
	    var res = db.runQuery('SELECT description FROM GuidedVisit WHERE id = %@ AND language = %@', this.id, "FR");
      return res[0];
    }
});

TDutchGuidedVisitOperations = Trait({
  setDescription: function(desc) {
	   db.runQuery('INSERT INTO GuidedVisit Values(%@, %@, %@)', this.id, "NL", desc);
   },
   getDescription: function() {
	    var res = db.runQuery('SELECT description FROM GuidedVisit WHERE id = %@ AND language = %@', this.id, "NL");
      return res[0];
    }
});

//--- BEHAVIOR
function TGuidedVisit(nid, currentIti, currentPoi) {
	return Trait.compose(TGuidedVisitOperations, Trait({
    id: nid,
  	itineraryList: [],
  	description: "",
  	annotations: new Map(),  //map view annotated with all pois {(lat, long), annotation}
  	currentItinerary: currentIti, //int
  	currentPOI: currentPoi, //int
  }));
}

function GuidedVisit(nid, currentIti, currentPoi) {
	return Object.create(Object.prototype, TGuidedVisit);
}

module.exports = {
	GuidedVisit: GuidedVisit,
	GuidedVisitStrategy: GuidedVisitStrategy,
	TEnglishGuidedVisitOperations: TEnglishGuidedVisitOperations,
	TFrenchGuidedVisitOperations: TFrenchGuidedVisitOperations,
	TDutchGuidedVisitOperations: TDutchGuidedVisitOperations
};
