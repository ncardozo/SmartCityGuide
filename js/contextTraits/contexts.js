var cop = require("context-traits");
var POI = require("/.poi.js");


English = new cop.Context({
	name: "English"
});
English.adapt(POI.TPoiOperations, POI.TPoiEnglishOperations);


French = new cop.Context({
	name: "French"
});
French.adapt(POI.TPoiOperations, POI.TPoiFrenchOperations);

Dutch = new cop.Context({
	name: "Dutch"
});
Dutch.adapt(POI.TPoiOperations, POI.TPoiDutchOperations);

Kid = new cop.Context({
	name: "Kid"
});

KidEnglish = new cop.Context({
	name: "Kid_EN"
});
KidEnglish.adapt(POI.TPoiOperations, POI.TKidEnglishPoiOperations);

KidFrench = new cop.Context({
	name: "Kid_FR"
});
KidFrench.adapt(POI.TPoiOperations, POI.TKidFrenchPoiOperations);

KidDutch = new cop.Context({
	name: "Kid_NL"
});
KidDutch.adapt(POI.TPoiOperations, POI.TKidDutchPoiOperations);

Morning = new cop.Context({
	name: "Morning"
});
Morning.adapt(POI.TPoiOperations, POI.TMorningPoiOperations);

Afternoon = new cop.Context({
	name: "Afternoon"
});
Afternoon.adapt(POI.TPoiOperations, POI.TAfternoonPoiOperations);

Night = new cop.Context({
	name: "Night"
});
Night.adapt(POI.TPoiOperations, POI.TNightPoiOperations);
