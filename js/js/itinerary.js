var Trait = require("traits.js").Trait;
var POI = require("./poi.js");

var ItineraryOperations = Trait({
	description: function(lang) {
		return this.descriptions[lang];
	},
	addDescription: function(lang, desc) {
		this.descriptions[lang] = desc;
	},
	addPOI: function(poi) {
		this.itineraryPOIs[this.itineraryPOIs.length] = poi;
		this.count = this.count + 1;
	},
	setCurrentPOI: function(num) {
		this.currentPOI = num;
	}
});

function TItinerary(iD, aCount, aCurrent) {
	return Trait.compose(ItineraryOperations,
		Trait({
			id: iD,
			count: aCount,
			currentPOI: aCurrent,
			descriptions: {}, //description map {lang, desc}
			itineraryPOIs: [] //Array of POI objects
		}));
}

function Itinerary(iD, aCount, aCurrent) {
	return Object.create(Object.prototype, TItinerary(iD, 0, 0));
}

module.exports = Itinerary;