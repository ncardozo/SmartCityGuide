var Trait = require("traits").Trait;
var cop = require("context-traits");
var POI = require("./poi.js");
var db = require("./DBManager.js");

TCategoryOperations = trait({
  getId: function() {
    return this.id;
  },
  getName: function() {
  	throw new Error("A language needs to be defined to get the name");
  },
  setName: function() {
    throw new Error("A language needs to be specified to define the name");
  },
  getColor: function() {
  	return this.color;
  },
  setColor: function(color) {
  	this.color = color;
  }
});

//--- ADAPTATIONS
TEnglishCategoryOperations = Trait({
  getName: function() {
	   var res = db.runQuery('SELECT name FROM Category WHERE language = %@ AND id = ', 'EN', this.id);
	    return res[0];
  },
  setName: function(name) {
    db.runQuery('INSERT INTO Category (name) VALUES (%@) SELECT FROM Category WHERE id_poi = %d AND language = EN', name, this.id);
  }
});

TFrenchCategoryOperations = Trait({
  getName: function() {
	  var res = db.runQuery('SELECT name FROM Category WHERE language = %@ AND id = ', 'FR', this.id);
	  return res[0];
  },
  setName: function(name) {
    db.runQuery('INSERT INTO Category (name) VALUES (%@) SELECT * FROM Category WHERE id_poi = %d AND language = FR', name, this.id);
  }
});

TDutchCategoryOperations = Trait({
  getName: function() {
	   var res = db.runQuery('SELECT name FROM Category WHERE language = %@ AND id = ', 'NL', this.id);
	    return res[0];
  },
  setName: function(name) {
    db.runQuery('INSERT INTO Category (name) VALUES (%@) SELECT * FROM Category WHERE id_poi = %d AND language = NL', name, this.id);
  }
});

//--- BEHAVIOR
function TCategory(nid, name, color) {
	return Trait.compose(TCategoryOperations,
		Trait({
			id: nid,
			name: name,
			color: color,
		}));
}

function Category(nid, name, color) {
	return Object.create(Object.prototype, TCategory(nid, name, color));
}


module.exports = {
	Category: Category,
	TCategoryOperations: TCategoryOperations,
	TEnglishCategoryOperations: TEnglishCategoryOperations,
	TFrenchCategoryOperations: TFrenchCategoryOperations,
	TDutchCategoryOperations: TDutchCategoryOperations
};
