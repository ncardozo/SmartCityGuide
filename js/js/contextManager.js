var db = require("./DBManager.js");
var externalip = require('externalip');
var geoip = require('geoip-lite');
var POI = require("./poi.js");
var CATEGORY = require("./category.js");
var TOWN = require("./town.js");
var ITINERARY =  require("./itinerary.js");
var TVC = require("./toolsViewController.js");
var PVC = require("./poiViewController.js");
var GUIDEDVISIT = require("./guidedVisit.js");

var ContextManager = function() {
  this.currentLocation = [];
  this.currentDay = new Date();
  this.currentLanguage = "EN";
};

ContextManager.prototype.updateLocation = function() {
  var extIp;
  externalip(function (err, ip) {
    extIp = ip;
  });
  this.currentLocation = geoip.lookup(extIp);
};

ContextManager.prototype.setLanguage = function(lang) {
  this.currentLanguage = lang;
  this.updateLanguage();
};

ContextManager.prototype.updateLanguage = function() {
  if(this.currentLanguage == "EN") {
    POI.Poi.setStrategy(new POI.EnglishPoiStrategy());
    CATEGORY.Category.setStrategy(new CATEGORY.EnglishCategoryStrategy());
    ITINERARY.Itinerary.setStrategy(new ITINERARY.EnglishItineraryStrategy());
    TOWN.Town.setStrategy(new TOWN.EnglishTownStrategy());
    PVC.PoiViewController.setStrategy(new PVC.ENPoiViewControllerStrategy());
    GUIDEDVISIT.GuidedVisit.setStrategy(new GUIDEDVISIT.EnglishGuidedVisitStrategy());
  } else if(this.currentLanguage == "FR") {
    POI.Poi.setStrategy(new POI.FrenchPoiStrategy());
    CATEGORY.Category.setStrategy(new CATEGORY.FrenchCategoryStrategy());
    ITINERARY.Itinerary.setStrategy(new ITINERARY.FrenchItineraryStrategy());
    TOWN.Town.setStrategy(new TOWN.FrenchTownStrategy());
    PVC.PoiViewController.setStrategy(new PVC.FRPoiViewControllerStrategy());
    GUIDEDVISIT.GuidedVisit.setStrategy(new GUIDEDVISIT.FrenchGuidedVisitStrategy());
  } else if(this.currentLanguage == "NL") {
    POI.Poi.setStrategy(new POI.DutchPoiStrategy());
    CATEGORY.Category.setStrategy(new CATEGORY.DutchCategoryStrategy());
    ITINERARY.Itinerary.setStrategy(new ITINERARY.DutchItineraryStrategy());
    TOWN.Town.setStrategy(new TOWN.DutchTownStrategy());
    PVC.PoiViewController.setStrategy(new PVC.NLPoiViewControllerStrategy());
    GUIDEDVISIT.GuidedVisit.setStrategy(new GUIDEDVISIT.DutchGuidedVisitStrategy());
  }
};

ContextManager.prototype.updateAudience = function(audience) {
  if(audience == "KID") {
    PVC.PoiViewController.setStrategy(new PVC.KidPoiViewControllerStrategy());
    if(this.currentLanguage == "EN") {
      POI.Poi.setStrategy(new POI.KidENPoiStrategy());
    } else if(this.currentLanguage == "FR") {
      POI.Poi.setStrategy(new POI.KidFRPoiStrategy());
    } else if(this.currentLanguage == "NL") {
      POI.Poi.setStrategy(new POI.KidNLPoiStrategy());
    }
  } else {
    POI.Poi.setStrategy(new POI.PoiStrategy());
    CATEGORY.Category.setStrategy(new CATEGORY.CategoryStrategy());
    ITINERARY.Itinerary.setStrategy(new ITINERARY.ItineraryStrategy());
    PVC.PoiViewController.setStrategy(new PVC.PoiViewControllerStrategy());
  }
};

ContextManager.prototype.updateDate = function() {
  this.currentDay = new Date();
  var hour = this.currentDay.getHours();
  PVC.PoiViewController.setStrategy(new PVC.TimePoiViewControllerStrategy());
  if(hour < 12) {
    POI.Poi.setStrategy(new POI.DayPoiStrategy());
  } else if(hour < 18) {
    POI.Poi.setStrategy(new POI.AfternoonPoiStrategy());
  } else {
    POI.Poi.setStrategy(new POI.NightPoiStrategy());
  }
};

ContextManager.prototype.updateConnectivityStatus = function(type) {
  if(type === "WIFI") {
    TVC.ToolsViewController.setStrategy(new TVC.ToolsViewControllerWifi());
  } else if(type === "CELLULAR") {
    TVC.ToolsViewController.setStrategy(new TVC.ToolsViewController3g());
  } else if(type === "NONE") {
    TVC.ToolsViewController.setStrategy(new TVC.ToolsViewControllerStrategy());
  }
};

ContextManager.prototype.updateMemory = function() {

};

module.exports = {
	ContextManager: ContextManager
};
