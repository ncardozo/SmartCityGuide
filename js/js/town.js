var Trait = require('traits.js').Trait;
var Poi = require("./poi.js");

var TTownOperations = Trait({
	addPOI: function(poi) {
		this.pois[this.pois.length] = poi;
	}
});

function TTown(iD, aName) {
	return Trait.compose(TTownOperations,
		Trait({
			id: iD,
			name: aName,
			pois: []
		}));
} 

function Town(iD, aName) {
	return Object.create(Object.prototype, TTown(iD, aName));
}

module.exports = Town;