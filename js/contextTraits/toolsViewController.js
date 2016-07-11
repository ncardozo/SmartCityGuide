var Trait = require("traits").Trait;
var cop = require("context-traits");
var db = require("./DBManager.js");

TToolsViewControllerOperations = Trait({
  updateDataAction: function() {
    console.log("Displaying data regularly");
  },
  timeAdaptationToggled: function() {
      if(!Time.isActive()) {
          Time.activate();
      }
  },
  simpleInterfaceAdaptationToggled: function() {
    if(!Simple.isActive()) {
        Simple.activate();
    }
  },
  memoryAdaptationToggled: function() {
      if(!LowMemory.isActive()) {
          LowMemory.activate();
      }
  },
  colorAdaptationToggled: function() {
      if(!ColoredCategories.isActive()) {
          ColoredCategories.activate();
      }
  }
});

//ADAPTATIONS
TToolsViewControllerWifiOperations = Trait({
  updateDataAction: function() {
    concole.log("Wifi connection available");
  }
});

TToolsViewController3gOperations = Trait({
  updateDataAction: function() {
    console.log("3g connection available");
  }
});

TToolsViewControllerLowMemory = Trait({
  updateDataAction: function() {
    console.log("WARNING: The memory on the device is limited");
    LowMemory.activate();
  }
});

TToolsViewControllerLowBattery = Trait({
  updateDataAction: function() {
    console.log("WARNING: The battery level on this device is low");
  }
});

//BEHAVIOR
function ToolsViewController() {
  return Object.create(Object.prototype, TToolsViewControllerOperations);
}


module.exports = {
	ToolsViewController: ToolsViewController,
	TToolsViewControllerLowMemoryOperations: TToolsViewControllerLowMemoryOperations,
  TToolsViewControllerLowBatteryOperations: TToolsViewControllerLowBatteryOperations,
	TToolsViewController3gOperations: TToolsViewController3gOperations,
	TToolsViewControllerWifi: TToolsViewControllerWifi
};
