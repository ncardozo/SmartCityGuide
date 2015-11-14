var test = require('unit.js');
var Poi = require("./../poi.js");
var Schedule = require("./../schedule.js");
var Town = require("./../town.js");

function testCreateTown() {
	var town = Town(1, "Louvain-la-Neuve");
	test.assert.equal(town.name, "Louvain-la-Neuve", 'The created name is not as expected');
	test.array(town.pois).is([]); // 'Towns are not created with empty sets of POIs');
}

function testAddPOI() {
	var town = Town(1, "Louvain-la-Neuve");
	var n = "Place Sainte Barbe";
	var currentLang = "fr";
	var desc = "La Place Sainte-Barbe est située au coeur du quartier scientifique de Louvain-la-Neuve. Elle est jallonée par des batiments tels que le Réaumur, qui abrite des sales didactiques ainsi que des laboratoires, mais aussi par des auditoires de cours, dans le bâtiment Sainte Barbe";
	var lat = 50.668392;
	var longi = 4.621994;
	var img = {path: "barbe1.jpg", time:"day", desc: "Pour Josef, de la part des étudiants"};
	var cat = "SQUARE";
	var s = Schedule();
	var p = Poi(1, "place-sainte barbe", currentLang, img, lat, longi, cat, s);
	town.addPOI(p);
	var arr = [p];
	test.array(town.pois).is(arr);
}


console.log("Town Creation [/1]");
testCreateTown();
console.log("Town manipulation [/1]");
testAddPOI();