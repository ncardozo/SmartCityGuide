var POI = require("./poi.js");
var db = require("./DBManager.js");

var CategoryStrategy = function(iD, color, name) {
	this.id = iD;
	this.color = color;
	this.name = name;
};

CategoryStrategy.prototype.getId = function() {
	return this.id;
};

CategoryStrategy.prototype.getName = function() {
	throw new Error("A language strategy needs to be defined to get the name");
};

CategoryStrategy.prototype.getColor = function() {
	return this.color;
};

CategoryStrategy.prototype.setColor = function(color) {
	this.color = color;
};

//--- ADAPTATIONS
var EnglishCategoryStrategy = function() {};
EnglishCategoryStrategy.prototype = Object.create(CategoryStrategy.prototype);
EnglishCategoryStrategy.prototype.getName = function() {
	var res = db.runQuery('SELECT name FROM Category WHERE language = %@ AND id = ', 'EN', this.id);
	return res[0];
};

EnglishCategoryStrategy.prototype.setColor = function(color) {
	Category.setStrategy(new CategoryStrategy());
	Category.setColor(color);
};

var FrenchCategoryStrategy = function() {};
FrenchCategoryStrategy.prototype = Object.create(CategoryStrategy.prototype);
FrenchCategoryStrategy.prototype.getName = function() {
	var res = db.runQuery('SELECT name FROM Category WHERE language = %@ AND id = ', 'FR', this.id);
	return res[0];
};

FrenchCategoryStrategy.prototype.setColor = function(color) {
	Category.setStrategy(new CategoryStrategy());
	Category.setColor(color);
};

var DutchCategoryStrategy = function() {};
DutchCategoryStrategy.prototype = Object.create(CategoryStrategy.prototype);
DutchCategoryStrategy.prototype.getName = function() {
	var res = db.runQuery('SELECT name FROM Category WHERE language = %@ AND id = ', 'NL', this.id);
	return res[0];
};

DutchCategoryStrategy.prototype.setColor = function(color) {
	Category.setStrategy(new CategoryStrategy());
	Category.setColor(color);
};

//--- BEHAVIOR
var Category = function(strategy, id, color, name) {
		this.strategy = strategy;
		this.strategy.setId(id);
		this.strategy.setName(name);
		this.strategy.setColor(color);
};

Category.prototype.setStrategy = function(strategy) {
	this.strategy = strategy;
};

Category.prototype.id = function() {
	return this.strategy.getId();
};

Category.prototype.name = function() {
	return this.strategy.getName();
};

Category.prototype.color = function() {
	return this.strategy.getColor();
};

Category.prototype.setColor = function(color) {
	this.color = color;
};


module.exports = {
	Category: Category,
	CategoryStrategy: CategoryStrategy,
	EnglishCategoryStrategy: EnglishCategoryStrategy,
	FrenchCategoryStrategy: FrenchCategoryStrategy,
	DutchItineraryStrategy: DutchItineraryStrategy
};
