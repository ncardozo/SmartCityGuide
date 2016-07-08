

var ContextViewController = function() {
  this.languages = ["EN", "FR", "NL"];
  this.classifications = ["CategoryPoiOrder", "ItineraryPoiOrder"];
  this.timeOfDay = ["Morning", "Afternoon", "Evening"];
  this.connections = ["WIFI", "CELLULAR", "NONE"];
  this.usage = ["LowMemory", "LowBattery", "GPS"];
  this.others = ["TimeAdaptation", "SimpleInterface", "PreferedPois", "GuidedTour"];
};

ContextViewController.prototype.tableView = function(view, index) {
    var contextName = this.contextNames[index];

    console.log(contextName);
    var imageView;
    imageView = "accept";
};


module.exports = {
  ContextViewController: ContextViewController  
};
