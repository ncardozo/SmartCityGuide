var POIViewController = require("./poiViewController.js");
var db = require("./DBManager.js");

var ToolsViewControllerStrategy = function() {
};

ToolsViewControllerStrategy.prototype.updateDataAction = function() {
  console.log("Displaying data regularly");
};

ToolsViewControllerStrategy.prototype.timeAdaptationToggled = function() {
    if(typeof POIViewController.PoiViewController.getStrategy() !== POIViewController.PoiViewControllerStrategy) {
        POIViewController.PoiViewController.setStrategy(new POIViewController.PoiViewControllerTime());
    }
};

ToolsViewControllerStrategy.prototype.simpleInterfaceAdaptationToggled = function() {
  if(typeof POIViewController.PoiViewController.getStrategy() !== POIViewController.PoiViewControllerStrategy) {
      POIViewController.PoiViewController.setStrategy(new POIViewController.PoiViewControllerSimple());
  }
};

ToolsViewControllerStrategy.prototype.memoryAdaptationToggled = function() {
    if(typeof POIViewController.PoiViewController.getStrategy() !== POIViewController.PoiViewControllerStrategy) {
        POIViewController.PoiViewController.setStrategy(new POIViewController.PoiViewControllerLowMemory());
    }
};

ToolsViewControllerStrategy.prototype.colorAdaptationToggled = function() {
    if(typeof POIViewController.PoiViewController.getStrategy() !== POIViewController.PoiViewControllerStrategy) {
        POIViewController.PoiViewController.setStrategy(new POIViewController.PoiViewControllerColoredCategories());
    }
};

//ADAPTATIONS
ToolsViewControllerWifi = function() {};

ToolsViewControllerWifi.prototype.updateDataAction = function() {
    concole.log("Wifi connection available");
};

ToolsViewController3g = function() {};

ToolsViewController3g.prototype.updateDataAction = function() {
  console.log("3g connection available");
};

ToolsViewControllerLowMemory = function() {};

ToolsViewControllerLowMemory.prototype.updateDataAction = function() {
  console.log("WARNING: The memory on the device is limited");
};

ToolsViewControllerLowBattery = function() {};

ToolsViewControllerLowBattery.prototype.updateDataAction = function() {
  console.log("WARNING: The battery level on this device is low");
};

//BEHAVIOR
var ToolsViewController = function(strategy) {
  this.strategy = strategy;
};

ToolsViewController.prototype.timeAdaptationToggled = function() {
  this.strategy.timeAdaptationToggled();
};

ToolsViewController.prototype.updateDataAction = function() {
    this.strategy.updateDataAction();
};

module.exports = {
	ToolsViewController: ToolsViewController,
	ToolsViewControllerStrategy: ToolsViewControllerStrategy,
	ToolsViewControllerLowMemory: ToolsViewControllerLowMemory,
  ToolsViewControllerLowBattery: ToolsViewControllerLowBattery,
	ToolsViewController3g: ToolsViewController3g,
	ToolsViewControllerWifi: ToolsViewControllerWifi
};
