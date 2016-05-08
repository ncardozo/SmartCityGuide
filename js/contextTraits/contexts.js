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
