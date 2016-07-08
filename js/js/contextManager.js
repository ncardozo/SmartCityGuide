var db = require("./DBManager.js");
var externalip = require('externalip');
var geoip = require('geoip-lite');
var POI = require("./poi.js");
var CATEGORY = require("./category.js");
var TVC = require("./toolsViewController.js");
var PVC = require("./poiViewController.js");

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
    PVC.PoiViewController.setStrategy(new PVC.ENPoiViewControllerStrategy());
  } else if(this.currentLanguage == "FR") {
    POI.Poi.setStrategy(new POI.FrenchPoiStrategy());
    CATEGORY.Category.setStrategy(new CATEGORY.FrenchCategoryStrategy());
    PVC.PoiViewController.setStrategy(new PVC.FRPoiViewControllerStrategy());
  } else if(this.currentLanguage == "NL") {
    POI.Poi.setStrategy(new POI.DutchPoiStrategy());
    CATEGORY.Category.setStrategy(new CATEGORY.DutchCategoryStrategy());
    PVC.PoiViewController.setStrategy(new PVC.NLPoiViewControllerStrategy());
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
