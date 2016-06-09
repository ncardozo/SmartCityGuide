var Trait = require("traits").Trait;
var cop = require("context-traits");
var Schedule = require("./schedule.js");
var Category = require("./category.js");

TPoiOperations = Trait({
	getDescription: function() {
		return this.description;
	},
	addDescription: function(descr) {
		this.description = descr;
	},
	getName: function() {
		return this.name;
	},
	addName: function(nam) {
		this.name = nam;
	},
	addCategory: function(cat) {
		this.category = cat;
	},
	setState: function(newState) {
		this.state = newState;
	},
	isClosed: function() {
		return this.schedule.isInSchedule(new Date(Date.now()));
	},
	getImage: function() {

	}
});

function TPoi(nid, name, add, desc, img, lat, long, cat, s) {
	return Trait.compose(TPoiOperations,
		Trait({
			id: nid,
			name: name, //language name map
			address: add,
			state: "Not visited",
			description: desc, //language description map
			image: img,
			latitude: lat,
			longitude: long,
			category: cat,
			schedule: s,
		}));
}

function Poi(nid, name add, desc, img, lat, longi, cat, s) {
	return Object.create(Object.prototype, TPoi(nid, name, add, desc, img, lat, longi, cat, s));
}

TPoiEnglishOperations = Trait({
	englishName: "",
	englishDescription: "",
	getName: function() {
		return this.englishName;
	},
	setName: function(name) {
		this.englishName = name;
	},
	getDescription: function() {
		return this.englishDescription;
	},
	setDescription: function(desc) {
		this.englishDescription = desc;
	}
});

TPoiFrenchOperations = Trait({
	frenchName: "",
	frenchDescription: "",
	getName: function() {
		return this.frenchName;
	},
	setName: function(name) {
		this.frenchName = name;
	},
	getDescription: function() {
		return this.frenchDescription;
	},
	setDescription: function(desc) {
		this.frenchDescription = desc;
	}
});

TPoiDutchOperations = Trait({
	dutchName: "",
	dutchDescription: "",
	getName: function() {
		return this.dutchName;
	},
	setName: function(name) {
		this.dutchName = name;
	},
	getDescription: function() {
		return this.dutchDescription;
	},
	setDescription: function(desc) {
		this.dutchDescription = desc;
	}
});

module.exports = {
	Poi: Poi,
	TPoiOperations: TPoiOperations,
	TPoiDutchOperations: TPoiDutchOperations,
	TPoiFrenchOperations: TPoiFrenchOperations,
	TPoiEnglishOperations: TPoiEnglishOperations
};
