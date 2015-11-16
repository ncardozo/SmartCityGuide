var Trait = require("traits.js").Trait;
var POI = require("./poi.js");

var CategoryOperations = Trait({
	name: function(lang) {
		return this.names[lang];
	},
	addName: function(lang, name) {
		this.names[lang] = name;
	},
	categoryColor: function() {
		return this.catColor;
	},
	addCategoryColor(color) {
		this.catColor = color;
	}
});

function TCategory(iD, color, languages, newNames) {
	var theNames = new Map();
	for(i = 0; i < languages.length; i++) {
		theNames[languages[i]] = newNames[i];
	}
	return Trait.compose(CategoryOperations,
		Trait({
			id: iD,
			catColor: color,
			names: theNames //names map {lang, name}
		}));
}

function Category(iD, color, languages, names) {
	return Object.create(Object.prototype, TCategory(iD, color, languages, names));
}


module.exports = Category;