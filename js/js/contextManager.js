var db = require("./DBManager.js");
var externalip = require('externalip');
var geoip = require('geoip-lite');
var POI = require("./poi.js");

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
  } else if(this.currentLanguage == "FR") {
    POI.Poi.setStrategy(new POI.FrenchPoiStrategy());
  } else if(this.currentLanguage == "NL") {
    POI.Poi.setStrategy(new POI.DutchPoiStrategy());
  }
};

ContextManager.prototype.updateAudience = function(audience) {
  if(audience == "KID") {
    if(this.currentLanguage == "EN") {
      POI.Poi.setStrategy(new POI.KidENPoiStrategy());
    } else if(this.currentLanguage == "FR") {
      POI.Poi.setStrategy(new POI.KidFRPoiStrategy());
    } else if(this.currentLanguage == "NL") {
      POI.Poi.setStrategy(new POI.KidNLPoiStrategy());
    }
  } else {
    POI.Poi.setStrategy(new POI.PoiStrategy());
  }
};

ContextManager.prototype.updateDate = function() {
  this.currentDay = new Date();
  var hour = this.currentDay.getHours();
  if(hour < 12) {
    POI.Poi.setStrategy(new POI.DayPoiStrategy());
  } else if(hour < 18) {
    POI.Poi.setStrategy(new POI.AfternoonPoiStrategy());
  } else {
    POI.Poi.setStrategy(new POI.NightPoiStrategy());
  }
};

ContextManager.prototype.updateConnectivityStatus = function() {
  var type = navigator.connection.type;
  if(type === "WIFI") {

  } else if(type === "CELLULAR") {

  } else if(type === "NONE") {

  }
};

ContextManager.prototype.updateMemory = function() {

};

module.exports = {
	ContextManager: ContextManager
};
