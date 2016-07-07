var POI = require("./poi.js");
var CATEGORY = require("./category.js");
var ITINERARY = require("./itinerary");

//BEHAVIOR
var ToolsLangViewController = function() {
  this.langContexts = [];
};

ToolsLangViewController.prototye.tableView = function(view, index) {
  var newLangContext = langContexts[index];
  POI.Poi.setStrategy(eval("new POI."+newLangContext+"PoiStrategy()"));
  CATEGORY.Category.setStrategy(eval("new CATEGORY."+newLangContext+"CategoryStrategy()"));
  ITINERARY.Itinerary.setStrategy(eval("new ITINERARY."+newLangContext+"ItineraryStrategy()"));
};

ToolsLangViewController.prototye.addLangContext = function(lang) {
  this.langContexts.push(lang);
};


module.exports = {
  ToolsLangViewController: ToolsLangViewController,
};
