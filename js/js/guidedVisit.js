var Trait = require('traits.js').Trait;
var ContextManager = require("./contextManager.js");


TGuidedVisitOperations = Trait({
	addDescription: function(lang, desc) {
		this.description[lang] = desc;
	},
	getDescription: function() {
		return this.description[this.currentLanguage];
	},
	setLanguage: function(lang) {
		this.currentLanguage = lang;
	},
	updateItineraries: function() {
		
	},
	addPoiAnnotations: function() {
		var pois = this.currentIninerary.itineraryPOIs;
		for(i=0; i<pois.length; i++) {
			var poi = pois[i];
			var pos = [poi.latitude, poi.longitude];
			this.annotations[pos] = {
										"poi": poi.name[poi.language]},
										"state": poi.state
									};
		}
	},
	setItinerary: function(id) {
		if(typeof this.itineraryList[id] !== 'undefined') {
			this.currentItinerary = this.itineraryList[id];
		}
	},
	checkNearestPoit: function() {
		
	},
	refreshAnnotations: function() {
		
	},
	hideItineraryChoice: function(choice) {
		
	},
	nextPoi: function() {
		
	},
	cancelItinerary: function() {
		
	}
});


function TGuidedVisit(itList, newAnnotations, currentIti, currentPoi) {
	return Trait.compose(TGuidedVisitOperations, 
		Trait({
			itineraryList: [],
			currentLanguage: "en",
			description: new Map(),
			annotations: new Map(),  //map view annotated with all pois {(lat, long), annotation}
			currentItinerary: currentIti, //int
			currentPOI: currentPoi
		}));
}

function GuidedVisit() {
	return Object.create(Object.prototype, TGuidedVisit)
}