var Trait = require("traits.js").Trait;

var TScheduleOperations = Trait({
	setOpeningTimes: function(newMap) {
		var self = this;
		newMap.forEach(function(key, value) {
			self.openingTimes.set(key, value);
		});
	},
	changeOpeningTimes: function(day, start, end) {
		var s = this.openingTimes.get(day);
		s[opening] = start;
		s[closing] = end;
		this.openingTimes.set(dat, s);
	},
	isInSchedule: function(date) {
		var times = this.openingTimes.get(date.getDay());
		if(times[opening].getHours() <= date.getHours() && times[closing].getHours() >= date.getHours()) {
			return true;
		}
		return false;
	}
});

function TSchedule() {
	return Trait.compose(TScheduleOperations,
		Trait({
			openingTimes: new Map() //day -> object map where object {opening: Date, closing: Date} and days are numbered
		}));
}

function Schedule() {
	return Object.create(Object.prototype, TSchedule());
}

module.exports = Schedule;