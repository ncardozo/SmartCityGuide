var Trait = require("traits.js").Trait;
var Schedule = require("./schedule.js");
var Category = require("./category.js");

var TPoiOperations = Trait({
	getDescription: function() {
		return this.description.get(this.language);
	},
	addDescription: function(lang, descr) {
		this.description.set(lang, descr);
	},
	getName: function() {
		return this.name.get(this.language);
	},
	addName: function(lang, nam) {
		this.name.set(lang, nam);
	},
	addCategory: function(cat) {
		this.category = cat;
	},
	isClosed: function() {
		return this.schedule.isInSchedule(new Date(Date.now()));
	}
});

function TPoi(nid, add, currentLang, img, lat, long, cat, s) {
	return Trait.compose(TPoiOperations,
		Trait({
			id: nid,
			name: new Map(), //language name map
			address: add,
			description: new Map(), //language description map
			language: currentLang, //current language
			image: img,
			latitude: lat,
			longitude: long,
			category: cat,
			schedule: s,	
		}));
}

function Poi(nid, add, currentLang, img, lat, longi, cat, s) {
	return Object.create(Object.prototype, TPoi(nid, add, currentLang, img, lat, longi, cat, s));
}

module.exports = Poi;