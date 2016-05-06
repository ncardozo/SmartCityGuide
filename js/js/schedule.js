var db = require("./DBManager.js");

var ScheduleStrategy = function() {
	this.openingTimes = new Map(); //day -> object map where object {opening: Date, closing: Date} and days are numbered
};

ScheduleStrategy.prototype.setOpeningTimes = function(newMap) {
	var self = this;
	newMap.forEach(function(key, value) {
		self.openingTimes.set(key, value);
	});
};

ScheduleStrategy.prototype.changeOpeningTime = function(day, start, end) {
	var s = this.openingTimes.get(day);
	s[opening] = start;
	s[closing] = end;
	this.openingTimes.set(dat, s);
};

ScheduleStrategy.prototype.isInSchedule = function(date) {
	var times = this.openingTimes.get(date.getDay());
	if(times[opening].getHours() <= date.getHours() && times[closing].getHours() >= date.getHours()) {
		return true;
	}
	return false;
};


var Schedule = function(strategy) {
	this.strategy = strategy;
};


module.exports = {
	Schedule: Schedule,
	ScheduleStrategy: ScheduleStrategy
};
