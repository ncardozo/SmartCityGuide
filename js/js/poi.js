var Schedule = require("./schedule.js");
var Category = require("./category.js");
var db = require("./DBManager.js");


var PoiStrategy = function(nid) {
	this.id = nid;
	this.state = "Not visited";
};

PoiStrategy.prototype.setId = function(id) {
	this.id = id;
};

PoiStrategy.prototype.getId = function() {
	return this.id;
};

PoiStrategy.prototype.getDescription = function() {
	throw new Error("A language strategy needs to be defined to get the language description");
};

PoiStrategy.prototype.setDescription = function(descr) {
	throw new Error("A language strategy needs to be defined to specify the language description");
};

PoiStrategy.prototype.getName = function() {
	throw new Error("A language strategy needs to be defined to get the language name");
};

PoiStrategy.prototype.setName = function(nam) {
	throw new Error("A language strategy needs to be defined to specify the language name");
};

PoiStrategy.prototype.addCategory = function(cat) {
	this.category = cat;
};

PoiStrategy.prototype.getCategory = function() {
	return this.category;
};

PoiStrategy.prototype.setState = function(newState) {
	this.state = newState;
};

PoiStrategy.prototype.getState = function() {
	return this.state;
};

PoiStrategy.prototype.isClosed = function() {
	return this.schedule.isInSchedule(new Date(Date.now()));
};

PoiStrategy.prototype.setImage = function() {
	throw new Error("A time strategy needs to be defined to specify the POI image");
};

PoiStrategy.prototype.getImage = function() {
	throw new Error("A time strategy needs to be defined to get the POI image");
};

PoiStrategy.prototype.setLatitude = function(latitude) {
	this.latitude = latitude;
};

PoiStrategy.prototype.setLongitude = function(long) {
	this.longitude = long;
};

PoiStrategy.prototype.setSchedule = function(schedule) {
	this.schedule = schedule;
};

//--- ADAPTATIONS
var DayPoiStrategy = function() {};
MorningPoiStrategy.prototype = Object.create(PoiStrategy.prototype);
MorningPoiStrategy.prototype.getImage = function() {
	return db.runQuery('SELECT img FROM Poi_Image WHERE name = %@', 'Morning'+this.image);
};

var AfternoonPoiStrategy = function() {};
AfternoonPoiStrategy.prototype = Object.create(PoiStrategy.prototype);
AfternoonPoiStrategy.prototype.getImage = function() {
	return db.runQuery('SELECT img FROM Poi_Image WHERE name = %@', 'Afternoon_'+this.image);
};

var NightPoiStrategy = function(){};
NightPoiStrategy.prototype = Object.create(PoiStrategy.prototype);
NightPoiStrategy.prototype.getImage = function() {
	return db.runQuery('SELECT img FROM Poi_Image WHERE name = %@', 'Night_'+this.image);
};

var EnglishPoiStrategy = function(){};
EnglishPoiStrategy.prototype = Object.create(PoiStrategy.prototype);
EnglishPoiStrategy.prototype.getName = function() {
	var res = db.runQuery('SELECT name FROM Poi WITH language = %@ AND id_poi = %d', 'EN', this.id);
	return res[0];
};

EnglishPoiStrategy.prototype.getAddress = function() {
	var res = db.runQuery('SELECT address FROM Poi WITH language = %@ AND id_poi = %d', 'EN', this.id);
	return res[0];
};

EnglishPoiStrategy.prototype.getDescription = function() {
	var res = db.runQuery('SELECT description FROM Poi WITH language = %@ AND id_poi = %d', 'EN', this.id);
	return res[0];
};

var FrenchPoiStrategy = function(){};
FrenchPoiStrategy.prototype = Object.create(PoiStrategy.prototype);
FrenchPoiStrategy.prototype.getName = function() {
	var res = db.runQuery('SELECT name FROM Poi WITH language = %@ AND id_poi = %d', 'FR', this.id);
	return res[0];
};

FrenchPoiStrategy.prototype.getAddress = function() {
	var res = db.runQuery('SELECT address FROM Poi WITH language = %@ AND id_poi = %d', 'FR', this.id);
	return res[0];
};

