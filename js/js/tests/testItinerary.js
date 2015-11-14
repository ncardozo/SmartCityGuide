var test = require('unit.js');
var Poi = require("./../poi.js");
var Schedule = require("./../schedule.js");
var Itinerary = require("./../itinerary.js");



function testCreateItinerary() {
	var it = Itinerary(1);
	test.assert.equal(it.id, 1, 'The itinerary diesnt have the given id');
	test.assert.equal(it.count, 0, 'New itineraries have no POIs');
	test.assert.equal(it.currentPOI, 0, 'New itineraries have no current POIs');
	test.array(it.itineraryPOIs).is([]); // 'New itineraries have no POIs');
	test.object(it.descriptions).is({}); //'New itineraries have no description');
}

function testAddItineraryDescription() {
	var it = Itinerary(1, 0, 0);
	var desc = "Cette promenade va vous faire découvrir les plus belles places de Louvain-la-Neuve."
	it.addDescription("fr", desc)
	test.assert.equal(it.descriptions["fr"], desc, 'The added description is correctly returned');
}

function testAddPOI() {
	var it = Itinerary(1, 0, 0);
	var n = "Place Sainte Barbe";
	var currentLang = "fr";
	var desc = "La Place Sainte-Barbe est située au coeur du quartier scientifique de Louvain-la-Neuve. Elle est jallonée par des batiments tels que le Réaumur, qui abrite des sales didactiques ainsi que des laboratoires, mais aussi par des auditoires de cours, dans le bâtiment Sainte Barbe";
	var lat = 50.668392;
	var longi = 4.621994;
	var img = {path: "barbe1.jpg", time:"day", desc: "Pour Josef, de la part des étudiants"};
	var cat = "SQUARE";
	var s = Schedule();
	var poi = Poi(1, "place-sainte barbe", currentLang, img, lat, longi, cat, s);
	it.addPOI(poi);
	var count = it.count;
	test.assert.equal(it.count, 1, 'Poi added to the itinerary incorrectly count not incremented');
	test.assert.equal(it.itineraryPOIs.length, 1, 'There is 1 POI on the created itinerary');
}

function testSetCurrentPOI() {
	var it = Itinerary(1, 0, 0);
	var n = "Place Sainte Barbe";
	var currentLang = "fr";
	var desc = "La Place Sainte-Barbe est située au coeur du quartier scientifique de Louvain-la-Neuve. Elle est jallonée par des batiments tels que le Réaumur, qui abrite des sales didactiques ainsi que des laboratoires, mais aussi par des auditoires de cours, dans le bâtiment Sainte Barbe";
	var lat = 50.668392;
	var longi = 4.621994;
	var img = {path: "barbe1.jpg", time:"day", desc: "Pour Josef, de la part des étudiants"};
	var cat = "SQUARE";
	var s = Schedule();
	var poi = Poi(1, "Place-sainte barbe", currentLang, img, lat, longi, cat, s);
	it.addPOI(poi);
	it.setCurrentPOI(1);
	test.assert.equal(it.currentPOI, 1, 'The current POI has not been set correctly');
}

console.log("Itinerary Creation");
testCreateItinerary();
console.log("Itinerary Manipulation");
testAddItineraryDescription();
testAddPOI();
testSetCurrentPOI();