var POI = require("./poi.js").Poi;
var CATEGORY = require("./category.js");
var db = require("./DBManager.js");

var PoiViewControllerStrategy = function(iD) {
	this.id = iD;
};

PoiViewStrategy.prototype.getId = function() {
	return this.id;
};

PoiViewStrategy.prototype.poiSortList = function() {
  throw new Error("A language strategy needs to be defined to get the sorted list of itineraries");
};

PoiViewStrategy.prototype.displayPoi = function(poiNumber) {
  var res = db.runQuery('SELECT * FROM Itinerary WHERE id = %@', this.id);
  var currentPoi = res[poiNumber];
  console.log(currentPoi.print());
};

//ADAPTATIONS
ENGuidedTourPoiViewControllerStrategy = function() {};
ENGuidedTourPoiViewControllerStrategy.prototype = Object.create(PoiViewControllerStrategy.prototype);
ENGuidedTourPoiViewControllerStrategy.prototype.poiSortList = function() {
  var res = db.runQuery('SELECT * FROM Itinerary WHERE language = EN AND id = %d', 1);
  return this.sort(res[0]);
};

FRGuidedTourPoiViewControllerStrategy = function() {};
FRGuidedTourPoiViewControllerStrategy.prototype = Object.create(PoiViewControllerStrategy.prototype);
FRGuidedTourPoiViewControllerStrategy.prototype.poiSortList = function() {
  var res = db.runQuery('SELECT * FROM Itinerary WHERE language = FR AND id = %d', 1);
  return this.sort(res[0]);
};

NLGuidedTourPoiViewControllerStrategy = function() {};
NLGuidedTourPoiViewControllerStrategy.prototype = Object.create(PoiViewControllerStrategy.prototype);
NLGuidedTourPoiViewControllerStrategy.prototype.poiSortList = function() {
  var res = db.runQuery('SELECT * FROM Itinerary WHERE language = NL AND id = %d', 1);
  return this.sort(res[0]);
};

ENPoiViewControllerStrategy = function() {};
ENPoiViewControllerStrategy.prototype = Object.create(PoiViewControllerStrategy.prototype);
ENPoiViewControllerStrategy.prototype.poiSortList = function() {
  var res = db.runQuery('SELECT * FROM Itinerary WHERE language = EN AND id = %d', 1);
  return res[0];
};

FRPoiViewControllerStrategy = function() {};
FRPoiViewControllerStrategy.prototype = Object.create(PoiViewControllerStrategy.prototype);
FRPoiViewControllerStrategy.prototype.poiSortList = function() {
  var res = db.runQuery('SELECT * FROM Itinerary WHERE language = FR AND id = %d', 1);
  return res[0];
};

NLPoiViewControllerStrategy = function() {};
NLPoiViewControllerStrategy.prototype = Object.create(PoiViewControllerStrategy.prototype);
NLPoiViewControllerStrategy.prototype.poiSortList = function() {
  var res = db.runQuery('SELECT * FROM Itinerary WHERE language = NL AND id = %d', 1);
  return res[0];
};

GuidedTourPoiViewControllerStrategy = function() {};
GuidedTourPoiViewControllerStrategy.prototype = Object.create(PoiViewControllerStrategy.prototype);
GuidedTourPoiViewControllerStrategy.prototype.displayPoi = function(poiNumber, itinerary) {
  var res = db.runQuery('SELECT * FROM Itinerary WHERE id = %@', itinerary);
  var currentPoi = res[poiNumber];
  console.log(currentPoi.print());
  console.log("Next POI");
  console.log(res[poiNumber + 1]);
};

TimePoiViewControllerStrategy = function() {};
TimePoiViewControllerStrategy.prototype = Object.create(PoiViewControllerStrategy.prototype);
TimePoiViewControllerStrategy.prototype.displayPoi = function(poiNumber) {
  var res = db.runQuery('SELECT * FROM Itinerary WHERE id = %@', this.id);
  var currentPoi = res[poiNumber];
  console.log(currentPoi.print());
};

KidPoiViewControllerStrategy = function() {};
KidPoiViewControllerStrategy.prototype = Object.create(PoiViewControllerStrategy.prototype);
KidPoiViewControllerStrategy.prototype.displayPoi = function(poiNumber) {
  var res = db.runQuery('SELECT * FROM Itinerary WHERE id = %@', 1);
  var currentPoi = res[poiNumber];
  console.log(currentPoi.print());
};

SimplePoiViewControllerStrategy = function() {};
SimplePoiViewControllerStrategy.prototype = Object.create(PoiViewControllerStrategy.prototype);
SimplePoiViewControllerStrategy.prototype.displayPoi = function() {
  console.log("Simple Poi display");
};

LowMemoryPoiViewControllerStrategy = function() {};
LowMemoryPoiViewControllerStrategy.prototype = Object.create(PoiViewControllerStrategy.prototype);

ColoredCategoriesPoiViewControllerStrategy = function() {};
ColoredCategoryPoiViewControllerStrategy.prototype = Object.create(PoiViewControllerStrategy.prototype);
ColoredCategoriesPoiViewControllerStrategy.prototype.displayPoi = function(poiNumber, itinerary) {
  var res = db.runQuery('SELECT * FROM Itinerary WHERE id = %@', itinerary);
  var caegories = db.runQuery('SELECT * FROM Category');
  for(var j=0; j<categories.length; j++) {
    console.log(categories[j] + " " + categories[j].name);
    for(var i=0; i<res.length; i++) {
      if(res[i].category == categories[j]) {
        res[i].print();
      }
    }
  }
};

//BEHAVIOR
var PoiViewController = function(strategy) {
  this.strategy = strategy;
};

PoiViewController.prototype.setStrategy = function(strategy) {
  this.strategy = strategy;
};

PoiViewController.prototype.getStrategy = function() {
  return this.strategy;
};

PoiViewController.prototype.displayPoi = function(poiNumber, itinerary) {
  this.strategy.displayPoi(poiNumber, itinerary);
};

module.exports = {
	PoiViewController: PoiViewController,
  ENPoiViewControllerStrategy: ENPoiViewControllerStrategy,
  FRPoiViewControllerStrategy: FRPoiViewControllerStrategy,
  NLPoiViewControllerStrategy: NLPoiViewControllerStrategy,
  ENGuidedTourPoiViewControllerStrategy: ENGuidedTourPoiViewControllerStrategy,
  FRGuidedTourPoiViewControllerStrategy: FRGuidedTourPoiViewControllerStrategy,
  NLGuidedTourPoiViewControllerStrategy: NLGuidedTourPoiViewControllerStrategy,
  GuidedTourPoiViewControllerStrategy: GuidedTourPoiViewControllerStrategy,
  TimePoiViewControllerStrategy: TimePoiViewControllerStrategy,
  KidPoiViewControllerStrategy: KidPoiViewControllerStrategy,
  SimplePoiViewControllerStrategy: SimplePoiViewControllerStrategy,
  ColoredCategoriesPoiViewControllerStrategy: ColoredCategoriesPoiViewControllerStrategy,
  LowMemoryPoiViewControllerStrategy: LowMemoryPoiViewControllerStrategy,
};
