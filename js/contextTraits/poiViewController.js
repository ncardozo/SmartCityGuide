var Trait = require("traits").Trait;
var cop = require("context-traits");
var POI = require("./poi.js").Poi;
var CATEGORY = require("./category.js");
var db = require("./DBManager.js");

TPoiViewControllerOperations = Trait({
  getId: function() {
  	return this.id;
  },
  poiSortList: function() {
    throw new Error("A language strategy needs to be defined to get the sorted list of itineraries");
  },
  displayPoi: function(poiNumber) {
    var res = db.runQuery('SELECT * FROM Itinerary WHERE id = %@', this.id);
    var currentPoi = res[poiNumber];
    console.log(currentPoi.print());
  }
});

//ADAPTATIONS
TENGuidedTourPoiViewControllerOperations = Trait({
  poiSortList: function() {
    var res = db.runQuery('SELECT * FROM Itinerary WHERE language = EN AND id = %d', 1);
    return this.sort(res[0]);
  }
});

TFRGuidedTourPoiViewControllerOperations = Trait({
  poiSortList: function() {
    var res = db.runQuery('SELECT * FROM Itinerary WHERE language = FR AND id = %d', 1);
    return this.sort(res[0]);
  }
});

TNLGuidedTourPoiViewControllerOperations = Trait({
  poiSortList: function() {
    var res = db.runQuery('SELECT * FROM Itinerary WHERE language = NL AND id = %d', 1);
    return this.sort(res[0]);
  }
});

TENPoiViewControllerOperations = Trait({
  poiSortList: function() {
    var res = db.runQuery('SELECT * FROM Itinerary WHERE language = EN AND id = %d', 1);
    return res[0];
  }
});

TFRPoiViewControllerOperations = Trait({
  poiSortList: function() {
    var res = db.runQuery('SELECT * FROM Itinerary WHERE language = FR AND id = %d', 1);
    return res[0];
  }
});

TNLPoiViewControllerOperations = Trait({
  poiSortList: function() {
    var res = db.runQuery('SELECT * FROM Itinerary WHERE language = NL AND id = %d', 1);
    return res[0];
  }
});

TGuidedTourPoiViewControllerOperations = Trait({
  displayPoi: function(poiNumber, itinerary) {
    var res = db.runQuery('SELECT * FROM Itinerary WHERE id = %@', itinerary);
    var currentPoi = res[poiNumber];
    console.log(currentPoi.print());
    console.log("Next POI");
    console.log(res[poiNumber + 1]);
  }
});

TTimePoiViewControllerOperations = Trait({
  displayPoi: function(poiNumber) {
    var res = db.runQuery('SELECT * FROM Itinerary WHERE id = %@', this.id);
    var currentPoi = res[poiNumber];
    console.log(currentPoi.print());
  }
});

TKidPoiViewControllerOperations = Trait({
  displayPoi: function(poiNumber) {
    var res = db.runQuery('SELECT * FROM Itinerary WHERE id = %@', 1);
    var currentPoi = res[poiNumber];
    console.log(currentPoi.print());
  }
});

TSimplePoiViewControllerOperations = Trait({
  displayPoi: function() {
    console.log("Simple Poi display");
  }
});

TLowMemoryPoiViewControllerOperations = Trait({});

TColoredCategoriesPoiViewControllerOperations = Trait({
  displayPoi: function(poiNumber, itinerary) {
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
  }
});

//BEHAVIOR
function TPoiViewController(id) {
  return Trait.compose(TPoiViewControllerOperations, Trait({
    id: id,
  }));
}

function PoiViewController(id) {
  return Object.create(Object.prototype, TPoiViewController(id));
}


module.exports = {
	PoiViewController: PoiViewController,
  TENPoiViewControllerOperations: TENPoiViewControllerOperations,
  TFRPoiViewControllerOperations: TFRPoiViewControllerOperations,
  TNLPoiViewControllerOperations: TNLPoiViewControllerOperations,
  TENGuidedTourPoiViewControllerOperations: TENGuidedTourPoiViewControllerOperations,
  TFRGuidedTourPoiViewControllerOperations: TFRGuidedTourPoiViewControllerOperations,
  TNLGuidedTourPoiViewControllerOperations: TNLGuidedTourPoiViewControllerOperations,
  TGuidedTourPoiViewControllerOperations: TGuidedTourPoiViewControllerOperations,
  TTimePoiViewControllerOperations: TTimePoiViewControllerOperations,
  TKidPoiViewControllerOperations: TKidPoiViewControllerOperations,
  TSimplePoiViewControllerOperations: TSimplePoiViewControllerOperations,
  TColoredCategoriesPoiViewControllerOperations: TColoredCategoriesPoiViewControllerOperations,
  TLowMemoryPoiViewControllerOperations: TLowMemoryPoiViewControllerOperations,
};
