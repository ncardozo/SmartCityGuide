var Trait = require("traits").Trait;
var cop = require("context-traits");
var POI = require("./poi.js");
var db = require("./DBManager.js");

TItineraryOperations = Trait({
  getDescription: function() {
  	throw new Error("A language strategy needs to be defined to get the Itinerary name");
  },
  setDescription: function(desc) {
  	throw new Error("A language strategy needs to be defined to set the town name");
  },
  addPOI: function(poi) {
  	this.itineraryPOIs[this.itineraryPOIs.length] = poi;
  	this.count = this.count + 1;
  },
  setCurrentPOI: function(num) {
  	this.currentPOI = num;
  },
  getItineraryPOIs: function() {
  	return this.itineraryPOIs;
  },
  setUser: function(userId) {
  	this.user = userId;
  }
});

//--- ADAPTATIONS
TEnglishItineraryOperations = Trait({
  getDescription: function() {
	  var res = db.runQuery('SELECT description FROM Itinerary WHERE language = %@ AND id = %d', 'EN', this.id);
	  return res[0];
  },
  setDescription: function(desc) {
    db.runQuery('INSERT INTO Itinerary (description) VALUES (%@) SELECT FROM Itinerary WHERE id_itinerary = %d AND language = EN', desc, this.id);
  }
});

TFrenchItineraryOperations = Trait({
  getDescription: function() {
	   var res = db.runQuery('SELECT description FROM Itinerary WHERE language = %@ AND id = %d', 'FR', this.id);
	    return res[0];
  },
  setDescription: function(desc) {
    db.runQuery('INSERT INTO Itinerary (description) VALUES (%@) SELECT FROM Itinerary WHERE id_itinerary = %d AND language = FR', desc, this.id);
  }
});

TDutchItineraryOperations = Trait({
  getDescription: function() {
	  var res = db.runQuery('SELECT description FROM Itinerary WHERE language = %@ AND id = %d', 'NL', this.id);
	  return res[0];
  },
  setDescription: function(desc) {
    db.runQuery('INSERT INTO Itinerary (description) VALUES (%@) SELECT FROM Itinerary WHERE id_itinerary = %d AND language = NL', desc, this.id);
  }
});

//--- BEHAVIOR
function TItinerary(iD) {
	return Trait.compose(TItineraryOperations, Trait({
    id: iD,
    itineraryPOIs: [],
  	count: 0,
  	currentPOI: 0,
  	user: -1,
  }));
}

function Itinerary(id) {
  return Object.create(Object.prototype, TItinerary(id));
}


module.exports = {
	Itinerary: Itinerary,
  TEnglishItineraryOperations: TEnglishItineraryOperations,
  TFrenchItineraryOperations: TFrenchItineraryOperations,
	TDutchItineraryOperations: TDutchItineraryOperations,
	TItineraryOperations: TItineraryOperations
};
