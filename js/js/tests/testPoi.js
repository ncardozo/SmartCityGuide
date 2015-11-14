var Poi = require("./../poi.js");
var Schedule = require("./../schedule.js");
var test = require("unit.js");

var n = "Place Sainte Barbe";
var currentLang = "fr";
var desc = "La Place Sainte-Barbe est située au coeur du quartier scientifique de Louvain-la-Neuve. Elle est jallonée par des batiments tels que le Réaumur, qui abrite des sales didactiques ainsi que des laboratoires, mais aussi par des auditoires de cours, dans le bâtiment Sainte Barbe";
var lat = 50.668392;
var longi = 4.621994;
var img = {path: "barbe1.jpg", time:"day", desc: "Pour Josef, de la part des étudiants"};
var cat = "SQUARE";
var s = Schedule();

function testPoiCreate() {
	var p = Poi(1, "place-sainte barbe", currentLang, img, lat, longi, cat, s);
	p.addName(currentLang, n);
	p.addDescription(currentLang, desc);
	var lang = p.language;
	test.assert.equal(lang, currentLang, 'Checking the creation of the current lang');
	var name = p.getName();
	test.assert.equal(name, n, 'Checking the name of the poi in fr');
}

console.log("POI Creation");
testPoiCreate();