FrenchPoiStrategy.prototype.getDescription = function() {
	var res = db.runQuery('SELECT description FROM Poi WITH language = %@ AND id_poi = %d', 'FR', this.id);
	return res[0];
};

var DutchPoiStrategy = function(){};
DutchPoiStrategy.prototype = Object.create(PoiStrategy.prototype);
DutchPoiStrategy.prototype.getName = function() {
	var res = db.runQuery('SELECT name FROM Poi WITH language = %@ AND id_poi = %d', 'NL', this.id);
	return res[0];
};

DutchPoiStrategy.prototype.getAddress = function() {
	var res = db.runQuery('SELECT address FROM Poi WITH language = %@ AND id_poi = %d', 'NL', this.id);
	return res[0];
};

DutchPoiStrategy.prototype.getDescription = function() {
	var res = db.runQuery('SELECT description FROM Poi WITH language = %@ AND id_poi = %d', 'NL', this.id);
	return res[0];
};

var KidENPoiStrategy = function() {};
KidENPoiStrategy.prototype.getDescription = function() {
		var res = db.runQuery('SELECT description FROM Poi WITH type = KID AND language = EN AND id_poi = %d', this.id);
};

var KidFRPoiStrategy = function() {};
KidFRPoiStrategy.prototype.getDescription = function() {
		var res = db.runQuery('SELECT description FROM Poi WITH type = KID AND language = FR AND id_poi = %d', this.id);
};

var KidNLPoiStrategy = function() {};
KidNLPoiStrategy.prototype.getDescription = function() {
		var res = db.runQuery('SELECT description FROM Poi WITH type = KID AND language = NL AND id_poi = %d', this.id);
};


var Poi = function(id, name, address, description, image, latitude, longitude, category, schedule, strategy) {
	this.strategy = strategy;
	this.strategy.setId(id);
	this.strategy.setName(name);
	this.strategy.setAddress(address);
	this.strategy.setDescription(description);
	this.strategy.setImage(image);
	this.strategy.setLatitude(latitude);
	this.strategy.setLongitude(longitude);
	this.strategy.addCategory(category);
	this.strategy.setSchedule(schedule);
};

//--- BEHAVIOR
Poi.prototype.setStrategy = function(strategy) {
	this.strategy = strategy;
};

Poi.prototype.id = function() {
	return this.strategy.getId();
};

Poi.prototype.name = function() {
	return this.strategy.getName();
};

Poi.prototype.setName = function(name) {
	this.strategy.setName(name);
};

Poi.prototype.description = function() {
	return this.strategy.getDescription();
};

Poi.prototype.setDescription = function(description) {
	this.strategy.setDescription(description);
};

Poi.prototype.image = function() {
	return this.strategy.getImage();
};

Poi.prototype.isClosed = function() {
	return this.strategy.isClosed();
};

Poi.prototype.addCategory = function(category) {
	this.strategy.addCategory(category);
};

Poi.prototype.gerCategory = function() {
	this.strategy.getCategory();
};

Poi.prototype.state = function() {
	this.strategy.getState();
};

Poi.prototype.setState = function(state) {
	this.strategy.setState();
};

Poi.prototype.distanceBetween = function() {

};

Poi.prototype.print = function() {
	console.log("POI information");
	console.log(this.strategy.getId());
	console.log(this.strategy.getName());
	console.log(this.strategy.getDescription());
	console.log(this.strategy.image());
	console.log(this.strategy.state());
	console.log(this.strategy.isClosed() ? "Closed" : "Open");
};

module.exports = {
	Poi: Poi,
	PoiStrategy: PoiStrategy,
	EnglishPoiStrategy: EnglishPoiStrategy,
	FrenchPoiStrategy: FrenchPoiStrategy,
	DutchPoiStrategy: DutchPoiStrategy,
	DayPoiStrategy: DayPoiStrategy,
	AfternoonPoiStrategy: AfternoonPoiStrategy,
	NightPoiStrategy: NightPoiStrategy,
	KidENPoiStrategy: KidENPoiStrategy,
	KidFRPoiStrategy: KidFRPoiStrategy,
	KidNLPoiStrategy: KidNLPoiStrategy,
};
