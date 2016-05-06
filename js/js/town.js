var POI = require("./poi.js");
var db = require("./DBManager.js");

var TownStrategy = function(id, name) {
	this.id = id;
	this.name = name;
	this.pois = [];
};

TownStrategy.prototype.setId = function(newId) {
	this.id = newId;
};

TownStrategy.prototype.getId = function() {
	return this.id;
};

TownStrategy.prototype.setName = function(newName) {
	throw new Error("A language strategy needs to be defined to set the town name");
};

TownStrategy.prototype.getName = function() {
	throw new Error("A language strategy needs to be defined to get the town name");
};

TownStrategy.prototype.addPOI = function(poi) {
	this.pois[this.pois.length] = poi;
};

TownStrategy.prototype.getPois = function() {
	return this.pois;
};

//--- ADAPTATIONS
var EnglishTownStrategy = function() {};
EnglishTownStrategy.prototype = Object.create(TownStrategy.prototype);
EnglishTownStrategy.prototype.getName = function() {
	var res = db.runQuery('SELECT name FROM Town WHERE language = %@ AND id = ', 'EN', this.id);
	return res[0];
};

var FrenchTownStrategy = function() {};
FrenchTownStrategy.prototype = Object.create(TownStrategy.prototype);
FrenchTownStrategy.prototype.getName = function() {
	var res = db.runQuery('SELECT name FROM Town WHERE language = %@ AND id = ', 'FR', this.id);
	return res[0];
};

var DutchTownStrategy = function() {};
DutchTownStrategy.prototype = Object.create(TownStrategy.prototype);
DutchTownStrategy.prototype.getName = function() {
	var res = db.runQuery('SELECT name FROM Town WHERE language = %@ AND id = ', 'NL', this.id);
	return res[0];
};

//--- BEHAVIOR
var Town = function(strategy, iD) {
	this.strategy = strategy;
	this.strategy.setId(iD);
};

Town.prototype.name = function() {
	return this.strategy.getName();
};

Town.prototype.setName = function(name) {
		this.strategy.setName();
};

Town.prototype.id = function() {
	return this.strategy.getId();
};

Town.prototype.pois = function() {
	return this.strategy.getPois();
};

module.exports = {
	Town: Town,
	TownStrategy: TownStrategy,
	EnglishTownStrategy: EnglishTownStrategy,
	FrenchTownStrategy: FrenchTownStrategy,
	DutchTownStrategy: DutchTownStrategy
};
