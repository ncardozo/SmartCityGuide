var Schedule = require("./../schedule.js");
var test = require("unit.js");


function testScheduleCreate() {
	var s = Schedule();
	test.assert.equal(s.openingTimes.size, 0, 'Schedules are created with an empty map');
}

function testScheduleModification() {
	var s = Schedule(new Date(Date.now).getDay());
	var map = new Map();
	var start = new Date();
	var end = new Date();
	start.setHours(09);
	start.setMinutes(00);
	end.setHours(17);
	end.setMinutes(30);
	map.set(1, {"opening": start, "closing": end});
	map.set(2, {"opening": start, "closing": end});
	map.set(3, {"opening": start, "closing": end});
	end.setHours(20);
	end.setMinutes(00);
	map.set(4, {"opening": start, "closing": end});
	end.setHours(18);
	map.set(5, {"opening": start, "closing": end});
	end.setHours(13);
	map.set(6, {"opening": start, "closing": end});
	start.setHours(00);
	start.setMinutes(00);
	end.setHours(00);
	end.setMinutes(00);
	map.set(7, {"opening": start, "closing": end});
	s.setOpeningTimes(map);
	test.assert.equal(s.openingTimes.size, 7, 'The Week schedule can be updated with 7 entries');
}

console.log("Schedule Creation");
testScheduleCreate();
console.log("Schedule updates");
testScheduleModification();