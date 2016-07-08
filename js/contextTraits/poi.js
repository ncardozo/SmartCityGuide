var Trait = require("traits").Trait;
var cop = require("context-traits");
var Schedule = require("./schedule.js");
var Category = require("./category.js");

TPoiOperations = Trait({
	getDescription: function() {
		throw new Error("A language needs to be defined to get the description");
	},
	setDescription: function(descr) {
		this.description = descr;
	},
	getName: function() {
		throw new Error("A language needs to be defined to get the name");
	},
	setName: function(nam) {
		this.name = nam;
	},
	getAddress: function() {
		throw new Error("A language needs to be specified to get the address");
	},
	setAddress: function(addr) {
		throw new Error("A language needs to be specified to get the address");
	},
	addCategory: function(cat) {
		this.category = cat;
	},
	getCategory: function() {
		return this.category;
	},
	setState: function(newState) {
		this.state = newState;
	},
	isClosed: function() {
		return this.schedule.isInSchedule(new Date(Date.now()));
	},
	getImage: function() {
		throw new Error("A time needs to be defined to get the POI image");
	},
	setImage: function(img) {
		throw new Error("A time needs to be defined to specify the POI image");
	},
	distanceBetween:function(x, y) {

	},
	print: function() {
		console.log("POI information");
		console.log(this.getId());
		console.log(this.getName());
		console.log(this.getDescription());
		console.log(this.getAddress());
		console.log(this.image());
		console.log(this.state());
		console.log(this.isClosed() ? "Closed" : "Open");
	}
});

function TPoi(nid, name, add, desc, img, lat, long, cat, s) {
	return Trait.compose(TPoiOperations,
		Trait({
			id: nid,
			name: name,
			address: add,
			state: "Not visited",
			description: desc,
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

TEnglishPoiOperations = Trait({
	englishName: "",
	englishDescription: "",
	getName: function() {
		var res = db.runQuery('SELECT name FROM Poi WITH language = %@ AND id_poi = %d', 'EN', this.id);
		return res[0];
	},
	setName: function(name) {
		db.runQuery('INSERT INTO Poi (name) VALUES (%@) SELECT FROM Poi name WHERE id_poi = %d AND language = EN', name, this.id);
	},
	getDescription: function() {
		var res = db.runQuery('SELECT description FROM Poi WITH language = %@ AND id_poi = %d', 'EN', this.id);
		return res[0];
	},
	setDescription: function(desc) {
		db.runQuery('INSERT INTO Poi (description) VALUES (%@) SELECT FROM Poi name WHERE id_poi = %d AND language = EN', desc, this.id);
	},
	getAddress: function() {
		var res = db.runQuery('SELECT address FROM Poi WITH language = %@ AND id_poi = %d', 'EN', this.id);
		return res[0];
	},
	setAddress: function(address) {
		db.runQuery('INSERT INTO Poi (address) VALUES (%@) SELECT FROM Poi name WHERE id_poi = %d AND language = EN', address, this.id);
	}
});

TFrenchPoiOperations = Trait({
	getName: function() {
		var res = db.runQuery('SELECT name FROM Poi WITH language = %@ AND id_poi = %d', 'FR', this.id);
		return res[0];
	},
	setName: function(name) {
		db.runQuery('INSERT INTO Poi (name) VALUES (%@) SELECT FROM Poi name WHERE id_poi = %d AND language = FR', name, this.id);
	},
	getDescription: function() {
		var res = db.runQuery('SELECT description FROM Poi WITH language = %@ AND id_poi = %d', 'FR', this.id);
		return res[0];
	},
	setDescription: function(desc) {
		db.runQuery('INSERT INTO Poi (description) VALUES (%@) SELECT FROM Poi name WHERE id_poi = %d AND language = FR', desc, this.id);
	},
	getAddress: function() {
		var res = db.runQuery('SELECT address FROM Poi WITH language = %@ AND id_poi = %d', 'FR', this.id);
		return res[0];
	},
	setAddress: function(address) {
		db.runQuery('INSERT INTO Poi (address) VALUES (%@) SELECT FROM Poi name WHERE id_poi = %d AND language = FR', address, this.id);
	}
});

TDutchPoiOperations = Trait({
	getName: function() {
		var res = db.runQuery('SELECT name FROM Poi WITH language = %@ AND id_poi = %d', 'NL', this.id);
		return res[0];
	},
	setName: function(name) {
		db.runQuery('INSERT INTO Poi (name) VALUES (%@) SELECT FROM Poi name WHERE id_poi = %d AND language = NL', name, this.id);
	},
	getDescription: function() {
		var res = db.runQuery('SELECT description FROM Poi WITH language = %@ AND id_poi = %d', 'NL', this.id);
		return res[0];
	},
	setDescription: function(desc) {
		db.runQuery('INSERT INTO Poi (description) VALUES (%@) SELECT FROM Poi name WHERE id_poi = %d AND language = NL', desc, this.id);
	},
	getAddress: function() {
		var res = db.runQuery('SELECT address FROM Poi WITH language = %@ AND id_poi = %d', 'NL', this.id);
		return res[0];
	},
	setAddress: function(address) {
		db.runQuery('INSERT INTO Poi (address) VALUES (%@) SELECT FROM Poi name WHERE id_poi = %d AND language = NL', address, this.id);
	}
});

TKidEnglishPoiOperations = Trait({
	getDescription: function() {
		var res = db.runQuery('SELECT description FROM Poi WITH type = KID AND language = EN AND id_poi = %d', this.id);
		return res[0];
	}
});

TKidFrenchPoiOperations = Trait({
	getDescription: function() {
			var res = db.runQuery('SELECT description FROM Poi WITH type = KID AND language = FR AND id_poi = %d', this.id);
			return res[0];
	}
});

TKidDutchPoiOperations = Trait({
	getDescription: function() {
			var res = db.runQuery('SELECT description FROM Poi WITH type = KID AND language = NL AND id_poi = %d', this.id);
			return res[0];
	}
});

TMorningPoiOperations = Trait({
	getImage: function() {
		return db.runQuery('SELECT img FROM Poi_Image WHERE name = %@', 'Morning'+ this.image);
	}
});

TAfternoonPoiOperations = Trait({
	getImage: function() {
		return db.runQuery('SELECT img FROM Poi_Image WHERE name = %@', 'Afternoon_'+this.image);
	}
});

TNightPoiOperations = Trait({
	getImage: function() {
		return db.runQuery('SELECT img FROM Poi_Image WHERE name = %@', 'Night_'+this.image);
	}
});


module.exports = {
	Poi: Poi,
	TPoiOperations: TPoiOperations,
	TDutchPoiOperations: TDutchPoiOperations,
	TFrenchPoiOperations: TFrenchPoiOperations,
	TEnglishPoiOperations: TEnglishPoiOperations,
	TKidDutchPoiOperations: TKidDutchPoiOperations,
	TKidFrenchPoiOperations: TKidFrenchPoiOperations,
	TKidEnglishPoiOperations: TKidEnglishPoiOperations,
	TMorningPoiOperations: TMorningPoiOperations,
	TAfternoonPoiOperations: TAfternoonPoiOperations,
	TNightPoiOperations: TNightPoiOperations
};
