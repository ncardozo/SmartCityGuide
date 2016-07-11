var db = require("./DBManager.js");
var externalip = require('externalip');
var geoip = require('geoip-lite');
var POI = require("./poi.js");
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
    English.activate();
  } else if(this.currentLanguage == "FR") {
    French.activate();
  } else if(this.currentLanguage == "NL") {
    Dutch.activate();
  }
};

ContextManager.prototype.updateAudience = function(audience) {
  if(audience == "KID") {
    Kid.activate();
    if(this.currentLanguage == "EN") {
      KidEnglish.activate();
    } else if(this.currentLanguage == "FR") {
      KidFrench.activate();
    } else if(this.currentLanguage == "NL") {
      KidDutch.activate();
    }
  } else {
    Kid.deactivate();
  }
};

ContextManager.prototype.updateDate = function() {
  this.currentDay = new Date();
  var hour = this.currentDay.getHours();
  if(hour < 12) {
    Morning.activate();
  } else if(hour < 18) {
    Afternoon.activate();
  } else {
    Night.activate();
  }
};

ContextManager.prototype.updateConnectivityStatus = function(type) {
  if(type === "WIFI") {
    Wifi.activate();
  } else if(type === "CELLULAR") {
    Celullar.activate();
  } else if(type === "NONE") {
    Wifi.deactivate();
    Celullar.deactivate();
  }
};

ContextManager.prototype.updateMemory = function() {

};

module.exports = {
	ContextManager: ContextManager
};
