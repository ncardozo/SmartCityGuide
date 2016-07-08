var ContextManager = require("./contextManager.js");
var GVMC = require("./guidedVisitMapController");
var POI = require("./poi.js");
var db = require("./DBManager.js");
var user = require("./user.js").User;

var GuidedVisitStrategy = function() {
	this.id = -1;
	this.itineraryList = [];
	this.description = "";
	this.annotations = new Map();  //map view annotated with all pois {(lat, long), annotation}
	this.currentItinerary = currentIti; //int
	this.currentPOI = currentPoi; //int
};

GuidedVisitStrategy.prototype.setDescription = function(desc) {
		throw new Error("A language strategy needs to be defined to set the GuidedVisit description");
};

GuidedVisitStrategy.prototype.getDescription = function() {
		throw new Error("A language strategy needs to be defined to get the GuidedVisit description");
};

GuidedVisitStrategy.prototype.hideItineraryChoice = function(hide) {
		if(hide)
			console.log("displaying choice of itinerary option");
		else
			console.log("no choice of itinerary option is displayed");
};

GuidedVisitStrategy.prototype.updateItineraries = function() {
	this.itineraryList =  itineraryList;
};

GuidedVisitStrategy.prototype.addPoiAnnotations = function() {
		var pois = this.currentIninerary.itineraryPOIs;
		for(i=0; i<pois.length; i++) {
			var poi = pois[i];
			var pos = [poi.latitude, poi.longitude];
			this.annotations[pos] = {
										"poi": poi.name(),
										"state": poi.state()
									};
		}
};

GuidedVisitStrategy.prototype.setItinerary = function(id) {
		var itinerary;
		if(typeof this.itineraryList[id] !== 'undefined') {
			itinerary = this.itineraryList[id];
		}
		this.strategy.setDescription(itinerary.getDescription());
		console.log("Itinerary count: " + (this.currentItinerary + 1) + "/" + this.itineraryList.length);
};

GuidedVisitStrategy.prototype.checkNearestPoit = function() {
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
};

GuidedVisitStrategy.prototype.refreshAnnotations = function() {
	this.addPoiAnnotations();
};

GuidedVisitStrategy.prototype.nextPoi = function() {
	var itinerary = this.itineraryList[this.currentItinerary];
	var itineraryPOIs = itinerary.getItineraryPOIs();
	if(this.currentPoi === itineraryPOIs[itineraryPOIs.length -1]){
        this.cancelItinerary();
  } else {
      this.currentPoi += 1;
      this.refreshAnnotations();
  }
};

GuidedVisitStrategy.prototype.cancelItinerary = function() {
 	GVMC.GuidedVisitMapController.setStrategy(new GVMC.GuidedVisitMapControllerStrategy());
	POI.Poi.setStrategy(new Poi.PoiStrategy());
	this.currentPoi = 0;
	this.setItinerary();
	console.log("Choose itinerary");
};

//--- ADAPTATIONS
var EnglishGuidedVisitStrategy = function() {};
EnglishGuidedVisitStrategy.prototype = Object.create(GuidedVisitStrategy.prototype);
EnglishGuidedVisitStrategy.prototype.setDescription = function(desc) {
	db.runQuery('INSERT INTO GuidedVisit Values(%@, %@, %@)', this.id, "EN", desc);
};

EnglishGuidedVisitStrategy.prototype.getDescription = function() {
	return db.runQuery('SELECT description FROM GuidedVisit WHERE id = %@ AND language = %@', this.id, "EN");
};

var FrenchGuidedVisitStrategy = function() {};
FrenchGuidedVisitStrategy.prototype = Object.create(GuidedVisitStrategy.prototype);
FrenchGuidedVisitStrategy.prototype.setDescription = function(desc) {
	db.runQuery('INSERT INTO GuidedVisit Values(%@, %@, %@)', this.id, "FR", desc);
};

FrenchGuidedVisitStrategy.prototype.getDescription = function() {
	return db.runQuery('SELECT description FROM GuidedVisit WHERE id = %@ AND language = %@', this.id, "FR");
};

var DutchGuidedVisitStrategy = function() {};
DutchGuidedVisitStrategy.prototype = Object.create(GuidedVisitStrategy.prototype);
DutchGuidedVisitStrategy.prototype.setDescription = function(desc) {
	db.runQuery('INSERT INTO GuidedVisit Values(%@, %@, %@)', this.id, "NL", desc);
};

DutchGuidedVisitStrategy.prototype.getDescription = function() {
	return db.runQuery('SELECT description FROM GuidedVisit WHERE id = %@ AND language = %@', this.id, "NL");
};

//--- BEHAVIOR
var GuidedVisit = function(strategy) {
	this.strategy = strategy;
};

GuidedVisit.prototype.description = function() {
	return this.strategy.getDescription();
};

GuidedVisit.prototype.addDescription = function(desc) {
	this.strategy.setDescription(desc);
};

module.exports = {
	GuidedVisit: GuidedVisit,
	GuidedVisitStrategy: GuidedVisitStrategy,
	EnglishGuidedVisitStrategy: EnglishGuidedVisitStrategy,
	FrenchGuidedVisitStrategy: FrenchGuidedVisitStrategy,
	DutchGuidedVisitStrategy: DutchGuidedVisitStrategy
};
