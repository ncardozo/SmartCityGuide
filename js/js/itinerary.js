var POI = require("./poi.js");
var db = require("./DBManager.js");

var ItineraryStrategy = function() {
	this.itineraryPOIs = [];
	this.count = 0;
	this.currentPOI = 0;
	this.user = -1;
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

ItineraryStrategy.prototype.setUser = function(userId) {
	this.user = userId;
};

//--- ADAPTATIONS
var EnglishItineraryStrategy = function() {};
EnglishItineraryStrategy.prototype = Object.create(ItineraryStrategy.prototype);
EnglishItineraryStrategy.prototype.getDescription = function() {
	var res = db.runQuery('SELECT description FROM Itinerary WHERE language = %@ AND id = %d', 'EN', this.id);
	return res[0];
};

EnglishItineraryStrategy.prototype.setDescription = function(desc) {
	db.runQuery('INSERT INTO Itinerary (description) VALUES (%@) SELECT FROM Itinerary WHERE id_itinerary = %d AND language = EN', desc, this.id);
};

var FrenchItineraryStrategy = function() {};
FrenchItineraryStrategy.prototype = Object.create(ItineraryStrategy.prototype);
FrenchItineraryStrategy.prototype.getDescription = function() {
	var res = db.runQuery('SELECT description FROM Itinerary WHERE language = %@ AND id = %d', 'FR', this.id);
	return res[0];
};

FrenchtineraryStrategy.prototype.setDescription = function(desc) {
	db.runQuery('INSERT INTO Itinerary (description) VALUES (%@) SELECT FROM Itinerary WHERE id_itinerary = %d AND language = FR', desc, this.id);
};

var DutchItineraryStrategy = function() {};
DutchItineraryStrategy.prototype = Object.create(ItineraryStrategy.prototype);
DutchItineraryStrategy.prototype.getDescription = function() {
	var res = db.runQuery('SELECT description FROM Itinerary WHERE language = %@ AND id = %d', 'NL', this.id);
	return res[0];
};

DutchtineraryStrategy.prototype.setDescription = function(desc) {
	db.runQuery('INSERT INTO Itinerary (description) VALUES (%@) SELECT FROM Itinerary WHERE id_itinerary = %d AND language = NL', desc, this.id);
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
