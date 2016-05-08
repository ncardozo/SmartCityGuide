var POI = require("./poi.js");
var db = require("./DBManager.js");

var ItineraryStrategy = function() {
	this.itineraryPOIs = [];
	this.count = 0;
	this.currentPOI = 0;
};
ItineraryStrategy.prototype.getDescription = function() {
	throw new Error("A language strategy needs to be defined to get the Itinerary name");
};

ItineraryStrategy.prototype.setDescription = function(desc) {
	throw new Error("A language strategy needs to be defined to set the town name");
};

ItineraryStrategy.prototype.addPOI = function(poi) {
	this.itineraryPOIs[this.itineraryPOIs.length] = poi;
	this.count = this.count + 1;
};

ItineraryStrategy.prototype.currentPOI = function(num) {
	this.currentPOI = num;
};

ItineraryStrategy.prototype.getItineraryPOIs = function() {
	return this.itineraryPOIs;
};

//--- ADAPTATIONS
var EnglishItineraryStrategy = function() {};
EnglishItineraryStrategy.prototype = Object.create(ItineraryStrategy.prototype);
EnglishItineraryStrategy.prototype.getDescription = function() {
	var res = db.runQuery('SELECT description FROM Itinerary WHERE language = %@ AND id = ', 'EN', this.id);
	return res[0];
};

var FrenchItineraryStrategy = function() {};
FrenchItineraryStrategy.prototype = Object.create(ItineraryStrategy.prototype);
FrenchItineraryStrategy.prototype.getDescription = function() {
	var res = db.runQuery('SELECT description FROM Itinerary WHERE language = %@ AND id = ', 'FR', this.id);
	return res[0];
};

var DutchItineraryStrategy = function() {};
DutchItineraryStrategy.prototype = Object.create(ItineraryStrategy.prototype);
DutchItineraryStrategy.prototype.getDescription = function() {
	var res = db.runQuery('SELECT description FROM Itinerary WHERE language = %@ AND id = ', 'NL', this.id);
	return res[0];
};

//--- BEHAVIOR
var Itinerary = function(iD, description, strategy) {
	this.strategy = strategy;
	this.strategy.setId(iD);
	this.strategy.setDescription(description);
};

Itinerary.prototype.description = function() {
	return this.strategy.getDescription();
};

Itenerary.prototype.addDescription = function(desc) {
	this.strategy.setDescription(desc);
};

ItineraryStrategy.prototype.getItineraryPOIs = function() {
	return this.strategy.getItineraryPOIs();
};


module.exports = {
	Itinerary: Itinerary,
	DutchItineraryStrategy: DutchItineraryStrategy,
	FrenchItineraryStrategy: FrenchItineraryStrategy,
	EnglishItineraryStrategy: EnglishItineraryStrategy,
	ItineraryStrategy: ItineraryStrategy
};
