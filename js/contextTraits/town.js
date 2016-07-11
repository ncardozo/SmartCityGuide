var Trait = require("traits").Trait;
var cop = require("context-traits");
var POI = require("./poi.js");
var db = require("./DBManager.js");

TTownStrategy = Trait({
  setId: function(newId) {
  	this.id = newId;
  },
  getId: function() {
  	return this.id;
  },
  setName: function(newName) {
  	throw new Error("A language strategy needs to be defined to set the town name");
  },
  getName: function() {
  	throw new Error("A language strategy needs to be defined to get the town name");
  },
  addPOI: function(poi) {
  	this.pois[this.pois.length] = poi;
  },
  getPois: function() {
  	return this.pois;
  }
});

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
function TTown(id, name) {
	return Trait.compose(TTownOperations, Trait({
    id: id,
  	name: name,
  	pois: []
  }));
}

function Town(id, name) {
  return Object.crate(Object.prototype, TTown(id, name));
}


module.exports = {
	Town: Town,
	TownStrategy: TownStrategy,
	EnglishTownStrategy: EnglishTownStrategy,
	FrenchTownStrategy: FrenchTownStrategy,
	DutchTownStrategy: DutchTownStrategy
};
