var ContextManager = require("./contextManager.js");
var db = require("./DBManager.js");

var GuidedVisitStrategy = function() {
	this.id = -1;
	this.itineraryList = [];
	this.description = "";
	this.annotations = new Map();  //map view annotated with all pois {(lat, long), annotation}
	this.currentItinerary = currentIti; //int
	this.currentPOI = currentPoi;
};

GuidedVisitStrategy.prototype.setDescription = function(desc) {
		throw new Error("A language strategy needs to be defined to set the GuidedVisit description");
};

GuidedVisitStrategy.prototype.getDescription = function() {
		throw new Error("A language strategy needs to be defined to get the GuidedVisit description");
};

GuidedVisitStrategy.prototype.updateItineraries = function() {

};

GuidedVisitStrategy.prototype.addPoiAnnotations = function() {
		var pois = this.currentIninerary.itineraryPOIs;
		for(i=0; i<pois.length; i++) {
			var poi = pois[i];
			var pos = [poi.latitude, poi.longitude];
			this.annotations[pos] = {
										"poi": poi.name[poi.language],
										"state": poi.state
									};
		}
};

GuidedVisitStrategy.prototype.setItinerary = function(id) {
		if(typeof this.itineraryList[id] !== 'undefined') {
			this.currentItinerary = this.itineraryList[id];
		}
};

GuidedVisitStrategy.prototype.checkNearestPoit = function() {

};

GuidedVisitStrategy.prototype.refreshAnnotations = function() {

};

GuidedVisitStrategy.prototype.hideItineraryChoice = function(choice) {

};

GuidedVisitStrategy.prototype.nextPoi = function() {

};

GuidedVisitStrategy.prototype.cancelItinerary = function() {

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


module.exports = {
	GuidedVisit: GuidedVisit,
	GuidedVisitStrategy: GuidedVisitStrategy,
	EnglishGuidedVisitStrategy: EnglishGuidedVisitStrategy,
	FrenchGuidedVisitStrategy: FrenchGuidedVisitStrategy,
	DutchGuidedVisitStrategy: DutchGuidedVisitStrategy
};
