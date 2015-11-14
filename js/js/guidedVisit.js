var Trait = require('traits.js').Trait;

TGuidedVisitOperations = Trait({
	updateItineraries: function() {
		
	},
	addPoiAnnotations: function() {
		
	},
	setItinerary: function() {
		
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
			itinerariList: [],
			annotations: [],
			currentItinerary: currentIti, //int
			currentPOI: currentPoi
		}));
}

function GuidedVisit() {
	return Object.create(Object.prototype, TGuidedVisit)
}