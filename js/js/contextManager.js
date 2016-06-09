var db = require("./DBManager.js");
var externalip = require('externalip');
var geoip = require('geoip-lite');
var POI = require("./poi.js");

var ContextManager = function() {
  this.currentLocation = [];
  this.currentDay = new Date();
};

ContextManager.prototype.updateLocation = function() {
  var extIp;
  externalip(function (err, ip) {
    extIp = ip;
  });
  this.currentLocation = geoip.lookup(extIp);
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
  if(type === "wifi") {

  } else if(type === "cellular") {

  } else if(type === "none") {

  }
};

ContextManager.prototype.updateMemory = function() {
  
};
