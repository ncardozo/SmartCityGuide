var inquirer = require('inquirer');
var POI = require("./poi.js");
var ITINERARY = require("./itinerary.js");
var CATEGORY = require("./category.js");
var TOWN = require("./town.js");
var GUIDEDVISIT = require("./guidedVisit.js");
var GVMC = require("./guidedVisitMapController.js");
var MVC = require("./menuViewController.js");
var PVC = require("./poiViewController.js");

var questions = [{
    type: 'list',
    name: 'toplevel',
    message: 'Mobile City Guide UI \n Please select one of the following options',
    choices: ["Create Itinerary", "Menu", new inquirer.Separator(),"Exit"]
  }, {
    name: 'citylevel',
    type: 'input',
    message: 'Enter the name of the city',
    when: function(answer) {
      return answer.toplevel == "Create Itinerary";
    },
    filter: function(val) {
      return val;
    },
  }, {
    type: 'checkbox',
    name: 'itinerarylevel',
    message: 'Which POIs do you want to add to your itinerary?',
    choices: [{name: "a"}, {name:"b"}, {name: "c"}, {name: "d"}, {name: "e"}],
    validate: function(answers) {
      if(answers.length < 1) {
        return "You must chose a city";
      }
      return answers;
    }
  }, {
    type: 'list',
    name: 'menuOptions',
    choices: ["Time", "Language", "Visit Type"],
    when: function(answer) {
      return answer.toplevel == "Menu" ;
    }
  }, {
    type: 'checklist',
    name: "TimeOfDay",
    choices: [{name: "Morning"}, {name:"Afternoon"}, {name: "Night"}],
    when: function(answer) {
      return answer.menuOptions == "Time";
    }
  }, {
    type: 'checklist',
    name: "language",
    choices: [{name: "English"}, {name:"French"}, {name: "Dutch"}],
    when: function(answer) {
      return answer.menuOptions == "Language";
    }
  }, {
    type: 'checklist',
    name: "visitType",
    choices: [{name: "GuidedTour"}, {name:"FreeVisit"}],
    when: function(answer) {
      return answer.menuOptions == "Visit Type";
    }
  }];

function main() {
  inquirer.prompt([{type: 'rawlist', name: "test", message: "Choose", choices: ["a", "b", "c"]}]).then(function (answers) {
    console.log(JSON.stringify(answers, null, '  '));
    if(answers.toplevel == "Menu") {
      if(answers.menuOptions == "Time") {
        POI.Poi.setStrategy(eval("new POI." + answers.TimeOfDay + "PoiStrategy()"));
      } else if(answers.menuOptions == "Language") {
        POI.Poi.setStrategy(eval("new POI." + answers.language + "PoiStrategy()"));
        ITINERARY.Itinerary.setStrategy(eval("new ITINERARY." + answers.language + "ItineraryStrategy()"));
        CATEGORY.Category.setStrategy(eval("new CATEGORY." + answers.language + "CategoryStrategy()"));
        TOWN.Town.setStrategy(eval("new TOWN." + answers.language + "TownStrategy()"));
        GUIDEDVISIT.GuidedVisit.setStrategy(eval("new GUIDEDVISIT." + answers.language + "GuidedVisitStrategy()"));
        PVC.PoiViewController.setStrategy(eval("new PVC."+answers.language+"PoiViewControllerStrategy()"));
      } else if(answers.menuOptions == "Visit Type") {
        GVMC.GuidedVisitMapController.setStrategy(eval("new GVMC."+answers.visitType+"GuidedVisitMapControllerStrategy()"));
        MVC.MenuViewController.setStrategy(eval("new MVC."+answers.visitType+"MenuViewControllerStrategy()"));
        PVC.PoiViewController.setStrategy(eval("new PVC."+answers.visitType+"PoiViewControllerStrategy()"));
      }
    }
  });
}

main();
